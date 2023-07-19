import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:url_launcher/url_launcher.dart' as launch;
import '../styles/colors.dart';
import 'errors_messages.dart';

class HelpButton extends StatelessWidget {
  const HelpButton(
      {required this.phoneNumber, this.startMessage = "", super.key});

  final String phoneNumber;
  final String startMessage;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          backgroundColor: primaryColorTransparent,
          // backgroundColor: Colors.transparent,
          side: const BorderSide(
            color: Colors.white,
            width: 2,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      icon: const Icon(FontAwesome.whatsapp),
      onPressed: () async {
        final Uri whatsappLink =
            Uri.parse("whatsapp://send?phone=$phoneNumber&text=$startMessage");
        // final Uri whatsappLink =
        // Uri.parse("whatsapp://send?phone=$phoneNumber&text=$startMessage");
        try {
          await launch.canLaunchUrl(whatsappLink)
              ? await launch.launchUrl(whatsappLink)
              : whatsappLauncherError();
        } catch (e) {
          whatsappLauncherError();
        }
      },
      label: const Text(
        "المساعدة",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
