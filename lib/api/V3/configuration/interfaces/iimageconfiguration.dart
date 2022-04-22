import 'package:watched_it_2/models/configuration/image_configuration_model.dart';

abstract class IImageConfiguration {
  Future<ImageConfiguration> getImageConfiguration();
}
