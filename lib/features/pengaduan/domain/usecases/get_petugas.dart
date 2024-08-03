import 'package:dartz/dartz.dart';
import 'package:pengaduan/core/error/failure.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/petugas.dart';
import 'package:pengaduan/features/pengaduan/domain/repository/pengaduan_repository.dart';

class GetPetugas {
  final PengaduanRepository pengaduanRepository;

  GetPetugas(this.pengaduanRepository);

  Future<Either<Failure, List<Petugas>>> call(
      {required String divisiId}) async {
    return await pengaduanRepository.getPetugas(divisiId: divisiId);
  }
}
