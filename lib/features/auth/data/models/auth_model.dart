import 'package:pengaduan/features/auth/domain/entities/auth.dart';

class AuthModel extends Auth {
  AuthModel(
      {required super.id,
      required super.nama,
      required super.role,
      required super.noTelp,
      required super.divisiId,
      required super.namaDivisi,
      required super.username});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json['id'] ?? '',
      nama: json['nama'] ?? '',
      role: json['role'] ?? '',
      noTelp: json['no_telp'] ?? '',
      divisiId: json['divisi_id'] ?? '',
      username: json['username'] ?? '',
      namaDivisi: json['divisi']['nama'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'role': role,
      'no_telp': noTelp,
      'divisi_id': divisiId,
      'username': username,
    };
  }
}
