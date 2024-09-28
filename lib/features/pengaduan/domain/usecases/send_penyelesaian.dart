import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pengaduan/core/error/failure.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/penyelesaian.dart';
import 'package:pengaduan/features/pengaduan/domain/repository/pengaduan_repository.dart';

class SendPenyelesaian {
  final PengaduanRepository pengaduanRepository;

  SendPenyelesaian(this.pengaduanRepository);

  Future<Either<Failure, Penyelesaian>> call({
    required File image,
    required String pengaduanId,
    required String petugasId,
    required String keteranganSelesain,
    required String jenisPenyelesaianId,
  }) async {
    return await pengaduanRepository.sendPenyelesaian(
        image: image,
        pengaduanId: pengaduanId,
        petugasId: petugasId,
        keteranganSelesain: keteranganSelesain,
        jenisPenyelesaianId: jenisPenyelesaianId);
  }
}
