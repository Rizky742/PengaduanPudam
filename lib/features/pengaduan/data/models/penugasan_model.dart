import 'package:intl/intl.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/penugas.dart';

class PenugasanModel extends Penugasan {
  PenugasanModel(
      {required super.nama,
      required super.noPelanggan,
      required super.noAduan,
      required super.idAduan,
      required super.noTelepon,
      required super.alamat,
      required super.status,
      required super.jenisAduan,
      required super.keterangan,
      required super.petugas,
      required super.tanggal, required super.targetPenyelesaian, required super.jenisLaporan});
  factory PenugasanModel.fromJson(Map<String, dynamic> json) {
    final tanggal = DateTime.parse(json['processed_at']).toLocal();
    final tanggalFormated = DateFormat('dd MMMM yyyy', 'id_ID').format(tanggal);
    final targetPenyelesaian = DateTime.parse(json['tgl_target']).toLocal();
    final targetPenyelesaianFormatted = DateFormat('dd MMMM yyyy', 'id_ID').format(targetPenyelesaian);

    return PenugasanModel(
      nama: json['nama'],
      noPelanggan:
          json['pelanggan'] != null ? json['pelanggan']['no_pelanggan'] : '',
      noAduan: json['nomor'] ?? '',
      idAduan: json['id'] ?? '',
      noTelepon: json['no_telp'] ?? '',
      alamat: json['alamat'] ?? '',
      status: 'Ditugaskan',
      jenisAduan: json['jenis_aduan']['nama'] ?? '',
      keterangan: json['keterangan'] ?? '',
      petugas: json['petugas']['nama'] ?? '',
      tanggal: tanggalFormated,
      targetPenyelesaian: targetPenyelesaianFormatted,
      jenisLaporan: json['jenis_aduan']['nama'] ?? ''
    );
  }
}
