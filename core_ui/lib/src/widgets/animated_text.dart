import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class AnimatedText extends StatelessWidget {
  final String text;
  final Duration? speed;

  const AnimatedText({
    super.key,
    required this.text,
    this.speed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.padding20),
      child: DefaultTextStyle(
        style: AppTextTheme.font19Bold.copyWith(
          color: AppColors.turquoise,
        ),
        child: AnimatedTextKit(
          totalRepeatCount: 1,
          animatedTexts: [
            TyperAnimatedText(
              text,
              textAlign: TextAlign.center,
              speed: speed ?? const Duration(milliseconds: 100),
            ),
          ],
        ),
      ),
    );
  }
}