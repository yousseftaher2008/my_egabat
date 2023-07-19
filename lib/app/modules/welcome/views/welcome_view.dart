import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:introduction_screen/introduction_screen.dart";
import "package:my_egabat/app/modules/welcome/controllers/welcome_controller.dart";

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          IntroductionScreen(
            globalBackgroundColor: const Color(0xFF666D73),
            pages: [
              PageViewModel(
                decoration: const PageDecoration(
                  pageColor: Color(0xFF666D73),
                ),
                titleWidget: const Text(
                  "Explore your new skills Today",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                  textAlign: TextAlign.start,
                ),
                bodyWidget: const Text(
                  "You can learn various kinds of courses in your hand",
                  style: TextStyle(
                    color: Color(0xFF949FA6),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                image: Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset("assets/first_welcome_image.png"),
                ),
              ),
              PageViewModel(
                decoration: const PageDecoration(),
                titleWidget: const Text(
                  "Explore your new skills Today",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                  textAlign: TextAlign.start,
                ),
                bodyWidget: const Text(
                  "You can learn various kinds of courses in your hand",
                  style: TextStyle(
                    color: Color(0xFF949FA6),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                image: Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset("assets/second_welcome_image.png"),
                ),
              ),
            ],
            showBackButton: true,
            showNextButton: true,
            back: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                const Color(0xFF232426),
              )),
              onPressed: null,
              child: const Text(
                "Back",
                style: TextStyle(color: Colors.white),
              ),
            ),
            next: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                const Color(0xFF232426),
              )),
              onPressed: null,
              child: const Text(
                "Next",
                style: TextStyle(color: Colors.white),
              ),
            ),
            done: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                const Color(0xFF232426),
              )),
              onPressed: null,
              child: const Text(
                "Done",
                style: TextStyle(color: Colors.white),
              ),
            ),
            onDone: controller.done,
            dotsDecorator: DotsDecorator(
              color: Colors.white,
              activeColor: Colors.white,
              activeSize: const Size(30, 7),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              size: const Size.square(7),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: controller.done,
                child: const Text(
                  "Skip",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
