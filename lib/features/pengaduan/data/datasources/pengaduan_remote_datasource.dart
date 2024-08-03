import 'dart:convert';

import 'package:pengaduan/core/env.dart';
import 'package:pengaduan/core/error/failure.dart';
import 'package:pengaduan/core/exception/custom_exception.dart';
import 'package:http/http.dart' as http;
import 'package:pengaduan/features/pengaduan/data/models/pengaduan_model.dart';
import 'package:pengaduan/features/pengaduan/data/models/petugas_model.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/pengaduan.dart';
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
}

class PengaduanRemoteDatasourceImpl implements PengaduanRemoteDatasource {
  @override
  Future<List<PengaduanModel>> getPengaduan(
      {required String month,
      required String year,
      required String role,
      required String id}) async {
    try {
      final petugas =
          Uri.parse("$baseUrl/penugasan-pengaduan").replace(queryParameters: {
        'month': month,
        'year': year,
        'petugasId': id,
      });
      final kepala =
          Uri.parse("$baseUrl/penugasan-pengaduan").replace(queryParameters: {
        'month': month,
        'year': year,
        'divisiId': id,
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
        throw ServerFailure('An unexpected error occurred');
      }
    }
  }

  @override
  Future<List<PetugasModel>> getPetugas({required String divisiId}) async {
    try {
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
}
