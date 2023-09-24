import 'package:flutter/material.dart';

import '../../constants/styles/colors.dart';

Widget firstAppBar({required Widget child}) => DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment(-1.15, -1.986),
            end: Alignment(1, 0),
            colors: [
              primaryColor,
              primaryColorLight,
              primaryColorLight,
              primaryColorLight,
            ],
            stops: [
              0.5,
              0.7,
              0.75,
              1
            ]),
      ),
      child: child,
    );
    //     gradient: LinearGradient(
    //       begin: const Alignment(1, 0),
    //       end: const Alignment(-1.15, -1.986),
    //       // colors: appBarBackgroundColors,
    //       stops: const <double>[0, 0.225, 0.393, 0.547, 0.785, 0.875, 1],
    //     ),
    //   ),
    // );
