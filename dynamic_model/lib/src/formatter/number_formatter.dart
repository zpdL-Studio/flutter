import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class TextInputNumberFormatter extends TextInputFormatter {
  final NumberFormat numberFormat;

  TextInputNumberFormatter(this.numberFormat);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final digitsOnlyValue = FilteringTextInputFormatter.digitsOnly
        .formatEditUpdate(oldValue, newValue);

    if (digitsOnlyValue.text.isEmpty) {
      return digitsOnlyValue;
    }

    int? value = int.tryParse(digitsOnlyValue.text);
    if (value == null) {
      return oldValue;
    }

    final regExp = RegExp('[^0-9]');
    final String newText = numberFormat.format(value);
    final List<String> characters = newText.characters.toList();

    int dotCount = 0;
    int offsetCount = 0;
    int offset = digitsOnlyValue.selection.baseOffset;
    for (int i = 0; i < characters.length; i++) {
      if (offsetCount >= offset) {
        break;
      }

      if (regExp.hasMatch(characters[i])) {
        dotCount++;
      } else {
        offsetCount++;
      }
    }

    return digitsOnlyValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(
            offset: digitsOnlyValue.selection.baseOffset + dotCount));
  }

  static String digitToText(String digit, NumberFormat numberFormat) {
    return numberFormat.format(digit);
  }

  static String textToDigit(String text) {
    RegExp regex = RegExp(r'\d+');
    Iterable<Match> matches = regex.allMatches(text);

    final sb = StringBuffer();
    for (Match match in matches) {
      sb.write(match.group(0)!);
    }

    return sb.toString();
  }
}

abstract class DigitsOnlyFormatter {
  NumberFormat get formatter;

  int parse(String value) => formatter.parse(value).floor();

  String format(int value) => formatter.format(value);

  int? tryParse(String? value) {
    final trimValue = value?.trim();
    if (trimValue != null && trimValue.isNotEmpty) {
      try {
        return formatter.parse(trimValue).floor().toInt();
      } catch (_) {}
    }
    return null;
  }

  String? tryFormat(int? value) {
    if (value != null) {
      try {
        return formatter.format(value);
      } catch (_) {}
    }
    return null;
  }
}
