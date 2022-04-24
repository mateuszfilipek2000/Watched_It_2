import 'package:http/http.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/api_retrieve_object.dart';
import 'package:watched_it_2/core/config/api_keys.dart';
import 'package:watched_it_2/models/account_states_model.dart';

import '../../interfaces/imovie_account_states.dart';

class TmdbMovieAccountStates implements IMovieAccountStates {
  const TmdbMovieAccountStates({
    this.dataSource,
  });
  @override
  Future<AccountStates> getAccountStates(String id) async {
    return await ApiRetrieveObjectImpl<AccountStates>(
      urlGenerator: () =>
          "https://api.themoviedb.org/3/movie/$id/account_states?api_key=$kApiKeyV3",
      jsonConverter: AccountStates.fromJson,
      dataSource: dataSource,
    ).retrieveObject();
  }

  final Future<Response> Function()? dataSource;
}
