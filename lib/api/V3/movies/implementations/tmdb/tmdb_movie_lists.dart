import 'package:http/http.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_lists.dart';
import 'package:watched_it_2/core/config/api_keys.dart';
import 'package:watched_it_2/models/list_element_model.dart';

class TmdbMovieLists implements IMovieLists {
  TmdbMovieLists({required this.page, this.dataSource});

  @override
  Future<ListModel> getMovieLists(String id) async {
    return await ApiRetrieveObjectImpl<ListModel>(
      urlGenerator: () =>
          "https://api.themoviedb.org/3/movie/$id/lists?api_key=$kApiKeyV3&language=en-US&page=$page",
      jsonConverter: ListModel.fromJson,
      dataSource: dataSource,
    ).retrieveObject();
  }

  int page;
  final Future<Response> Function()? dataSource;
}
