import 'package:chatgptclone/constants/constants.dart';
import 'package:chatgptclone/provider/model_proivder.dart';
import 'package:chatgptclone/services/apiservices.dart';
import 'package:chatgptclone/widgets/textwidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class modalesheetdropdownbutton extends StatefulWidget {
  const modalesheetdropdownbutton({super.key});

  @override
  State<modalesheetdropdownbutton> createState() =>
      modalesheetdropdownbuttonState();
}

class modalesheetdropdownbuttonState extends State<modalesheetdropdownbutton> {
  String? currentmodel;
  @override
  Widget build(BuildContext context) {
    final modelproviders = Provider.of<modelprovider>(context, listen: false);
    currentmodel = modelproviders.getcurrentModel;
    return FutureBuilder(
        future: modelproviders.getallmodels(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: textwidget(label: "${snapshot.error}"),
            );
          }
          return snapshot.data == null || snapshot.data!.isEmpty
              ? SizedBox.shrink()
              : FittedBox(
                  child: DropdownButton(
                    dropdownColor: scaffoldBackgroundColor,
                    iconEnabledColor: Colors.white,
                    items: List<DropdownMenuItem<String>>.generate(
                        snapshot.data!.length,
                        (index) => DropdownMenuItem(
                            value: snapshot.data![index].id,
                            child: textwidget(
                              label: snapshot.data![index].id,
                              fontsize: 15,
                            ))),
                    value: currentmodel,
                    onChanged: (value) {
                      setState(() {
                        currentmodel = value.toString();
                      });
                      modelproviders.setcurrentModel(value.toString());
                    },
                  ),
                );
        });
  }
}
