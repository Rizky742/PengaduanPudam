part of 'pengaduan_bloc.dart';

@immutable
sealed class PengaduanState {}

final class PengaduanInitial extends PengaduanState {}

final class PengaduanLoading extends PengaduanState {}

final class PengaduanLoaded extends PengaduanState {
  final List<Pengaduan> pengaduan;

  PengaduanLoaded(this.pengaduan);
}

final class PengaduanError extends PengaduanState {
  final String message;

  PengaduanError(this.message);
}
