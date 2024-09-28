part of 'send_penyelesaian_bloc.dart';

@immutable
sealed class SendPenyelesaianState {}

final class SendPenyelesaianInitial extends SendPenyelesaianState {}

final class SendPenyelesaianSet extends SendPenyelesaianState {
  final File? image;
  final String pengaduanId;
  final String petugasId;
  final String jenisPenyelesaianId;
  final String keterangan;

  SendPenyelesaianSet(
      {required this.image,
      required this.pengaduanId,
      required this.petugasId,
      required this.jenisPenyelesaianId,
      required this.keterangan});

  SendPenyelesaianSet copyWith({
    final File? image,
    final String? pengaduanId,
    final String? petugasId,
    final String? jenisPenyelesaianId,
    final String? keterangan,
  }) {
    return SendPenyelesaianSet(
      image: image,
      pengaduanId: pengaduanId ?? this.pengaduanId,
      petugasId: petugasId ?? this.petugasId,
      jenisPenyelesaianId: jenisPenyelesaianId ?? this.jenisPenyelesaianId,
      keterangan: keterangan ?? this.keterangan,
    );
  }
}

final class SendPenyelesainLoading extends SendPenyelesaianState {}

final class SendPenyelesaianSuccesss extends SendPenyelesaianState {
  final Penyelesaian penyelesaian;

  SendPenyelesaianSuccesss(this.penyelesaian);
}

final class SendPenyelesaianSelectImageError extends SendPenyelesaianState {
  final String message;

  SendPenyelesaianSelectImageError(this.message);
}

final class SendPenyelesaianError extends SendPenyelesaianState {
  final String message;

  SendPenyelesaianError(this.message);
}
