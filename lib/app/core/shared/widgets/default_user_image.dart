import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      style: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 25.sp,
        color: Colors.white.withOpacity(0.9),
      ),
    ),
  );
}

AssetImage defaultUserImage = const AssetImage("assets/user.png");
