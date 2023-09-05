// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget LargeLottieLoading() => _LottieLoading(250, 150);
Widget MediumLottieLoading() => _LottieLoading(150, 100);
Widget SmallLottieLoading() => _LottieLoading(75, 50);

Widget _LottieLoading(double width, double height) => Center(
      child: SizedBox(
        height: height,
        width: width,
        child: Lottie.asset('assets/default_lottie_loading.json'),
      ),
    );
