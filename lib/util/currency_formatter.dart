import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final int maxDigits;
  CurrencyInputFormatter({this.maxDigits});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(
          text: '0', selection: const TextSelection.collapsed(offset: 1));
    } else {
      final f = NumberFormat('#,###', "id");
      int numNew = int.parse(newValue.text.replaceAll(f.symbols.GROUP_SEP, ''));
      final stringNew = f.format(numNew);

      if (stringNew.length > maxDigits) {
        return oldValue;
      } else if (stringNew.compareTo(oldValue.text) != 0) {
        int selectionIndexFromTheRight =
            newValue.text.length - newValue.selection.end;

        return TextEditingValue(
          text: stringNew,
          selection: TextSelection.collapsed(
              offset: stringNew.length), // - selectionIndexFromTheRight),
        );
      } else {
        return newValue;
      }
    }
  }
}
