// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';

// Project imports:
import 'package:mangadex/theme/mangadex_theme.dart';

enum TextLinkDestination { url, screen }

class TextLink extends StatelessWidget {
  final String text;
  final TextLinkDestination destinationType;
  final PageInfo? destinationScreen;
  final String? destinationUrl;

  const TextLink(
    this.text, {
    super.key,
    required this.destinationType,
    this.destinationScreen,
    this.destinationUrl,
  }) : assert(destinationScreen == null && destinationUrl == null);

  const TextLink.url(
    this.text, {
    super.key,
    required this.destinationUrl,
  })  : destinationScreen = null,
        destinationType = TextLinkDestination.url;

  const TextLink.page(
    this.text, {
    super.key,
    this.destinationScreen,
  })  : destinationUrl = null,
        destinationType = TextLinkDestination.screen;

  @override
  Widget build(BuildContext context) {
    final textStyle = context.theme.textTheme.titleMedium!.copyWith(color: context.theme.colorScheme.primary);

    return GestureDetector(
      onTap: () {
        print(destinationScreen ?? destinationUrl);
      },
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
