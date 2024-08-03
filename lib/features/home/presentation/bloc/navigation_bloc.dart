import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  late final PageController pageController;
  NavigationBloc(this.pageController) : super(const NavigationInitial(0)) {
    on<ChangePage>((event, emit) {
      pageController.jumpToPage(event.index);
      emit(NavigationUpdated(event.index));
    });
  }

  @override
  Future<void> close() {
    pageController.dispose();
    print('ketutup');
    // debugPrint('PageController disposed');
    return super.close();
  }
}
