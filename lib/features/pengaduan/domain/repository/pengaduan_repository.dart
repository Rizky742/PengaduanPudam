import 'package:dartz/dartz.dart';
import 'package:pengaduan/core/error/failure.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/pengaduan.dart';
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
}
