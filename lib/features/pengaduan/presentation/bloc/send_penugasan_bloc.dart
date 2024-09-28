import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/penugas.dart';
import 'package:pengaduan/features/pengaduan/domain/usecases/send_penugasan.dart';

part 'send_penugasan_event.dart';
part 'send_penugasan_state.dart';

class SendPenugasanBloc extends Bloc<SendPenugasanEvent, SendPenugasanState> {
  final SendPenugasan sendPenugasan;

  SendPenugasanBloc(this.sendPenugasan) : super(SendPenugasanInitial()) {
    on<ToggleSendPenugasanEvent>((event, emit) async {
      emit(SendPenugasanLoading());
      final sendData = await sendPenugasan.call(
          idKepala: event.idKepala,
          idPetugas: event.idPetugas,
          idPengaduan: event.idPengaduan,
          tglTarget: event.tglTarget);
      sendData.fold(
        (failure) => emit(SendPenugasanError(failure.message)),
        (success) => emit(SendPenugasanSuccess(success)),
      );
    });
  }
}
