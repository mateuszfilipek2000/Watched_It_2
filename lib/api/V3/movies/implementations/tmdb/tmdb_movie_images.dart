import 'package:http/http.dart';
import 'package:watched_it_2/api/V3/movies/implementations/tmdb/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/movies/interfaces/imovie_images.dart';
import 'package:watched_it_2/core/config/api_keys.dart';
import 'package:watched_it_2/models/image_model.dart';

class TmdbMovieImages implements IMovieImages {
  const TmdbMovieImages({this.dataSource});

  @override
  Future<Images> getMovieImages(String id) async {
    return await ApiRetrieveObjectImpl<Images>(
      urlGenerator: () =>
          "https://api.themoviedb.org/3/movie/$id/images?api_key=$kApiKeyV3&language=en-US",
      jsonConverter: Images.fromJson,
      dataSource: dataSource,
    ).retrieveObject();
  }

  final Future<Response> Function()? dataSource;
}
