import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'periode_event.dart';
part 'periode_state.dart';

class PeriodeBloc extends Bloc<PeriodeEvent, PeriodeState> {
  PeriodeBloc() : super(PeriodeInitial()) {
    on<PeriodeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
