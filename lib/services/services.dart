import 'package:chatgptclone/widgets/dropdownbutton.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../widgets/textwidget.dart';

class Services {
  static Future<void> showbottommodalsheet(BuildContext context) async {
    await showModalBottomSheet(
        backgroundColor: scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(17.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: textwidget(
                    label: "Choose Model :",
                    fontsize: 16,
                  ),
                ),
                Flexible(flex: 2, child: modalesheetdropdownbutton()),
              ],
            ),
          );
        });
  }
}
