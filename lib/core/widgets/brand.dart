import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class Brand extends StatelessWidget {
  const Brand({super.key, this.small = false});
  final bool small;
  @override
  Widget build(BuildContext c) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: small ? 38 : 54,
        height: small ? 38 : 54,
        decoration: BoxDecoration(
          color: orange,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(
          Icons.delivery_dining,
          color: Colors.white,
          size: small ? 23 : 31,
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
