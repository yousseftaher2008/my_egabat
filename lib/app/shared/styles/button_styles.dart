import 'package:flutter/material.dart';

import 'colors.dart';

ButtonStyle primaryButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(primaryButtonColor),
);

ElevatedButton welcomeButton(String text) => ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          const Color(0xFF232426),
        ),
      ),
      onPressed: null,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
