import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watched_it_2/presentation/blocs/navigation_bloc/navigation_event.dart';
import 'package:watched_it_2/presentation/blocs/navigation_bloc/navigation_state.dart';

/// [NavigationBloc] serves as a sort of controller for navigation widgets
/// such as [MenuList]
// class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
//   NavigationBloc() : super(const NavigationState(currentPage: 0)) {
//     on<NavigationChangePage>((event, emit) {
//       emit(NavigationState(currentPage: event.selectedPage));
//     });
//   }
// }

/// [NavigationCubit] serves as a sort of controller for navigation widgets
/// such as [MenuList]
class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit()
      : super(
          const NavigationState(currentPage: 0),
        );

  void navigateTo(int index) {
    if (index < 0) {
      log("tried to navigate to non existing item");
      return;
      // throw Exception("tried to navigate to non existing item");
    }
    emit(NavigationState(currentPage: index));
  }

  void nextItem() => navigateTo(state.currentPage + 1);
  void previousItem() => navigateTo(state.currentPage - 1);

  // final int amountOfItems;
}
