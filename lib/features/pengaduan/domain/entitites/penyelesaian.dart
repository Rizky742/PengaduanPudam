import 'package:pengaduan/features/pengaduan/domain/entitites/pengaduan.dart';

class Penyelesaian extends Pengaduan {
  final String fotoPenyelesaian;
  final String targetPenyelesaian;
  final String tglSelesai;
  final String ditugaskanKepada;
  final String jenisPenyelesaian;
  final String ditugaskanOleh;
  Penyelesaian(
      {required this.fotoPenyelesaian,
      required this.ditugaskanKepada,
      required this.jenisPenyelesaian,
      required this.ditugaskanOleh,
      required this.targetPenyelesaian,
      required this.tglSelesai,
      required super.nama,
      required super.noPelanggan,
      required super.noAduan,
      required super.idAduan,
      required super.noTelepon,
      required super.alamat,
      required super.status,
      required super.jenisAduan,
      required super.keterangan});
}
