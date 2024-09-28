import 'package:dartz/dartz.dart';
import 'package:pengaduan/core/error/failure.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/jenis_penyelesaian.dart';
import 'package:pengaduan/features/pengaduan/domain/repository/pengaduan_repository.dart';

class GetJenisPenyelesaian {
  final PengaduanRepository pengaduanRepository;

  GetJenisPenyelesaian(this.pengaduanRepository);

  Future<Either<Failure, List<JenisPenyelesaian>>> call() async {
    return await pengaduanRepository.getJenisPenyelesaian();
  }
}
