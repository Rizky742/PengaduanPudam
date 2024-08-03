import 'package:pengaduan/features/home/domain/entities/dashboard.dart';

class DashboardModel extends Dashboard {
  DashboardModel(
      {required super.belumDitugaskan,
      required super.ditugaskan,
      required super.belumDiselesaikan,
      required super.diselesaikan});

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
        belumDitugaskan: json['pengaduanBelumDitugaskan'],
        ditugaskan: json['pengaduanDitugaskan'],
        belumDiselesaikan: json['pengaduangBelumDiselesaikan'],
        diselesaikan: json['pengaduanDiselesaikan']);
  }
}
