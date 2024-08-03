part of 'penugasan_bloc.dart';

@immutable
sealed class PenugasanState {}

final class PenugasanInitial extends PenugasanState {}

final class PenugasanLoading extends PenugasanState {}

final class PenugasanLoaded extends PenugasanState {
  final String selectedPetugas;
  final String selectedDay;
  final String selectedMonth;
  final String selectedYear;

  PenugasanLoaded({required this.selectedPetugas, required this.selectedDay, required this.selectedMonth, required this.selectedYear});

  PenugasanLoaded copyWith({
    String? selectedPetugas,
    String? selectedDay,
    String? selectedMonth,
    String? selectedYear,
  }) {
    return PenugasanLoaded(selectedPetugas: selectedPetugas ?? this.selectedPetugas, selectedDay: selectedDay ?? this.selectedDay, selectedMonth: selectedMonth ?? this.selectedMonth, selectedYear: selectedYear ?? this.selectedYear);
  }
}
