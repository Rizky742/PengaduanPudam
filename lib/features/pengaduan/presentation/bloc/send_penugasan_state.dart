part of 'send_penugasan_bloc.dart';

@immutable
sealed class SendPenugasanState {}

final class SendPenugasanInitial extends SendPenugasanState {}

final class SendPenugasanLoading extends SendPenugasanState {}

final class SendPenugasanSuccess extends SendPenugasanState {
  final Penugasan penugasan;

  SendPenugasanSuccess(this.penugasan);
}

final class SendPenugasanError extends SendPenugasanState {
  final String message;

  SendPenugasanError(this.message);
}
