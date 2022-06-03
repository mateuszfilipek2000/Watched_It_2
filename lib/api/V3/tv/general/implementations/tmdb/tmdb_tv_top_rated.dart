import 'package:http/http.dart';
import 'package:watched_it_2/core/config/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/tv/general/interfaces/itv_top_rated.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/tv/tv_model.dart';
import 'package:watched_it_2/models/paged_results_model.dart';

class TmdbTvTopRated implements ITvTopRated {
  @override
  Future<PagedResults<Tv>> getTopRatedTv({
    // int page = 1,
    Future<Response> Function()? dataSource,
  }) async {
    if (pagedResults != null) {
      return pagedResults!;
    }

    pagedResults = await ApiRetrieveObject.retrieveObject<PagedResults<Tv>>(
      urlGenerator: () => urlGenerator(1),
      jsonConverter: (json) => pagedResultsFromJson<Tv>(
        json,
        Tv.fromJson,
        urlGenerator,
      ),
      dataSource: dataSource,
    );

    return pagedResults!;
  }

  PagedResults<Tv>? pagedResults;
}

extension UrlGenerator on TmdbTvTopRated {
  String urlGenerator(int page) => TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "tv/top_rated",
        queryParameters: {
          "page": page.toString(),
        },
      ).toString();
}
