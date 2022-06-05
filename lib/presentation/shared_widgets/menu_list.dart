import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watched_it_2/presentation/blocs/navigation_bloc/navigation_bloc.dart';
import 'package:watched_it_2/presentation/blocs/navigation_bloc/navigation_state.dart';

/// [MenuList] required you to provide [NavigationBloc]
/// instance somewhere in the widget tree, above the [MenuList]
///
/// [NavigationState] will be emitted every time new item is selected
class MenuList extends StatelessWidget {
  const MenuList({
    Key? key,
    required this.sections,
    this.scrollDirection = Axis.vertical,
  }) : super(key: key);

  final List<MenuSection> sections;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        final cubit = context.read<NavigationCubit>();
        return Column(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            sections.length,
            (index) => _buildSection(
              sections[index],
              cubit,
            ),
          ),
        );
      },
    );
  }

  Widget _buildSection(MenuSection section, NavigationCubit cubit) {
    return Column(
        // shrinkWrap: true,
        // itemCount: section.items.length,
        // scrollDirection: scrollDirection,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: section.title,
          ),
          ...List.generate(
            section.items.length,
            (index) => ListTile(
              title: section.items[index].title,
              subtitle: section.items[index].subtitle,
              leading: section.items[index].icon,
              selected: cubit.state.currentPage == section.items[index].index,
              onTap: () => cubit.navigateTo(section.items[index].index),
            ),
          ),
        ]);
  }
}

class MenuSection {
  const MenuSection({
    required this.items,
    required this.title,
  });

  final List<MenuListItem> items;
  final Text title;
}

class MenuListItem {
  final Text title;
  final Text? subtitle;
  final Icon? icon;
  final int index;

  const MenuListItem({
    required this.title,
    required this.index,
    this.subtitle,
    this.icon,
  });
}
