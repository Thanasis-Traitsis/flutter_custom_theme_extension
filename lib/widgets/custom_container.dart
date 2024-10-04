import 'package:flutter/material.dart';

import '../theme/grass_type_theme.dart';

class CustomContainer extends StatelessWidget {
  final String text;
  final String img;

  const CustomContainer({
    super.key,
    required this.text,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    final containerTheme = Theme.of(context).extension<GrassTypeTheme>();

    return Container(
      width: 300,
      height: 200,
      padding: containerTheme?.cardPadding,
      decoration: BoxDecoration(
        borderRadius: containerTheme?.cardBorderRadius,
        color: containerTheme?.backgroundColor,
        border: Border.all(
          width: 4,
          color: containerTheme!.outlineColor,
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Positioned(
            left: 100,
            right: 0,
            top: 0,
            bottom: 0,
            child: Image.network(img),
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
