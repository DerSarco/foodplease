import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class Brand extends StatelessWidget {
  const Brand({super.key, this.small = false});
  final bool small;
  @override
  Widget build(BuildContext c) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(small ? 11 : 16),
        child: Image.asset(
          'assets/branding/app_icon.png',
          width: small ? 38 : 54,
          height: small ? 38 : 54,
          fit: BoxFit.cover,
        ),
      ),
      const SizedBox(width: 10),
      Text(
        'FoodPlease',
        style: TextStyle(
          fontSize: small ? 22 : 30,
          fontWeight: FontWeight.w900,
          color: charcoal,
          letterSpacing: -1,
        ),
      ),
    ],
  );
}
