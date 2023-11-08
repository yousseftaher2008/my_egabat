import 'package:flutter/material.dart';

import '../../../../../../core/constants/styles/colors.dart';
import '../../../../../../data/models/library.dart';
import '../../../../../../data/models/subject.dart';

class SubLibGridItem extends StatelessWidget {
  const SubLibGridItem({this.subject, this.library, super.key});
  final Subject? subject;
  final Library? library;

  @override
  Widget build(BuildContext context) {
    final bool isSub;
    if (subject == null && library != null) {
      isSub = false;
    } else if (subject != null && library == null) {
      isSub = true;
    } else {
      throw Exception("must insert only sub or lib");
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Container(
            width: double.maxFinite,
            decoration: const BoxDecoration(
              color: infoColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              ),
            ),
            key: UniqueKey(),
            child: isSub
                ? subject!.image == null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/subject.png"),
                      )
                    : FadeInImage(
                        placeholder: const AssetImage("assets/subject.png"),
                        image: NetworkImage(subject!.image!),
                        fit: BoxFit.fill,
                      )
                : library!.image == null
                    ? Image.asset("assets/library.png")
                    : FadeInImage(
                        placeholder: const AssetImage("assets/library.png"),
                        image: NetworkImage(library!.image!),
                      ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 2, color: infoColor),
            boxShadow: const [
              BoxShadow(
                offset: Offset(10, 10),
                blurRadius: 20,
                color: Colors.black45,
              ),
            ],
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
          ),
          width: double.infinity,
          child: Center(
            child: DefaultTextStyle(
              style: const TextStyle(
                color: infoColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              softWrap: false,
              overflow: TextOverflow.fade,
              child: Text(
                subject?.name ?? library!.name,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
