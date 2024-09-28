import 'package:dartz/dartz.dart';
import 'package:pengaduan/core/error/failure.dart';
import 'package:pengaduan/features/home/domain/entities/dashboard.dart';
import 'package:pengaduan/features/home/domain/entities/periode.dart';

abstract interface class DashboardRepository {
  Future<Either<Failure, Dashboard>> getDashboardByPeriode({
    required String month,
    required String year,
    required int divisiId,
    required String petugasId
  });
  Future<Either<Failure, List<Periode>>> getPeriode();
}
