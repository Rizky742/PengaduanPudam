import 'package:dartz/dartz.dart';
import 'package:pengaduan/core/error/failure.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/pengaduan.dart';
import 'package:pengaduan/features/pengaduan/domain/repository/pengaduan_repository.dart';

class GetPengaduan {
  final PengaduanRepository pengaduanRepository;

  GetPengaduan(this.pengaduanRepository);

  Future<Either<Failure, List<Pengaduan>>> call({
    required String month,
    required String year,
    required String role,
    required String id,
  }) async {
    // print(await pengaduanRepository.getPengaduan(month: month, year: year));
    return await pengaduanRepository.getPengaduan(month: month, year: year, id: id, role: role);
  }
}
