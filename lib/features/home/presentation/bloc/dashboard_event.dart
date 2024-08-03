part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

final class GetDashboardEvent extends DashboardEvent {
  final String month;
  final String year;

  GetDashboardEvent(this.month, this.year);
}

final class SetPeriodeEvent extends DashboardEvent {
  final String month;
  final String year;

  SetPeriodeEvent(this.month, this.year);
}
