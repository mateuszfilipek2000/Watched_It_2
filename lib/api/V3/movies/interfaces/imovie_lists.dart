import 'package:watched_it_2/models/list_element_model.dart';

abstract class IMovieLists {
  Future<ListModel> getMovieLists(String id);
}
