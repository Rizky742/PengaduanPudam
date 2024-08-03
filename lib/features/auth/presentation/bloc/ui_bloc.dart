import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ui_event.dart';
part 'ui_state.dart';

class UiBloc extends Bloc<UiEvent, UiState> {
  UiBloc() : super(UiInitial()) {
    on<ToggleObscureTextEvent>((event, emit) {
      final currentState = state as UiInitial;
      emit(UiInitial(obscureText: !currentState.obscureText));
    });

    on<ToggleRememberMeEvent>(
      (event, emit) {
        final currentState = state as UiInitial;
        emit(UiInitial(rememberMe: !currentState.rememberMe));
      },
    );
  }
}
