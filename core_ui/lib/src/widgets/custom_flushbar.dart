import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';

class CustomFlushbar extends StatelessWidget {
  final String messageText;
  final Color color;

  const CustomFlushbar({
    required this.messageText,
    required this.color,
    super.key,
  });

  void show(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    Flushbar(
      messageText: Text(
        messageText,
        textAlign: TextAlign.center,
        style: AppTextTheme.font19Bold.copyWith(
          color: color,
        ),
      ),
      backgroundColor: themeData.focusColor,
      flushbarPosition: FlushbarPosition.TOP,
      padding: const EdgeInsets.all(AppPadding.padding20),
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
