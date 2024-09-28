import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pengaduan/core/error/failure.dart';
import 'package:pengaduan/features/pengaduan/data/datasources/pengaduan_remote_datasource.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/penugas.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/jenis_penyelesaian.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/pengaduan.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/penyelesaian.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/petugas.dart';
import 'package:pengaduan/features/pengaduan/domain/repository/pengaduan_repository.dart';

class PengaduanRepositoryImpl implements PengaduanRepository {
  final PengaduanRemoteDatasource remoteDatasource;

  PengaduanRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, List<Pengaduan>>> getPengaduan(
      {required String month,
      required String year,
      required String role,
      required String id}) async {
    try {
      final periode = await remoteDatasource.getPengaduan(
          month: month, year: year, id: id, role: role);
      // print(periode);
      return right(periode);
    } catch (e) {
      if (e is ServerFailure) {
        return left(e);
      } else if (e is NetworkFailure) {
        return left(e);
      } else {
        return left(ServerFailure('An unexpected error occurred'));
      }
    }
  }

  @override
  Future<Either<Failure, List<Petugas>>> getPetugas(
      {required String divisiId}) async {
    try {
      final petugas = await remoteDatasource.getPetugas(divisiId: divisiId);
      return right(petugas);
    } catch (e) {
      if (e is ServerFailure) {
        return left(e);
      } else if (e is NetworkFailure) {
        return left(e);
      } else {
        return left(ServerFailure('An unexpected error occurred'));
      }
    }
  }

  @override
  Future<Either<Failure, List<JenisPenyelesaian>>>
      getJenisPenyelesaian() async {
    try {
      final getPenyelesaian = await remoteDatasource.getJenisPenyelesaian();
      return right(getPenyelesaian);
    } catch (e) {
      if (e is ServerFailure) {
        return left(e);
      } else if (e is NetworkFailure) {
        return left(e);
      } else {
        return left(ServerFailure('An unexpected error occurred'));
      }
    }
  }

  @override
  Future<Either<Failure, Penugasan>> sendPenugasan(
      {required int idKepala,
      required int idPetugas,
      required int idPengaduan,
      required DateTime tglTarget}) async {
    // TODO: implement sendPenugasan
    try {
      final sendData = await remoteDatasource.sendPenugasan(
          idKepala: idKepala,
          idPetugas: idPetugas,
          idPengaduan: idPengaduan,
          tglTarget: tglTarget);
      return right(sendData);
    } catch (e) {
      if (e is ServerFailure) {
        return left(e);
      } else if (e is NetworkFailure) {
        return left(e);
      } else {
        return left(ServerFailure('An unexpected error occurred'));
      }
    }
  }

  @override
  Future<Either<Failure, Penugasan>> getPenugasan(
      {required int idPengaduan}) async {
    try {
      final getData =
          await remoteDatasource.getPenugasan(idPengaduan: idPengaduan);
      return right(getData);
    } catch (e) {
      if (e is ServerFailure) {
        return left(e);
      } else if (e is NetworkFailure) {
        return left(e);
      } else {
        return left(ServerFailure('An unexpected error occurred'));
      }
    }
  }

  @override
  Future<Either<Failure, Penyelesaian>> sendPenyelesaian(
      {required File image,
      required String pengaduanId,
      required String petugasId,
      required String keteranganSelesain,
      required String jenisPenyelesaianId}) async {

    try {
      final sendPenyelesaian = await remoteDatasource.sendPenyelesaian(
          image: image,
          pengaduanId: pengaduanId,
          petugasId: petugasId,
          keteranganSelesain: keteranganSelesain,
          jenisPenyelesaianId: jenisPenyelesaianId);
      return right(sendPenyelesaian);
    } catch (e) {
      if (e is ServerFailure) {
        return left(e);
      } else if (e is NetworkFailure) {
        return left(e);
      } else {
        return left(ServerFailure('An unexpected error occurred'));
      }
    }
  }

  @override
  Future<Either<Failure, Penyelesaian>> getPenyelesaianById(
      {required String id}) async {
    try {
      final getPenyelesaianById =
          await remoteDatasource.getPenyelesaianById(id: id);
          // print(getPenyelesaianById);
      return right(getPenyelesaianById);
    } catch (e) {
         
      if (e is ServerFailure) {
        return left(e);
      } else if (e is NetworkFailure) {
        return left(e);
      } else {
        return left(ServerFailure('An unexpected error occurred'));
      }
    }
  }
}
