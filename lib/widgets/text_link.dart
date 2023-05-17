// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:url_launcher/url_launcher_string.dart';

// Project imports:
import 'package:mangadex/infrastructure/mangadex_theme.dart';

enum TextLinkDestination { url, screen }

class TextLink extends StatelessWidget {
  final String text;
  final TextLinkDestination destinationType;
  final PageInfo? destinationScreen;
  final Uri? destinationUrl;

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
      onTap: () async {
        if (destinationType == TextLinkDestination.url) {
          if (await url_launcher.canLaunchUrl(destinationUrl!)) {
            url_launcher.launchUrl(destinationUrl!);
          }
        } else {
          debugPrint(destinationScreen!.toString());
        }
      },
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
