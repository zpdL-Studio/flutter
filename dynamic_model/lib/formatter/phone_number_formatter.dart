import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputPhoneNumberFormatter extends TextInputFormatter {
  static const length = 16;
  final TextInputFormatter digitsOnly = FilteringTextInputFormatter.digitsOnly;

  TextInputPhoneNumberFormatter();

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digitsOnlyValue = FilteringTextInputFormatter.digitsOnly
        .formatEditUpdate(oldValue, newValue);

    if (digitsOnlyValue.text.length > length) {
      return oldValue;
    }

    if (digitsOnlyValue.text.isEmpty) {
      return digitsOnlyValue;
    }

    final regExp = RegExp('[^0-9]');
    final String newText = digitToText(digitsOnlyValue.text);
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

  static String digitToText(String digit) {
    StringBuffer sb = StringBuffer();
    if (digit.length > 10) {
      for (int i = 0; i < digit.length; i++) {
        if (i == 3 || i == 7) {
          sb.write('-');
        }
        sb.write(digit[i]);
      }
    } else {
      for (int i = 0; i < digit.length; i++) {
        if (i == 3 || i == 6) {
          sb.write('-');
        }
        sb.write(digit[i]);
      }
    }
    return sb.toString();
  }

  static String textToDigit(String text) {
    final cardNumber = text.split('-');
    return cardNumber.reduce((value, element) => '$value$element');
  }
}
