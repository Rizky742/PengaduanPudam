part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

final class DashboardLoading extends DashboardState {}

final class DashboardLoaded extends DashboardState {
  final Dashboard dashboard;
  DashboardLoaded(this.dashboard);
}

final class DashboardLoadedPeriode extends DashboardState {
  final List<Periode> periode;
  

  DashboardLoadedPeriode(this.periode);
}

final class DashboardPeriode extends DashboardState {
  final String month;
  final String year;

  DashboardPeriode({String? month, String? year})
      : month = month ?? DateTime.now().month.toString(),
        year = year ?? DateTime.now().year.toString();
}

final class DashboardError extends DashboardState {
  final String message;

  DashboardError(this.message);
}
