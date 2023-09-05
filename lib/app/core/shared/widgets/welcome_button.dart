import 'package:flutter/material.dart';
import 'package:my_egabat/app/core/constants/styles/button_styles.dart';

ElevatedButton welcomeButton(String text) => ElevatedButton(
      style: primaryButtonStyle,
      onPressed: null,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
