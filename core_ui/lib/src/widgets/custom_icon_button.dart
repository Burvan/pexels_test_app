import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Function() onPressed;
  final Icon icon;

  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.turquoiseWithOpacity,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        color: AppColors.turquoise,
        icon: icon,
        onPressed: onPressed,
      ),
    );
  }
}
