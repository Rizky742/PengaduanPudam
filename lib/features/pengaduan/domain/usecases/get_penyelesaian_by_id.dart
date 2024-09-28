import 'package:dartz/dartz.dart';
import 'package:pengaduan/core/error/failure.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/penyelesaian.dart';
import 'package:pengaduan/features/pengaduan/domain/repository/pengaduan_repository.dart';

class GetPenyelesaianById {
  final PengaduanRepository pengaduanRepository;

  GetPenyelesaianById(this.pengaduanRepository);

  Future<Either<Failure, Penyelesaian>> call({required String id}) async {
    return await pengaduanRepository.getPenyelesaianById(id: id);
  }
}
