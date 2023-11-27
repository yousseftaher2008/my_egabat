import 'package:flutter/material.dart';

import '../../../../../core/constants/styles/colors.dart';
import '../../../../../data/models/subject.dart';
import '../widgets/unit_item.dart';

class UnitsScreen extends StatelessWidget {
  const UnitsScreen(this.subject, {super.key});
  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: infoColor,
        title: Text(subject.name),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: subject.units.length,
        itemBuilder: (context, index) {
          return UnitItem(subject.units[index]);
        },
      ),
    );
  }
}
