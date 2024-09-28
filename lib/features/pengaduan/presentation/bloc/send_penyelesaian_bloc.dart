import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/penyelesaian.dart';

part 'send_penyelesaian_event.dart';
part 'send_penyelesaian_state.dart';

class SendPenyelesaianBloc
    extends Bloc<SendPenyelesaianEvent, SendPenyelesaianState> {
  bool isPickerActive = false;
  SendPenyelesaianBloc()
      : super(SendPenyelesaianSet(
            image: null,
            jenisPenyelesaianId: '',
            keterangan: '',
            pengaduanId: '',
            petugasId: '')) {
    on<SendPenyelesaianSelectImage>(
      (event, emit) async {
        final currentstate = state;
        if (currentstate is SendPenyelesaianSet) {
          emit(currentstate.copyWith(image: null));
          if (!isPickerActive) {
            isPickerActive = true; // Set picker as active
            try {
              final picker = ImagePicker();
              final image = await picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                emit(currentstate.copyWith(image: File(image.path)));
              } 
            } catch (e) {
                emit(currentstate.copyWith(image: null));
            } finally {
              isPickerActive = false; // Reset the flag after picking an image
            }
          }
        }
      },
    );
    on<SendPenyelesaianSetOpsiPenyelesaian>(
      (event, emit) async {
        final currentstate = state;
        if (currentstate is SendPenyelesaianSet) {
          emit(
              currentstate.copyWith(jenisPenyelesaianId: event.penyelesaianId));
        }
      },
    );

    on<SendPenyelesaianSetKeterangan>(
      (event, emit) async {
        final currentstate = state;
        if (currentstate is SendPenyelesaianSet) {
          emit(currentstate.copyWith(keterangan: event.keterangan));
        }
      },
    );

    on<SendPenyelesaianRemoveImage>((event, emit) async {
      // print('sdfdsf');
      final currentstate = state;
      if (currentstate is SendPenyelesaianSet) {
        emit(currentstate.copyWith(image: null)); // Remove the image
        // print(currentstate.image);
      }
    });
  }
}
