import 'package:flutter/material.dart';

import '../../localization/local.dart';
import '../../../data/models/app_local.dart';
import 'colors.dart';

TextStyle welcomeTitleTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: appLocal == AppLocal.ar ? 35 : 27,
);

TextStyle welcomeBodyTextStyle = TextStyle(
  color: welcomeBodyTextColor,
  fontSize: appLocal == AppLocal.ar ? 20 : 17,
  fontWeight: FontWeight.w400,
);
const TextStyle textFormFieldStyle = TextStyle(
  color: primaryColorTransparent,
  fontWeight: FontWeight.bold,
);
