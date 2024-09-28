import 'package:dartz/dartz.dart';
import 'package:pengaduan/core/error/failure.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/penugas.dart';
import 'package:pengaduan/features/pengaduan/domain/repository/pengaduan_repository.dart';

class GetPenugasan {
  final PengaduanRepository pengaduanRepository;

  GetPenugasan(this.pengaduanRepository);

  Future<Either<Failure, Penugasan>> call({
    required int idPengaduan,
  }) async {
    return await pengaduanRepository.getPenugasan(idPengaduan: idPengaduan);
  }
}
