import 'package:pengaduan/features/pengaduan/domain/entitites/jenis_penyelesaian.dart';

class JenisPenyelesaianModel extends JenisPenyelesaian {
  JenisPenyelesaianModel({
    required super.id,
    required super.nama,
    required this.isActive,
  });
  final bool isActive;

  factory JenisPenyelesaianModel.fromJson(Map<String, dynamic> json) {
    return JenisPenyelesaianModel(
        id: json['id'],
        nama: json['nama_penyelesaian'],
        isActive: json['is_active']);
  }
}
