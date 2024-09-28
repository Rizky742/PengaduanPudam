import 'package:dartz/dartz.dart';
import 'package:pengaduan/core/error/failure.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/penugas.dart';
import 'package:pengaduan/features/pengaduan/domain/repository/pengaduan_repository.dart';

class SendPenugasan {
  final PengaduanRepository pengaduanRepository;

  SendPenugasan(this.pengaduanRepository);
  Future<Either<Failure, Penugasan>> call({
    required int idKepala,
    required int idPetugas,
    required int idPengaduan,
    required DateTime tglTarget,
  }) async {
    return await pengaduanRepository.sendPenugasan(
        idKepala: idKepala,
        idPetugas: idPetugas,
        idPengaduan: idPengaduan,
        tglTarget: tglTarget);
  }
}
