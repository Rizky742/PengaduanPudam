import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'send_pengaduan_event.dart';
part 'send_pengaduan_state.dart';

class SendPengaduanBloc extends Bloc<SendPengaduanEvent, SendPengaduanState> {
  SendPengaduanBloc() : super(SendPengaduanInitial()) {
    on<SendPengaduanEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
