import 'package:pengaduan/features/pengaduan/domain/entitites/pengaduan.dart';

class PengaduanModel extends Pengaduan {
  PengaduanModel(
      {required super.nama,
      required super.noPelanggan,
      required super.noAduan,
      required super.noTelepon,
      required super.alamat,
      required super.idAduan,
      required super.status,
      required super.jenisAduan,
      required super.keterangan});

  factory PengaduanModel.fromJson(Map<String, dynamic> json) {
    final telp =
        json['pengaduan']['no_telp'] == '-' ? '' : json['pengaduan']['no_telp'];
    final bool isProcessed = json['pengaduan']['is_processed'] ?? '';
    final bool isComplete = json['pengaduan']['is_complete'] ?? '';
    print(isComplete);
    final bool petugasId =
        json['pengaduan']['petugas_id'] != null ? true : false;
    final String status = _determineStatus(isProcessed, isComplete, petugasId);
    return PengaduanModel(
        idAduan: json['pengaduan']['id'] ?? '',
        nama: json['pengaduan']['nama'] ?? '',
        noPelanggan: json['pengaduan']['pelanggan'] != null
            ? json['pengaduan']['pelanggan']['no_pelanggan']
            : '',
        noTelepon: telp,
        noAduan: json['pengaduan']['nomor'] ?? '',
        alamat: json['pengaduan']['alamat'] ?? '',
        jenisAduan: json['pengaduan']['jenis_aduan']['nama'] ?? '',
        keterangan: json['pengaduan']['keterangan'] ?? '',
        status: status);
  }

  static String _determineStatus(
      bool isProcessed, bool isComplete, bool petugasId) {
    if (!petugasId && isProcessed && !isComplete) {
      return 'Belum Ditugaskan';
    } else if (isProcessed && petugasId && !isComplete) {
      return 'Ditugaskan';
    } else if (!isComplete) {
      return "Belum Diselesaikan";
    } else{
      return "Diselesaikan";
    }
  }
}
