import 'package:flutter/material.dart';

import '../../constants/styles/text_styles.dart';

Widget userImageByName(String userName) {
  String nickName = "";
  final List userNames = userName.split(' ');
  nickName = userNames[0][0].toUpperCase();
  if (userNames.length > 1) {
    nickName += userNames[1][0].toUpperCase();
  }
  return Center(
    child: Text(
      nickName,
      style: h3LargeTransparent,
    ),
  );
}

AssetImage defaultUserImage = const AssetImage("assets/user.png");
