import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

enum WatchOption {
  flatrate,
  rent,
  buy,
}

class JustWatchWatchProviders with EquatableMixin {
  const JustWatchWatchProviders({
    required this.id,
    required this.results,
  });

  final int id;
  final List<CountryWatchProviders> results;

  factory JustWatchWatchProviders.fromJson(Map<String, dynamic> json) =>
      JustWatchWatchProviders(
        id: json["id"],
        results: List<CountryWatchProviders>.from(
          Map<String, dynamic>.from(json["results"]).entries.map(
                (e) => CountryWatchProviders.fromJson(e.key, e.value),
              ),
          // json["results"].map((k, v) => CountryWatchProviders.fromJson(k, v)),
        ),
      );

  @override
  List<Object?> get props => [runtimeType, id];
}

class CountryWatchProviders {
  const CountryWatchProviders({
    required this.name,
    required this.link,
    required this.watchProviders,
  });
  final String name;
  final String link;
  final Map<WatchOption, List<WatchProviderInfo>> watchProviders;

  factory CountryWatchProviders.fromJson(
          String name, Map<String, dynamic> json) =>
      CountryWatchProviders(
        name: name,
        link: json["link"],
        // checking for every possible option in json response
        watchProviders: {}..addEntries(
            WatchOption.values
                .where((element) => json[describeEnum(element)] != null)
                .map(
                  (e) => MapEntry(
                    e,
                    List<WatchProviderInfo>.from(
                      json[describeEnum(e)].map(
                        (e) => WatchProviderInfo.fromJson(e),
                      ),
                    ),
                  ),
                ),
          ),
      );
}

class WatchProviderInfo {
  const WatchProviderInfo({
    required this.displayPriority,
    required this.logoPath,
    required this.providerId,
    required this.providerName,
  });

  final int displayPriority;
  final String logoPath;
  final int providerId;
  final String providerName;

  factory WatchProviderInfo.fromJson(Map<String, dynamic> json) =>
      WatchProviderInfo(
        displayPriority: json["display_priority"],
        logoPath: json["logo_path"],
        providerId: json["provider_id"],
        providerName: json["provider_name"],
      );
}
