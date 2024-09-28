part of 'send_data_penyelesaian_bloc.dart';

@immutable
sealed class SendDataPenyelesaianEvent {}

final class ToggleSendDataPenyelesaianEvent extends SendDataPenyelesaianEvent {
  final File image;
  final String pengaduanId;
  final String petugasId;
  final String keteranganSelesain;
  final String jenisPenyelesaianId;

  ToggleSendDataPenyelesaianEvent(
      {required this.image,
      required this.pengaduanId,
      required this.petugasId,
      required this.keteranganSelesain,
      required this.jenisPenyelesaianId});
}

final class ToggleGetDataPenyelesaianById extends SendDataPenyelesaianEvent {
  final String id;

  ToggleGetDataPenyelesaianById({required this.id});
}
