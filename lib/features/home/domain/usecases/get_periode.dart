import 'package:dartz/dartz.dart';
import 'package:pengaduan/core/error/failure.dart';
import 'package:pengaduan/features/home/domain/entities/periode.dart';
import 'package:pengaduan/features/home/domain/repository/dashboard_repository.dart';

class GetPeriode {
  final DashboardRepository dashboardRepository;

  GetPeriode(this.dashboardRepository);

  Future<Either<Failure, List<Periode>>> call() async {
    return await dashboardRepository.getPeriode();
  }
}
