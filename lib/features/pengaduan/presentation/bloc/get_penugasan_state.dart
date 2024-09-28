part of 'get_penugasan_bloc.dart';

@immutable
sealed class GetPenugasanState {}

final class GetPenugasanInitial extends GetPenugasanState {}

final class GetPenugasanloading extends GetPenugasanState {}

final class GetPenugasanloaded extends GetPenugasanState {
  final Penugasan penugasan;

  GetPenugasanloaded(this.penugasan);

}

final class GetPenugasanError extends GetPenugasanState {
  final String message;

  GetPenugasanError(this.message);
}
