import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/penugas.dart';
import 'package:pengaduan/features/pengaduan/domain/usecases/get_penugasan.dart';

part 'get_penugasan_event.dart';
part 'get_penugasan_state.dart';

class GetPenugasanBloc extends Bloc<GetPenugasanEvent, GetPenugasanState> {
  GetPenugasan getPenugasan;
  GetPenugasanBloc(this.getPenugasan) : super(GetPenugasanInitial()) {
    on<toggleGetPenugasanEvent>((event, emit) async {
      emit(GetPenugasanloading());
      final response = await getPenugasan.call(idPengaduan: event.idPengaduan);
      response.fold(
        (l) => emit(GetPenugasanError(l.message)),
        (r) {
          emit(GetPenugasanloaded(r));
        },
      );
    });
  }
}
