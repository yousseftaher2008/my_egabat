import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/app_local.dart';
import '../../localization/local.dart';
import 'colors.dart';

//weights values
const TextStyle largeWeight = TextStyle(fontWeight: FontWeight.w900);
const TextStyle boldWeight = TextStyle(fontWeight: FontWeight.bold);
const TextStyle lightWeight = TextStyle(fontWeight: FontWeight.w300);
//sizes

TextStyle xLargeSize = TextStyle(fontSize: 50.sp);
TextStyle h1Size = TextStyle(fontSize: 30.sp);
TextStyle h2Size = TextStyle(fontSize: 25.sp);
TextStyle h3Size = TextStyle(fontSize: 18.sp);
TextStyle h4Size = TextStyle(fontSize: 16.sp);
TextStyle h6Size = TextStyle(fontSize: 12.sp);
// default colors
const TextStyle primaryTextStyle = TextStyle(color: primaryColor);
const TextStyle whiteTextStyle = TextStyle(color: whiteColor);
const TextStyle secondaryTextStyle = TextStyle(color: secondaryColorDark);
const TextStyle greyTextStyle = TextStyle(color: Color(0XFFDDDDDD));
const TextStyle dangerTextStyle = TextStyle(color: dangerColor);
const TextStyle blackTextStyle = TextStyle(color: blackColor);
const TextStyle infoTextStyle = TextStyle(color: infoColor);

//? h1 bold
TextStyle h1Primary = boldWeight.merge(h1Size).merge(primaryTextStyle);
TextStyle h1Black = boldWeight.merge(h1Size);

//? h1 large
TextStyle h1LargePrimary =
    h1Size.merge(whiteTextStyle).merge(largeWeight).merge(primaryTextStyle);

//? h2
TextStyle h2 = boldWeight.merge(h2Size).merge(primaryTextStyle);
TextStyle h2Info = boldWeight.merge(h2Size).merge(infoTextStyle);
TextStyle h2Black = boldWeight.merge(h2Size);

//? h3 regular
TextStyle h3RegularPrimary = h3Size.merge(primaryTextStyle);
TextStyle h3RegularGrey = h3Size.merge(greyTextStyle);
TextStyle h3RegularBlack = h3Size;
TextStyle h3RegularWhite = h3Size.merge(whiteTextStyle);

//? h3 bold
TextStyle h3BoldGrey = boldWeight.merge(h3Size).merge(secondaryTextStyle);
TextStyle h3BoldWhite = boldWeight.merge(h3Size).merge(whiteTextStyle);
TextStyle h3BoldDanger = boldWeight.merge(h3Size).copyWith(color: dangerColor);
TextStyle h3BoldPrimary =
    boldWeight.merge(h3Size).copyWith(color: primaryColor);
TextStyle h3BoldBlack = boldWeight.merge(h3Size);

//? h3 large
TextStyle h3LargeTransparent = h3Size.merge(largeWeight).copyWith(
      color: Colors.white.withOpacity(0.9),
    );
//? h4 regular
TextStyle h4RegularPrimary = h4Size.merge(primaryTextStyle);
TextStyle h4RegularBlack = h4Size;
TextStyle h4RegularGrey = h4Size.merge(secondaryTextStyle);
TextStyle h4RegularGrey2 = h4Size.copyWith(color: const Color(0XFFCBCBCB));
TextStyle h4RegularWhite = h4Size.merge(whiteTextStyle);
TextStyle h4RegularDanger = h4Size.merge(dangerTextStyle);
TextStyle h4RegularInfo = h4Size.merge(infoTextStyle);

//? h4 bold
TextStyle h4BoldWhite = boldWeight.merge(h4Size).merge(whiteTextStyle);
TextStyle h4BoldBlack = boldWeight.merge(h4Size);
TextStyle h4BoldPrimary = boldWeight.merge(h4Size).merge(primaryTextStyle);
TextStyle h4BoldOrange =
    boldWeight.merge(h4Size).copyWith(color: const Color(0xFFFB8C00));

//? h5 regular
const TextStyle h5RegularPrimary = primaryTextStyle;
const TextStyle h5RegularGrey = secondaryTextStyle;
const TextStyle h5RegularGrey2 = greyTextStyle;
const TextStyle h5RegularWhite = whiteTextStyle;
const TextStyle h5RegularYellow = TextStyle(color: Color(0xFFF0BF41));

//? h5 bold
TextStyle h5Bold = boldWeight.merge(primaryTextStyle);

//? h6 light
TextStyle h6Light = lightWeight.merge(h6Size).merge(secondaryTextStyle);

//? h6 regular
TextStyle h6RegularBlack = h6Size;
TextStyle h6RegularGrey = h6Size.merge(secondaryTextStyle);
TextStyle h6RegularWhite = h6Size.merge(whiteTextStyle);

//? h6 bold
TextStyle h6Bold = boldWeight.merge(h6Size).merge(whiteTextStyle);

//? Large textStyle
TextStyle xLargeBoldWhite = xLargeSize.merge(whiteTextStyle).merge(boldWeight);

//? custom textStyles
TextStyle welcomeTitleTextStyle = boldWeight.merge(
  TextStyle(
    color: Colors.white,
    fontSize: appLocal == AppLocal.ar ? 35.sp : 27.sp,
  ),
);

TextStyle welcomeBodyTextStyle = TextStyle(
  color: secondaryColorLight,
  fontSize: appLocal == AppLocal.ar ? 20.sp : 17.sp,
);
