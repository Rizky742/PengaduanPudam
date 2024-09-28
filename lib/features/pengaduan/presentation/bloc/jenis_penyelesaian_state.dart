part of 'jenis_penyelesaian_bloc.dart';

@immutable
sealed class JenisPenyelesaianState {}

final class JenisPenyelesaianInitial extends JenisPenyelesaianState {}

final class JenisPenyelesaianLoading extends JenisPenyelesaianState {}

final class JenisPenyelesaianLoaded extends JenisPenyelesaianState {
  final List<JenisPenyelesaian> jenisPenyelesaian;

  JenisPenyelesaianLoaded(this.jenisPenyelesaian);
}

final class JenisPenyelesaianError extends JenisPenyelesaianState {
  final String message;

  JenisPenyelesaianError(this.message);
}
