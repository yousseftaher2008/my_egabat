import 'package:flutter/material.dart';

import 'colors.dart';

OutlineInputBorder defaultBorder([Color color = primaryColorLight]) =>
    OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        width: 1.5,
        color: color,
      ),
    );
InputDecoration authInputDecoration({String? labelText, String? hintText}) {
  return InputDecoration(
    labelText: labelText,
    hintText: hintText,
    border: defaultBorder(),
    focusedBorder: defaultBorder(),
    enabledBorder: defaultBorder(),
    errorBorder: defaultBorder(Colors.red),
    focusedErrorBorder: defaultBorder(Colors.red),
  );
}
