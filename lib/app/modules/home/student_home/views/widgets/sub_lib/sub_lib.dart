import 'package:flutter/material.dart';

import 'sub_lib_grid.dart';
import 'sub_lib_head.dart';

class SubLib extends StatelessWidget {
  const SubLib(this.isSub, {super.key});
  final bool isSub;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SubLibHead(isSub),
        SubLibGrid(isSub),
      ],
    );
  }
}
