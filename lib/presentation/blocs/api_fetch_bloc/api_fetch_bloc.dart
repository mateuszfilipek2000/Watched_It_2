import 'package:flutter_bloc/flutter_bloc.dart';

import 'api_fetch_event.dart';
import 'api_fetch_state.dart';

/// Generic bloc for fetching data from api
///
/// Provides only one usable event - [ApiFetchLoad]
///
/// [ApiFetchLoad] event is called in the bloc constructor -
/// data will start loading the moment this bloc is created
class ApiFetchBloc<T> extends Bloc<ApiFetchEvent<T>, ApiFetchState<T>> {
  ApiFetchBloc({
    required this.dataSource,
  }) : super(ApiFetchInitial<T>()) {
    on<ApiFetchLoad<T>>((event, emit) async {
      emit(ApiFetchLoading<T>());

      if (data != null) {
        emit(ApiFetchSuccess(resource: data!));
        return;
      }
      try {
        data = await dataSource();
        emit(ApiFetchSuccess(resource: data!));
      } catch (e) {
        emit(ApiFetchFailure(message: e.toString()));
      }
    });

    /// fetching data on bloc creation
    add(ApiFetchLoad<T>());
  }

  T? data;
  final Future<T> Function() dataSource;
}
