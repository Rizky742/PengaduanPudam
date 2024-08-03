import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/pengaduan.dart';
import 'package:pengaduan/features/pengaduan/domain/usecases/get_pengaduan.dart';
part 'pengaduan_event.dart';
part 'pengaduan_state.dart';

class PengaduanBloc extends Bloc<PengaduanEvent, PengaduanState> {
  final GetPengaduan getPengaduan;

  PengaduanBloc(this.getPengaduan) : super(PengaduanInitial()) {
    // Handler for GetPengaduanEvent
    on<GetPengaduanEvent>((event, emit) async {
      emit(PengaduanLoading());
      final pengaduan = await getPengaduan.call(
          month: event.month, year: event.year, id: event.id, role: event.role);
      pengaduan.fold(
        (failure) => emit(PengaduanError(failure.message)),
        (pengaduan) => emit(PengaduanLoaded(pengaduan)),
      );
    });

    // Handler for GetFilterPengaduanEvent
    on<GetFilterPengaduanEvent>((event, emit) {
      if (state is PengaduanLoaded) {
        final currentState = state as PengaduanLoaded;
        // Emit the same state if filtering logic is not implemented
        emit(PengaduanLoaded(currentState.pengaduan));
      }
    });
  }
}
