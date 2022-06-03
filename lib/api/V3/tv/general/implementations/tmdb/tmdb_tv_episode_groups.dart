import 'package:http/http.dart';
import 'package:watched_it_2/core/config/api_retrieve_object.dart';
import 'package:watched_it_2/api/V3/tv/general/interfaces/itv_episode_groups.dart';
import 'package:watched_it_2/api/tmdb_query_builder.dart';
import 'package:watched_it_2/models/tv/episode_group_model.dart';

class TmdbEpisodeGroups implements ITvEpisodeGroups {
  @override
  Future<List<EpisodeGroup>> getEpisodeGroups({
    required String id,
    Future<Response> Function()? dataSource,
  }) async {
    //TODO CHANGE IT TO PAGED RESULTS?
    return await ApiRetrieveObject.retrieveObject<List<EpisodeGroup>>(
      urlGenerator: () => urlGenerator(id),
      jsonConverter: (Map<String, dynamic> json) => json["results"].map(
        (e) => EpisodeGroup.fromJson(json),
      ),
      dataSource: dataSource,
    );
  }
}

extension UrlGenerator on TmdbEpisodeGroups {
  String urlGenerator(String id) => TmdbQueryBuilder.buildUri(
        version: TmdbApiVersion.v3,
        path: "tv/$id/episode_groups",
        queryParameters: {},
      ).toString();
}
