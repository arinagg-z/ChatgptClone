import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatgptclone/constants/constants.dart';
import 'package:chatgptclone/services/assestmanager.dart';
import 'package:chatgptclone/widgets/textwidget.dart';
import 'package:flutter/material.dart';

class chatwidget extends StatelessWidget {
  final String msg;
  final int chatindex;

  const chatwidget({super.key, required this.msg, required this.chatindex});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: chatindex == 1 ? scaffoldBackgroundColor : cardColor,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  chatindex == 1
                      ? assestmanager.person
                      : assestmanager.chatlogo,
                  height: 30,
                  width: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: chatindex == 1
                        ? textwidget(label: msg)
                        : DefaultTextStyle(
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                            child: AnimatedTextKit(
                                repeatForever: false,
                                totalRepeatCount: 1,
                                isRepeatingAnimation: false,
                                displayFullTextOnTap: true,
                                animatedTexts: [TyperAnimatedText(msg)]),
                          )),
                chatindex == 1
                    ? SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.thumb_up_alt_outlined,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.thumb_down_alt_outlined,
                                color: Colors.white,
                              ))
                        ],
                      )
              ],
            ),
          ),
        )
      ],
    );
  }
}
