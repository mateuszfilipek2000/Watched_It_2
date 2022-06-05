import 'package:flutter/material.dart';
import 'package:watched_it_2/api/interfaces/iimage_url_provider.dart'
    show ImageType;
import 'package:watched_it_2/models/idisplayable.dart';
import 'package:watched_it_2/presentation/screens/dashboard_screen/components/displayable_item_list/displayable_list_item.dart';

typedef ImageUrlGenerator = String Function(String);

/// [DisplayableItemList] converts list of objects of type [IDisplayable]
/// into a horizonally scrollable list of [DisplayableListItem]
class DisplayableItemList extends StatelessWidget {
  const DisplayableItemList({
    Key? key,
    required this.items,
    required this.imageUrlGenerator,
    required this.onTap,
  }) : super(key: key);

  final List<IDisplayable> items;

  /// [imageUrlGenerator] is used to convert part of image url from [IDisplayable]
  /// items into fully valid image url.
  ///
  /// Provide a method suitable for [ImageType] of your choice
  final ImageUrlGenerator imageUrlGenerator;

  /// [onTap] should handle tap event for every single object in the list
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      // shrinkWrap: true,
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(
        width: 10.0,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => onTap(index),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildPoster(index),
              // ..._buildTexts(index),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPoster(int index) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1 / 1.5,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: items[index].posterPath != null
              ? Image.network(
                  imageUrlGenerator(items[index].posterPath!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
      ),
    );
  }

  List<Widget> _buildTexts(int index) {
    List<Widget> it = [];
    it.add(
      Text(
        items[index].title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );

    if (items[index].subtitle != null) {
      it.add(
        Text(
          items[index].subtitle!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }

    return it;
  }
}
