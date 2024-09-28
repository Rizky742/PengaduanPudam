import 'package:intl/intl.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/penyelesaian.dart';

class PenyelesaianModel extends Penyelesaian {
  PenyelesaianModel(
      {required super.fotoPenyelesaian,
      required super.targetPenyelesaian,
      required super.tglSelesai,
      required super.nama,
      required super.noPelanggan,
      required super.ditugaskanOleh,
      required super.noAduan,
      required super.idAduan,
      required super.jenisPenyelesaian,
      required super.noTelepon,
      required super.ditugaskanKepada,
      required super.alamat,
      required super.status,
      required super.jenisAduan,
      required super.keterangan});

  factory PenyelesaianModel.fromJson(Map<String, dynamic> json) {
    final targetPenyelesaian = DateTime.parse(json['tgl_target']).toLocal();
    final tanggalSelesai = DateTime.parse(json['completed_at']).toLocal();
    final targetPenyelesaianFormatted =
        DateFormat('dd MMMM yyyy', 'id_ID').format(targetPenyelesaian);
    final tanggalSelesaiFormatted =
        DateFormat('dd MMMM yyyy', 'id_ID').format(tanggalSelesai);
        // print( json['petugas']['nama'] );
        print(json['penugasan_pengaduan'][0]['penugasan']['divisi']['petugas'][0]['nama']);
        // print('bisaaa');
    return PenyelesaianModel(
      ditugaskanKepada: json['petugas']['nama'] ?? '',
      fotoPenyelesaian: json['foto_penyelesaian'] ?? '',
      targetPenyelesaian: targetPenyelesaianFormatted,
      tglSelesai: tanggalSelesaiFormatted,
      nama: json['nama'] ?? '',
      noPelanggan:
          json['pelanggan'] != null ? json['pelanggan']['no_pelanggan'] ?? '' : '',
      noAduan: json['nomor'] ?? '',
      idAduan: json['id'] ?? '',
      noTelepon: json['no_telp'] ?? '',
      jenisPenyelesaian: json['jenis_penyelesaian']['nama_penyelesaian'] ?? '',
      alamat: json['alamat'] ?? '',
      status: json['Diselesaikan'] ?? '',
      jenisAduan: json['jenis_aduan']['nama'] ?? '',
      keterangan: json['keterangan'] ?? '',
      ditugaskanOleh: json['penugasan_pengaduan'][0]['penugasan']['divisi']['petugas'][0]['nama'] ?? ''
      // ditugaskanOleh: 'sdfsdf'
    );
  }
}
