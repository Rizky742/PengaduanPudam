import 'dart:convert';
import 'dart:io';

import 'package:pengaduan/core/env.dart';
import 'package:pengaduan/core/error/failure.dart';
import 'package:pengaduan/core/exception/custom_exception.dart';
import 'package:http/http.dart' as http;
import 'package:pengaduan/features/pengaduan/data/models/jenis_penyelesaian_model.dart';
import 'package:pengaduan/features/pengaduan/data/models/pengaduan_model.dart';
import 'package:pengaduan/features/pengaduan/data/models/penugasan_model.dart';
import 'package:pengaduan/features/pengaduan/data/models/penyelesaian_model.dart';
import 'package:pengaduan/features/pengaduan/data/models/petugas_model.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/penugas.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/jenis_penyelesaian.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/pengaduan.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/penyelesaian.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/petugas.dart';

abstract interface class PengaduanRemoteDatasource {
  Future<List<Pengaduan>> getPengaduan({
    required String month,
    required String year,
    required String role,
    required String id,
  });

  Future<List<Petugas>> getPetugas({
    required String divisiId,
  });

  Future<List<JenisPenyelesaian>> getJenisPenyelesaian();

  Future<Penugasan> sendPenugasan({
    required int idKepala,
    required int idPetugas,
    required int idPengaduan,
    required DateTime tglTarget,
  });

  Future<Penugasan> getPenugasan({
    required int idPengaduan,
  });

  Future<Penyelesaian> sendPenyelesaian({
    required File image,
    required String pengaduanId,
    required String petugasId,
    required String keteranganSelesain,
    required String jenisPenyelesaianId,
  });

  Future<Penyelesaian> getPenyelesaianById({
    required String id,
  });
}

