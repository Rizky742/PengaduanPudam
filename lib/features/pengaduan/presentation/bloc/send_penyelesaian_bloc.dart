import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'send_penyelesaian_event.dart';
part 'send_penyelesaian_state.dart';

class SendPenyelesaianBloc extends Bloc<SendPenyelesaianEvent, SendPenyelesaianState> {
  SendPenyelesaianBloc() : super(SendPenyelesaianInitial()) {
    on<SendPenyelesaianEvent>((event, emit) {
      
    });
  }
}
