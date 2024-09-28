import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/penyelesaian.dart';
import 'package:pengaduan/features/pengaduan/domain/usecases/get_penyelesaian_by_id.dart';
import 'package:pengaduan/features/pengaduan/domain/usecases/send_penyelesaian.dart';

part 'send_data_penyelesaian_event.dart';
part 'send_data_penyelesaian_state.dart';

class SendDataPenyelesaianBloc
    extends Bloc<SendDataPenyelesaianEvent, SendDataPenyelesaianState> {
  final SendPenyelesaian sendPenyelesaian;
  final GetPenyelesaianById getPenyelesaianById;

  SendDataPenyelesaianBloc(this.sendPenyelesaian, this.getPenyelesaianById)
      : super(SendDataPenyelesaianInitial()) {
    on<ToggleSendDataPenyelesaianEvent>(
      (event, emit) async {
        emit(SendDataPenyelesaianLoading());
        final sendData = await sendPenyelesaian.call(
            image: event.image,
            pengaduanId: event.pengaduanId,
            petugasId: event.petugasId,
            keteranganSelesain: event.keteranganSelesain,
            jenisPenyelesaianId: event.jenisPenyelesaianId);
        sendData.fold(
          (l) => emit(SendDataPenyelesaianError(l.message)),
          (r) => emit(SendDataPenyelesaianSuccess(r)),
        );
      },
    );

    on<ToggleGetDataPenyelesaianById>(
      (event, emit) async {
        print('testtt');
        final getData = await getPenyelesaianById.call(id: event.id);
        getData.fold(
          (l) => emit(SendDataPenyelesaianError(l.message)),
          (r) => emit(SendDataPenyelesaianSuccess(r)),
        );
      },
    );
  }
}
