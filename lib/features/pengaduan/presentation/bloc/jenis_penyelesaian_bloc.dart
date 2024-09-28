import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/jenis_penyelesaian.dart';
import 'package:pengaduan/features/pengaduan/domain/usecases/get_jenis_penyelesaian.dart';

part 'jenis_penyelesaian_event.dart';
part 'jenis_penyelesaian_state.dart';

class JenisPenyelesaianBloc
    extends Bloc<JenisPenyelesaianEvent, JenisPenyelesaianState> {
  final GetJenisPenyelesaian getJenisPenyelesaian;
  JenisPenyelesaianBloc(this.getJenisPenyelesaian)
      : super(JenisPenyelesaianInitial()) {
    on<GetJenisPenyelesaianEvent>((event, emit) async {
      emit(JenisPenyelesaianLoading());
      final data = await getJenisPenyelesaian.call();
      data.fold(
        (l) => emit(JenisPenyelesaianError(l.message)),
        (r) => emit(JenisPenyelesaianLoaded(r)),
      );
    });
  }
}
