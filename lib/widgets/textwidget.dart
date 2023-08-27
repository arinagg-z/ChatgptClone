import 'package:flutter/material.dart';

class textwidget extends StatelessWidget {
  final String label;
  final double? fontsize;
  final Color? color;
  final FontWeight? fontweight;

  const textwidget({super.key, required this.label, this.fontsize, this.color, this.fontweight});


  @override
  Widget build(BuildContext context) {
    return Text(
      label , style : TextStyle(
        color:color?? Colors.white , fontSize: fontsize?? 18 , fontWeight: fontweight??FontWeight.w600
      )
    );
  }
}