import 'package:http/http.dart';
import 'package:watched_it_2/models/account_states_model.dart';

abstract class ITvAccountStates {
  Future<AccountStates> getTvAccountStates({
    required String id,
    Future<Response> Function()? dataSource,
  });
}
