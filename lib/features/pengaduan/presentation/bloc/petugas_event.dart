part of 'petugas_bloc.dart';

@immutable
sealed class PetugasEvent {}

final class GetPetugasEvent extends PetugasEvent {
  final String divisiId;

  GetPetugasEvent({required this.divisiId});
}
