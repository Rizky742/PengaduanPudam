part of 'send_penyelesaian_bloc.dart';

@immutable
sealed class SendPenyelesaianState {}

final class SendPenyelesaianInitial extends SendPenyelesaianState {}

final class SendPenyelesaianSuccesss extends SendPenyelesaianState {}

final class SendPenyelesaianError extends SendPenyelesaianState {}
