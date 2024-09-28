part of 'send_penyelesaian_bloc.dart';

@immutable
sealed class SendPenyelesaianEvent {}

final class SendPenyelesaianSelectImage extends SendPenyelesaianEvent {}

final class SendPenyelesaianRemoveImage extends SendPenyelesaianEvent {}

final class SendPenyelesaianSetOpsiPenyelesaian extends SendPenyelesaianEvent {
  final String penyelesaianId;

  SendPenyelesaianSetOpsiPenyelesaian({required this.penyelesaianId});
}

final class SendPenyelesaianSetKeterangan extends SendPenyelesaianEvent {
  final String keterangan;

  SendPenyelesaianSetKeterangan({required this.keterangan});
}

final class SendPenyelesaianToggle extends SendPenyelesaianEvent {}
