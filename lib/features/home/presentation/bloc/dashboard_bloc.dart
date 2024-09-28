import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pengaduan/features/home/domain/entities/dashboard.dart';
import 'package:pengaduan/features/home/domain/entities/periode.dart';
import 'package:pengaduan/features/home/domain/usecases/get_dashboard_by_periode.dart';
import 'package:pengaduan/features/home/domain/usecases/get_periode.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboardByPeriode getDashboardByPeriode;
  final GetPeriode getPeriode;

  DashboardBloc(this.getDashboardByPeriode, this.getPeriode)
      : super(DashboardInitial()) {
    on<GetDashboardEvent>(
      (event, emit) async {
        emit(DashboardLoading());
        final getDashboard = await getDashboardByPeriode.call(
            month: event.month, year: event.year, divisiId: event.divisiId,petugasId: event.petugasId);
        getDashboard.fold(
          (failure) {
            emit(DashboardError(failure.message));
          },
          (dashboard) {
            emit(DashboardLoaded(dashboard));
          },
        );
      },
    );

    // on<GetPeriodeEvent>(
    //   (event, emit) async {
    //     print('dfssd');
    //     final periode = await getPeriode.call();
    //     periode.fold(
    //       (failure) {
    //         emit(DashboardError(failure.message));
    //       },
    //       (periode) {
    //         emit(DashboardLoadedPeriode(periode));
    //       },
    //     );
    //   },
    // );

    on<SetPeriodeEvent>(
      (event, emit) {
        emit(DashboardPeriode(month: event.month, year: event.year));
      },
    );
  }
}
