import 'package:equatable/equatable.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();
}

class NavigationChangePage extends NavigationEvent {
  final int selectedPage;

  const NavigationChangePage(this.selectedPage);

  @override
  List<Object?> get props => [selectedPage];
}
