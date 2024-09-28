part of 'send_penugasan_bloc.dart';

@immutable
sealed class SendPenugasanEvent {}

final class ToggleSendPenugasanEvent extends SendPenugasanEvent {
  final int idKepala;
  final int idPetugas;
  final int idPengaduan;
  final DateTime tglTarget;

  ToggleSendPenugasanEvent(
      {required this.idKepala,
      required this.idPetugas,
      required this.idPengaduan,
      required this.tglTarget});
}
