import 'package:http/http.dart';
import 'package:watched_it_2/models/keyword_model.dart';

abstract class ITvKeywords {
  Future<Keywords> getTvKeywords({
    required String id,
    Future<Response> Function()? dataSource,
  });
}
