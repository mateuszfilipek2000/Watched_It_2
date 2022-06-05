import 'package:equatable/equatable.dart';

class NavigationState extends Equatable {
  const NavigationState({
    required this.currentPage,
  });

  final int currentPage;

  @override
  List<Object?> get props => [currentPage];
}
