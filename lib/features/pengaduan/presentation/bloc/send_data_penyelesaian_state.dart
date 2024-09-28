part of 'send_data_penyelesaian_bloc.dart';

@immutable
sealed class SendDataPenyelesaianState {}

final class SendDataPenyelesaianInitial extends SendDataPenyelesaianState {}

final class SendDataPenyelesaianLoading extends SendDataPenyelesaianState {}

final class SendDataPenyelesaianSuccess extends SendDataPenyelesaianState {
  final Penyelesaian penyelesaian;

  SendDataPenyelesaianSuccess(this.penyelesaian);
}

final class SendDataPenyelesaianError extends SendDataPenyelesaianState {
  final String message;

  SendDataPenyelesaianError(this.message);
}
