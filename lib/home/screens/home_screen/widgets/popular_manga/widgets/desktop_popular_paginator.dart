part of 'popular_paginator.dart';

class _PopularPaginatorDesktop extends StatelessWidget {
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final int page;

  const _PopularPaginatorDesktop({
    required this.onPrev,
    required this.onNext,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = page == 1 ? context.theme.colorScheme.primary : context.theme.colorScheme.onBackground;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            LocaleKeys.pageNumber.tr(namedArgs: {"page": '$page'}),
            style: context.theme.textTheme.labelLarge?.copyWith(color: textColor),
          ),
          const VerticalDivider(),
          ClipOval(
            child: Material(
              type: MaterialType.transparency,
              child: SvgIconButton(
                asset: Assets.chevronLeft,
                onPressed: onPrev,
              ),
            ),
          ),
          ClipOval(
            child: Material(
              type: MaterialType.transparency,
              child: SvgIconButton(
                asset: Assets.chevronRight,
                onPressed: onNext,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
