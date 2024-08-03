part of 'petugas_bloc.dart';

@immutable
sealed class PetugasState {}

final class PetugasInitial extends PetugasState {}

final class PetugasLoading extends PetugasState {}

final class PetugasLoaded extends PetugasState {
  final List<Petugas> petugas;

  PetugasLoaded(this.petugas);

}

final class PetugasError extends PetugasState {
  final String message;

  PetugasError(this.message);
}
