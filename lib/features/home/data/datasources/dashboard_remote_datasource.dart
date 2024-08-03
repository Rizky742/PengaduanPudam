import 'dart:convert';

import 'package:pengaduan/core/env.dart';
import 'package:pengaduan/core/error/failure.dart';
import 'package:pengaduan/core/exception/custom_exception.dart';
import 'package:pengaduan/features/home/data/models/dashboard_model.dart';
import 'package:pengaduan/features/home/data/models/periode_model.dart';
import 'package:pengaduan/features/home/domain/entities/dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:pengaduan/features/home/domain/entities/periode.dart';

abstract interface class DashboardRemoteDatasource {
  Future<Dashboard> getDashboardByPeriode({
    required String month,
    required String year,
  });
  Future<List<Periode>> getPeriode();
}

class DashboardRemoteDatasourceImpl implements DashboardRemoteDatasource {
  @override
  Future<DashboardModel> getDashboardByPeriode(
      {required String month, required String year}) async {
    try {
      var url = Uri.parse("$baseUrl/home");
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'selectedPeriod': {'month': month, 'year': year}
          },
        ),
      );
      if (response.statusCode == 200) {
        return DashboardModel.fromJson(jsonDecode(response.body)['data']);
      } else {
        throw ServerException('Server error');
      }
    } catch (e) {
      if (e is ServerException) {
        throw ServerFailure(e.message);
      } else if (e is http.ClientException) {
        throw NetworkFailure('Network error');
      } else {
        throw ServerFailure('An unexpected error occurred');
      }
    }
  }

  @override
  Future<List<PeriodeModel>> getPeriode() async {
    try {
      var url = Uri.parse("$baseUrl/periode");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body)['data'];
        List<PeriodeModel> periode = data
            .map(
              (e) => PeriodeModel.fromJson(e),
            )
            .toList();
        return periode;
      } else {
        throw ServerException('Server error');
      }
    } catch (e) {
      if (e is ServerException) {
        throw ServerFailure(e.message);
      } else if (e is http.ClientException) {
        throw NetworkFailure('Network error');
      } else {
        throw ServerFailure('An unexpected error occurred');
      }
    }
  }
}
