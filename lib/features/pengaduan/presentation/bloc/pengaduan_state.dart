part of 'pengaduan_bloc.dart';

@immutable
sealed class PengaduanState {}

final class PengaduanInitial extends PengaduanState {}

final class PengaduanLoading extends PengaduanState {}

// ignore: must_be_immutable
final class PengaduanLoaded extends PengaduanState {
  final List<Pengaduan> pengaduan;
  String? filter;

  PengaduanLoaded({required this.pengaduan, this.filter});
}

final class PengaduanError extends PengaduanState {
  final String message;

  PengaduanError(this.message);
}
