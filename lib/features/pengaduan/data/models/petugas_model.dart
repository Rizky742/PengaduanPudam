import 'package:pengaduan/features/pengaduan/domain/entitites/petugas.dart';

class PetugasModel extends Petugas {
  PetugasModel({required super.id, required super.nama});

  factory PetugasModel.fromJson(Map<String, dynamic> json) {
    return PetugasModel(id: json['id'] ?? '', nama: json['nama'] ?? '');
  }
}
