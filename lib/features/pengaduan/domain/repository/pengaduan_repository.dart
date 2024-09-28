import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:pengaduan/core/error/failure.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/penugas.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/jenis_penyelesaian.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/pengaduan.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/penyelesaian.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/petugas.dart';

abstract interface class PengaduanRepository {
  Future<Either<Failure, List<Pengaduan>>> getPengaduan({
    required String month,
    required String year,
    required String role,
    required String id,
  });

  Future<Either<Failure, List<Petugas>>> getPetugas({
    required String divisiId,
  });

  Future<Either<Failure, Penugasan>> sendPenugasan({
    required int idKepala,
    required int idPetugas,
    required int idPengaduan,
    required DateTime tglTarget,
  });

  Future<Either<Failure, List<JenisPenyelesaian>>> getJenisPenyelesaian();

  Future<Either<Failure, Penugasan>> getPenugasan({
    required int idPengaduan,
  });

  Future<Either<Failure, Penyelesaian>> sendPenyelesaian({
    required File image,
    required String pengaduanId,
    required String petugasId,
    required String keteranganSelesain,
    required String jenisPenyelesaianId,
  });
  
  Future<Either<Failure, Penyelesaian>> getPenyelesaianById({
    required String id
  });
}
