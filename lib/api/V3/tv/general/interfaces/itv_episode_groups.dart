import 'package:http/http.dart';
import 'package:watched_it_2/models/tv/episode_group_model.dart';

abstract class ITvEpisodeGroups {
  Future<List<EpisodeGroup>> getEpisodeGroups({
    required String id,
    Future<Response> Function()? dataSource,
  });
}
