import 'package:http/http.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_lists.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/list_element_model.dart';

class TmdbMovieLists implements IMovieLists {
  @override
  Future<ListModel> getMovieLists({
    required String id,
    int page = 1,
    Future<Response> Function()? dataSource,
  }) async {
    return await ApiRetrieveObjectImpl<ListModel>(
      urlGenerator: () => urlGenerator(page: page, id: id),
      jsonConverter: ListModel.fromJson,
      dataSource: dataSource,
    ).retrieveObject();
  }
}

extension UrlGenerator on TmdbMovieLists {
  String urlGenerator({
    required int page,
    required String id,
  }) =>
      TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "movie/$id/lists",
        queryParameters: {
          "page": page.toString(),
        },
      ).toString();
}
