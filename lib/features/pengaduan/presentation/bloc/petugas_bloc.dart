import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/petugas.dart';
import 'package:pengaduan/features/pengaduan/domain/usecases/get_petugas.dart';

part 'petugas_event.dart';
part 'petugas_state.dart';

class PetugasBloc extends Bloc<PetugasEvent, PetugasState> {
  final GetPetugas getPetugas;
  PetugasBloc(this.getPetugas) : super(PetugasInitial()) {
    on<GetPetugasEvent>((event, emit) async {
      emit(PetugasLoading());
      final petugasData = await getPetugas.call(divisiId: event.divisiId);
      petugasData.fold((failure) => emit(PetugasError(failure.message)),
          (petugas) => emit(PetugasLoaded(petugas)));
    });
  }
}
