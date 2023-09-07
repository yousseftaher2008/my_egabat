import 'package:flutter/material.dart';

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
      style: const TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 25,
      ),
    ),
  );
}

AssetImage defaultUserImage = const AssetImage("assets/user.png");
