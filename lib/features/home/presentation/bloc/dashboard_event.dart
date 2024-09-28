part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

final class GetDashboardEvent extends DashboardEvent {
  final String month;
  final String year;
  final int divisiId;
  final String petugasId;

  GetDashboardEvent(this.month, this.year, this.divisiId, this.petugasId);
}

final class SetPeriodeEvent extends DashboardEvent {
  final String month;
  final String year;

  SetPeriodeEvent(this.month, this.year);
}
