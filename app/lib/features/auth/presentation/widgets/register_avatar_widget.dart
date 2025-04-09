import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Display avatar or default profile picture.
class RegisterAvatarWidget extends StatelessWidget {
  const RegisterAvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SvgPicture.asset(
        'lib/assets/profile-default.svg',
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
    );
  }
}
