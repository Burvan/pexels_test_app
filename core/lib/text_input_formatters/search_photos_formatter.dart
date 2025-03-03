import 'package:flutter/services.dart';

class SearchPhotosFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String filteredText =
        newValue.text.replaceAll(RegExp(r'[^\w\s]'), '');

    return TextEditingValue(
      text: filteredText,
      selection: TextSelection.collapsed(offset: filteredText.length),
    );
  }
}
