part of 'navigation_bloc.dart';

@immutable
sealed class NavigationEvent {}

final class ChangePage extends NavigationEvent{
  final int index;

  ChangePage(this.index);

}
