import 'package:pengaduan/features/home/domain/entities/periode.dart';

class PeriodeModel extends Periode {
  PeriodeModel(
      {required super.value, required super.month, required super.year});

  factory PeriodeModel.fromJson(Map<String, dynamic> json) {
    return PeriodeModel(
      value: json['value'] ?? '',
      month: json['month'] ?? '',
      year: json['year'] ?? '',
    );
  }
}
