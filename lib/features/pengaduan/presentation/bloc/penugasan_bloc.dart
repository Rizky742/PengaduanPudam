import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/petugas.dart';

part 'penugasan_event.dart';
part 'penugasan_state.dart';

class PenugasanBloc extends Bloc<PenugasanEvent, PenugasanState> {
  PenugasanBloc()
      : super(PenugasanLoaded(
        selectedPetugas: null,
            selectedDay: '',
            selectedMonth: '',
            selectedYear: '')) {
    on<SelectPetugas>(
      (event, emit) {
        final currentstate = state;
        if (currentstate is PenugasanLoaded) {
          emit(currentstate.copyWith(selectedPetugas: event.petugas));
        }
      },
    );

    on<SelectDate>(
      (event, emit) {
        final currentstate = state;
        if (currentstate is PenugasanLoaded) {
          emit(currentstate.copyWith(
              selectedYear: event.year,
              selectedMonth: event.month,
              selectedDay: event.day));
        }
      },
    );
  }
}
