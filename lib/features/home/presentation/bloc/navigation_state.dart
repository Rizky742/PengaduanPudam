part of 'navigation_bloc.dart';

@immutable
sealed class NavigationState {
  final int selectedIndex;

  const NavigationState(this.selectedIndex);

}

final class NavigationInitial extends NavigationState {
  const NavigationInitial(super.selectedIndex);
}

final class NavigationUpdated extends NavigationState{
  const NavigationUpdated(super.selectedIndex);
}
