

import 'package:pengaduan/features/pengaduan/domain/entitites/pengaduan.dart';

class PengaduanModel extends Pengaduan {
  PengaduanModel(
      {required super.nama,
      required super.noPelanggan,
      required super.noAduan,
      required super.noTelepon,
      required super.alamat,
      required super.isProcessed,
      required super.idAduan,
      required super.isComplete,
      required super.status,
      required super.jenisAduan,
      required super.keterangan});

  factory PengaduanModel.fromJson(Map<String, dynamic> json) {
    final bool isProcessed = json['pengaduan']['is_processed'] ?? '';
    final bool isComplete = json['pengaduan']['is_complete'] ?? '';
    final String status = _determineStatus(isProcessed, isComplete);
    return PengaduanModel(
       idAduan: json['pengaduan']['id'] ?? '',
        nama: json['pengaduan']['nama'] ?? '',
        noPelanggan:
            json['pengaduan']['pelanggan'] != null ? json['pengaduan']['pelanggan']['no_pelanggan'] : '',
        noTelepon: json['pengaduan']['no_telp'] ?? '',
        noAduan: json['pengaduan']['nomor'] ?? '',
        alamat: json['pengaduan']['alamat'] ?? '',
        isProcessed: isProcessed,
        isComplete: isComplete,
        jenisAduan: json['pengaduan']['jenis_aduan']['nama'],
        keterangan: json['pengaduan']['keterangan'],
        status: status);
  }

  static String _determineStatus(bool isProcessed, bool isComplete) {
    if (!isProcessed) {
      return 'Belum Ditugaskan';
    } else if (isProcessed) {
      return 'Ditugaskan';
    } else if (!isComplete) {
      return 'Belum Diselesaikan';
    } else {
      return 'Diselesaikan';
    }
  }
}
