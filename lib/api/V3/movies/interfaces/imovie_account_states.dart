import 'package:watched_it_2/models/account_states_model.dart';

abstract class IMovieAccountStates {
  /// returns movie rating, and information
  /// if movie is on the watchlist/favourite list or not
  Future<AccountStates> getAccountStates(String id);
}