class PengaduanRemoteDatasourceImpl implements PengaduanRemoteDatasource {
  @override
  Future<List<PengaduanModel>> getPengaduan(
      {required String month,
      required String year,
      required String role,
      required String id}) async {
    try {
      String baseUrl = await getBaseUrl();
      final petugas = Uri.parse("$baseUrl/penugasan-pengaduan").replace(
          queryParameters: {
            'month': month,
            'year': year,
            'petugasId': id,
            'filter': 'semua_data'
          });
      final kepala = Uri.parse("$baseUrl/penugasan-pengaduan").replace(
          queryParameters: {
            'month': month,
            'year': year,
            'divisiId': id,
            'filter': 'semua_data'
          });
      final response =
          await http.get(role.toLowerCase() == 'kepala' ? kepala : petugas);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body)['data'];
        List<PengaduanModel> pengaduan =
            data.map((e) => PengaduanModel.fromJson(e)).toList();
        return pengaduan;
      } else {
        throw ServerException('Server error');
      }
    } catch (e) {
      if (e is ServerException) {
        throw ServerFailure(e.message);
      } else if (e is http.ClientException) {
        throw NetworkFailure('Network error');
      } else {
        throw ServerFailure(e.toString());
      }
    }
  }

  @override
  Future<List<PetugasModel>> getPetugas({required String divisiId}) async {
    try {
      String baseUrl = await getBaseUrl();
      final url =
          Uri.parse("$baseUrl/get/petugas-divisi").replace(queryParameters: {
        'divisiId': divisiId,
      });
      final response = await http.get(url);
      if (response.statusCode != 200) {
        throw ServerException('Server Error');
      }
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['code'] == 221) {
          throw ServerException('Tidak ada divisi id dengan id $divisiId');
        }
      }
      List data = jsonDecode(response.body)['data'];
      List<PetugasModel> pengaduan =
          data.map((e) => PetugasModel.fromJson(e)).toList();
      return pengaduan;
    } catch (e) {
      if (e is ServerException) {
        throw ServerFailure(e.message);
      } else if (e is http.ClientException) {
        throw NetworkFailure('Network error');
      } else {
        throw ServerFailure('An unexpected error occurred');
      }
    }
  }

  @override
  Future<List<JenisPenyelesaian>> getJenisPenyelesaian() async {
    try {
      String baseUrl = await getBaseUrl();
      final url = Uri.parse("$baseUrl/jenis-penyelesaian");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body)['data'];
        List<JenisPenyelesaianModel> penyelesaian = data
            .map(
              (e) => JenisPenyelesaianModel.fromJson(e),
            )
            .toList();
        List<JenisPenyelesaianModel> penyelesaianFilter = penyelesaian
            .where(
              (element) => element.isActive == true,
            )
            .toList();
        return penyelesaianFilter;
      } else {
        throw ServerException('Server error');
      }
    } catch (e) {
      if (e is ServerException) {
        throw ServerFailure(e.message);
      } else if (e is http.ClientException) {
        throw NetworkFailure('Network error');
      } else {
        throw ServerFailure(e.toString());
      }
    }
  }

  @override
  Future<Penugasan> sendPenugasan(
      {required int idKepala,
      required int idPetugas,
      required int idPengaduan,
      required DateTime tglTarget}) async {
    try {
      String baseUrl = await getBaseUrl();
      var url = Uri.parse("$baseUrl/penugasan-petugas");
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'ditugaskanOleh': idKepala,
            'petugasId': idPetugas,
            'pengaduanId': idPengaduan,
            'tglTarget': tglTarget.toUtc().toIso8601String(),
          },
        ),
      );
      if (response.statusCode == 200) {
        return PenugasanModel.fromJson(jsonDecode(response.body)['data']);
      } else {
        throw ServerException(response.body);
      }
    } catch (e) {
      if (e is ServerException) {
        throw ServerFailure(e.message);
      } else if (e is http.ClientException) {
        throw NetworkFailure('Network error');
      } else {
        throw ServerFailure(e.toString());
      }
    }
  }

  @override
  Future<Penugasan> getPenugasan({required int idPengaduan}) async {
    try {
      String baseUrl = await getBaseUrl();
      final url =
          Uri.parse("$baseUrl/penugasan-petugas").replace(queryParameters: {
        'pengaduanId': idPengaduan.toString(),
      });
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return PenugasanModel.fromJson(jsonDecode(response.body)['data']);
      } else {
        throw ServerException(response.body);
      }
    } catch (e) {
      if (e is ServerException) {
        throw ServerFailure(e.message);
      } else if (e is http.ClientException) {
        throw NetworkFailure('Network error');
      } else {
        throw ServerFailure(e.toString());
      }
    }
  }

  @override
  Future<Penyelesaian> sendPenyelesaian(
      {required File image,
      required String pengaduanId,
      required String petugasId,
      required String keteranganSelesain,
      required String jenisPenyelesaianId}) async {
    // TODO: implement sendPenyelesaian
    try {
      String baseUrl = await getBaseUrl();
      var url = Uri.parse("$baseUrl/penyelesaian");
      var request = http.MultipartRequest('POST', url);
      var multipartFile =
          await http.MultipartFile.fromPath('fotoPenyelesaian', image.path);
      request.files.add(multipartFile);
      request.fields['pengaduanId'] = pengaduanId;
      request.fields['petugasId'] = petugasId;
      request.fields['keteranganSelesain'] = keteranganSelesain;
      request.fields['jenisPenyelesaianId'] = jenisPenyelesaianId;

      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
      });

      print("Pengaduan id: $pengaduanId");
      print("Petugas id: $petugasId");
      print("image: $image");
      print("keterangan selesai: $keteranganSelesain");
      print("Jenis Penyelesaian id: $jenisPenyelesaianId");

      var response = await request.send();
      final responseBody = await response.stream.bytesToString();
      // print(responseBody);
      if (response.statusCode == 200) {
        return PenyelesaianModel.fromJson(jsonDecode(responseBody)['data']);
      } else {
        throw ServerException(responseBody);
      }
    } catch (e) {
      print(e);
      if (e is ServerException) {
        throw ServerFailure(e.message);
      } else if (e is http.ClientException) {
        throw NetworkFailure('Network error');
      } else {
        throw ServerFailure(e.toString());
      }
    }
  }

  @override
  Future<Penyelesaian> getPenyelesaianById({required String id}) async {
    try {
      String baseUrl = await getBaseUrl();
      final url =
          Uri.parse("$baseUrl/get-penyelesaian").replace(queryParameters: {
        'pengaduanId': id,
      });
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print(response.body);
        return PenyelesaianModel.fromJson(jsonDecode(response.body)['data']);
      } else {
        throw ServerException(response.body);
      }
    } catch (e) {
      if (e is ServerException) {
        throw ServerFailure(e.message);
      } else if (e is http.ClientException) {
        throw NetworkFailure('Network error');
      } else {
        print(e.toString());
        throw ServerFailure(e.toString());
      }
    }
  }
}
