/// [IDisplayable] interface should be implemented by classes that need
/// to be displayed as a UI element
///
/// [posterPath] and [backdropPath] are just parts of a complete url,
/// user should provide a way to convert them into proper urls
abstract class IDisplayable {
  String get title;

  /// poster image URL
  String? get posterPath;

  /// large background image URL, preferably of width greater than height
  ///
  /// [backdropPath] is used for example in [//TODO ADD EXAMPLE]
  String? get backdropPath;

  /// subtitle should provide some description about the [IDisplayable] object
  /// for example [Movie] class utilizes the [subtitle] getter to provide
  /// overview
  String? get subtitle;
}

//TODO CONVERT MODELS THAT NEED TO BE DISPLAYED TO IMPLEMENT IDISPLAYABLE INTERFACE
