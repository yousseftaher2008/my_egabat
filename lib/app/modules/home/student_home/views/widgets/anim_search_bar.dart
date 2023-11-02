// ignore_for_file: empty_catches

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimSearchBar extends StatefulWidget {
  final double width;
  final TextEditingController textController;
  final bool rtl;
  final bool autoFocus;
  final bool boxShadow;
  final TextStyle? style;
  final bool closeSearchOnSuffixTap;
  final Color? color;
  final Color? textFieldColor;
  final Color? searchIconColor;
  final Color? textFieldIconColor;
  final Function(String) onSubmitted;
  final Function(String) onChanged;

  const AnimSearchBar({
    Key? key,
    required this.width,
    required this.textController,
    this.color = Colors.white,
    this.textFieldColor = Colors.white,
    this.searchIconColor = Colors.black,
    this.textFieldIconColor = Colors.black,
    required this.onSubmitted,
    required this.onChanged,
    this.rtl = false,
    this.autoFocus = false,
    this.boxShadow = false,
    this.style,
    this.closeSearchOnSuffixTap = false,
  }) : super(key: key);

  @override
  State<AnimSearchBar> createState() => _AnimSearchBarState();
}

class _AnimSearchBarState extends State<AnimSearchBar>
    with SingleTickerProviderStateMixin {
  RxInt toggle = 0.obs;
  late AnimationController _con;
  FocusNode focusNode = FocusNode();
  final Duration duration = const Duration(milliseconds: 375);
  @override
  void initState() {
    super.initState();

    _con = AnimationController(
      vsync: this,
      duration: duration,
    );
  }

  unfocusKeyboard() {
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      alignment:
          widget.rtl ? Alignment.centerRight : const Alignment(-1.0, 0.0),
      child: Obx(
        () => AnimatedContainer(
          duration: const Duration(milliseconds: 375),
          height: 48.0,
          width: (toggle.value == 0) ? 48.0 : widget.width,
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: toggle.value == 1 ? widget.textFieldColor : widget.color,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: !widget.boxShadow
                ? null
                : [
                    const BoxShadow(
                      color: Colors.black26,
                      spreadRadius: -10.0,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 10.0),
                    ),
                  ],
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: duration,
                top: 6.0,
                left: widget.rtl ? null : 7.0,
                right: widget.rtl ? 7.0 : null,
                curve: Curves.easeOut,
                child: AnimatedOpacity(
                  opacity: (toggle.value == 0) ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: AnimatedBuilder(
                      builder: (context, widget) {
                        return Transform.rotate(
                          angle: _con.value * 2.0 * pi,
                          child: widget,
                        );
                      },
                      animation: _con,
                      child: GestureDetector(
                        onTap: () {
                          try {
                            if (widget.textController.text == '') {
                              unfocusKeyboard();
                              toggle.value = 0;
                              _con.reverse();
                            }
                            // * why not clear textfield here?
                            widget.textController.clear();
                            widget.onChanged("");

                            ///closeSearchOnSuffixTap will execute if it's true
                            if (widget.closeSearchOnSuffixTap) {
                              unfocusKeyboard();
                              toggle.value = 0;
                            }
                          } catch (e) {}
                        },
                        child: Icon(
                          Icons.close,
                          size: 20.0,
                          color: widget.textFieldIconColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: duration,
                left: (toggle.value == 0) ? 20.0 : 40.0,
                curve: Curves.easeOut,
                top: 11.0,
                child: AnimatedOpacity(
                  opacity: (toggle.value == 0) ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    alignment: Alignment.topCenter,
                    width: widget.width / 1.7,
                    child: TextField(
                      controller: widget.textController,
                      focusNode: focusNode,
                      cursorRadius: const Radius.circular(10.0),
                      cursorWidth: 2.0,
                      onChanged: widget.onChanged,
                      onSubmitted: widget.onSubmitted,
                      style:
                          widget.style ?? const TextStyle(color: Colors.black),
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(bottom: 5),
                        isDense: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: "...ابحث".tr,
                        labelStyle: const TextStyle(
                          color: Color(0xff5B5B5B),
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Material(
                color: toggle.value == 0 ? widget.color : widget.textFieldColor,
                borderRadius: BorderRadius.circular(30.0),
                child: IconButton(
                  splashRadius: 19.0,
                  icon: toggle.value == 1
                      ? Icon(
                          Icons.arrow_back_ios,
                          color: widget.textFieldIconColor,
                        )
                      : Icon(
                          toggle.value == 1
                              ? Icons.arrow_back_ios
                              : Icons.search,
                          // search icon color when closed
                          color: toggle.value == 0
                              ? widget.searchIconColor
                              : widget.textFieldIconColor,
                          size: 20.0,
                        ),
                  onPressed: () {
                    if (toggle.value == 0) {
                      toggle.value = 1;
                      if (widget.autoFocus) {
                        FocusScope.of(context).requestFocus(focusNode);
                      }

                      _con.forward();
                    } else {
                      unfocusKeyboard();
                      toggle.value = 0;
                      _con.reverse();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
