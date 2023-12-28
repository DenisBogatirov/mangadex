part of 'popular_paginator.dart';

class _PopularPaginatorTablet extends StatelessWidget {
  final VoidCallback onPrev;
  final VoidCallback onNext;

  const _PopularPaginatorTablet({
    required this.onPrev,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
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
