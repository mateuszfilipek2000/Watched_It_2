import 'package:http/http.dart';
import 'package:watched_it_2/models/list_element_model.dart';

abstract class IMovieLists {
  Future<ListModel> getMovieLists({
    required String id,
    int page = 1,
    Future<Response> Function()? dataSource,
  });
}
