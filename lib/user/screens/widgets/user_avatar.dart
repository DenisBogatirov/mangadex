// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:mangadex/infrastructure/mangadex_assets.dart';
import 'package:mangadex/widgets/svg_icon.dart';

class UserAvatar extends StatelessWidget {
  final double? radius;
  final String? url;

  const UserAvatar({
    super.key,
    this.radius,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    final width = radius != null ? radius! * 2 : null;
    final image =
    url != null ? Image.network(url!) : SvgIcon(asset: Assets.assetsGuestIcon, width: width);

    return ClipOval(
      child: SizedBox.square(
        dimension: width,
        child: image,
      ),
    );
  }
}
