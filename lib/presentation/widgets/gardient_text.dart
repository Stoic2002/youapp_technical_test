import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  const GradientText({
    super.key,
    required this.text,
    this.style,
    required this.gradient,
    this.underline = false,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;
  final bool underline;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => gradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: Text(text, style: style),
        ),
        if (underline)
          Positioned(
            bottom: 0,
            child: Container(
              height: 1,
              width: text.length * 12.0,
              decoration: BoxDecoration(
                gradient: gradient,
              ),
            ),
          ),
      ],
    );
  }
}
