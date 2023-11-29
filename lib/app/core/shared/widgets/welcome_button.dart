import 'package:flutter/material.dart';

import '../../constants/styles/button_styles.dart';
import '../../constants/styles/text_styles.dart';

ElevatedButton welcomeButton(String text) => ElevatedButton(
      style: primaryButtonStyle,
      onPressed: null,
      child: Text(
        text,
        style: h5RegularWhite,
      ),
    );
