part of 'popular_paginator.dart';

class _PopularPaginatorMobile extends StatelessWidget {
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final String text;

  const _PopularPaginatorMobile({
    required this.onPrev,
    required this.onNext,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme.background;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onPrev,
          child: _PaginatorItemWrapperMobile(
            child: SvgIcon(
              asset: Assets.assetsChevronLeft,
              color: color,
            ),
          ),
        ),
        _PaginatorItemWrapperMobile(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Text(
              text,
              style: context.theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: onNext,
          child: _PaginatorItemWrapperMobile(
            child: SvgIcon(
              asset: Assets.assetsChevronRight,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

class _PaginatorItemWrapperMobile extends StatelessWidget {
  final Widget child;

  const _PaginatorItemWrapperMobile({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.isDark;
    final backgroundColor = isDark ? Colors.white : HexColor('#242424');

    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(kPopularPaginatorHeight),
      ),
      child: child,
    );
  }
}
