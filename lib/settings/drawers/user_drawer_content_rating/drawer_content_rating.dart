// Flutter imports:
import 'dart:async';

import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangadex/infrastructure/mangadex_theme.dart';

// Project imports:
import 'package:mangadex/settings/domain/content_rating.dart';
import 'package:mangadex/settings/drawers/user_drawer_content_rating/drawer_content_rating_cubit.dart';
import 'package:mangadex/utils/manga_content_rating_extension.dart';
import 'package:reactive_forms/reactive_forms.dart';

@RoutePage()
class DrawerContentRatingPage extends StatefulWidget {
  const DrawerContentRatingPage({super.key});

  @override
  State<DrawerContentRatingPage> createState() => _DrawerContentRatingPageState();
}

class _DrawerContentRatingPageState extends State<DrawerContentRatingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MangaContentRatingCubit, MangaContentRatingState>(
      builder: (context, state) {
        return switch (state) {
          MangaContentRatingLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
          MangaContentRatingReady(ratings: List<MangaContentRating> selectedRatings) =>
            ContentFilterForm(initialValues: selectedRatings),
        };
      },
    );
  }
}

class ContentFilterForm extends StatefulWidget {
  final List<MangaContentRating> initialValues;

  const ContentFilterForm({
    super.key,
    required this.initialValues,
  });

  @override
  State<ContentFilterForm> createState() => _ContentFilterFormState();
}

class _ContentFilterFormState extends State<ContentFilterForm> {
  late final FormGroup _formGroup;

  @override
  void initState() {
    _formGroup = FormGroup({
      for (final rating in MangaContentRating.values)
        rating.name: FormControl<bool>(value: widget.initialValues.contains(rating))
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: _formGroup,
      child: StaticListView(
        itemCount: MangaContentRating.values.length,
        itemBuilder: (context, index) {
          final rating = MangaContentRating.values[index];

          return ReactiveCheckboxListTile(
            formControlName: rating.name,
            title: Text(
              rating.tr(),
              style: context.theme.textTheme.labelLarge,
            ),
            onChanged: _onChanged,
            dense: true,
            visualDensity: VisualDensity.compact,
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
          );
        },
      ),
    );
  }

  void _onChanged(_) {
    final ratings = _formGroup.controls.entries
        .where((entry) => (entry.value as FormControl<bool>).value ?? false)
        .map((entry) => MangaContentRating.values.firstWhere((e) => e.name == entry.key))
        .toList();
    context.read<MangaContentRatingCubit>().changeRatings(ratings);
  }
}

class StaticListView extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;

  const StaticListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.separatorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];

    for (int i = 0; i < itemCount; i++) {
      final widget = itemBuilder(context, i);
      final separator = separatorBuilder != null ? separatorBuilder!(context, i) : null;

      children.add(widget);
      if (separator != null) {
        children.add(separator);
      }
    }

    return Column(
      children: children,
    );
  }
}
