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
    on<GetPengaduanEvent>((event, emit) async {
      emit(PengaduanLoading());
      final pengaduan = await getPengaduan.call(
          month: event.month, year: event.year, id: event.id, role: event.role);
      pengaduan.fold(
        (failure) => emit(PengaduanError(failure.message)),
        (pengaduan) => emit(PengaduanLoaded(pengaduan: pengaduan)),
      );
    });

    on<GetFilterPengaduanEvent>((event, emit) {
      if (state is PengaduanLoaded) {
        final currentState = state as PengaduanLoaded;
        emit(PengaduanLoaded(pengaduan: currentState.pengaduan));
      }
    });

    on<GetFilterPengaduanEventFilter>((event, emit) {
      if (state is PengaduanLoaded) {
        final currentState = state as PengaduanLoaded;
        emit(PengaduanLoaded(
            pengaduan: currentState.pengaduan, filter: event.filter));
      }
    });
  }
}
