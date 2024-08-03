part of 'pengaduan_bloc.dart';

@immutable
sealed class PengaduanEvent {}

final class GetPengaduanEvent extends PengaduanEvent {
  final String month;
  final String year;
  final String role;
  final String id;

  GetPengaduanEvent(
      {required this.month,
      required this.year,
      required this.role,
      required this.id});
}

final class GetFilterPengaduanEventFilter extends PengaduanEvent {
  final String filter;

  GetFilterPengaduanEventFilter(this.filter);
}

final class GetFilterPengaduanEvent extends PengaduanEvent {}
