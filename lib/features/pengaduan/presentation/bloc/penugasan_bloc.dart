import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'penugasan_event.dart';
part 'penugasan_state.dart';

class PenugasanBloc extends Bloc<PenugasanEvent, PenugasanState> {
  PenugasanBloc() : super(PenugasanInitial()) {
    on<LoadPenugasan>((event, emit) {
      emit(PenugasanLoaded(
          selectedPetugas: '',
          selectedDay: '',
          selectedMonth: '',
          selectedYear: ''));
    });

    on<SelectPetugas>(
      (event, emit) {
        final currentstate = state;
        if (currentstate is PenugasanLoaded) {
          emit(currentstate.copyWith(selectedPetugas: event.petugas));
        }
      },
    );
    
  }
}
