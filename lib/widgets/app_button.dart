import 'package:flutter/material.dart';



class AppButton extends StatelessWidget {
  final Function onPressedFunction;
  final Widget child;
  final double height;
  final EdgeInsets? margin;
  final Color buttonColor;
  final double? width;
  final bool sodiumShapeBorder;

  const AppButton(
      {Key? key,

        this.margin,
      required this.onPressedFunction,
      required this.child,
      required this.height,
      required this.buttonColor,
      this.sodiumShapeBorder = false,
      this.width = double.maxFinite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        margin: margin,
        width: width,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: sodiumShapeBorder
                    ? StadiumBorder()
                    : RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                primary: buttonColor,),
            onPressed: () {
              onPressedFunction();
            },
            child: child));
  }
}
