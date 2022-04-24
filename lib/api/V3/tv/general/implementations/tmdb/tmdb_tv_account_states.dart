import 'package:http/http.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/tv/general/interfaces/itv_account_states.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/account_states_model.dart';

class TmdbTvAccountStates implements ITvAccountStates {
  @override
  Future<AccountStates> getTvAccountStates({
    required String id,
    Future<Response> Function()? dataSource,
  }) async {
    return await ApiRetrieveObjectImpl<AccountStates>(
      urlGenerator: () => urlGenerator(id),
      jsonConverter: AccountStates.fromJson,
      dataSource: dataSource,
    ).retrieveObject();
  }
}

extension UrlGenerator on TmdbTvAccountStates {
  String urlGenerator(String id) => TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "tv/$id/account_states",
        queryParameters: {},
      ).toString();
}
