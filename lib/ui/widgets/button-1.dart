import 'package:flutter/material.dart';
import 'package:shoppingappsampleflutter/ui/pages/base.model.dart';

class Button1 extends StatelessWidget {
  Button1({
    Key key,
    this.text,
    @required this.onTap,
    @required this.model,
    Color textColor,
    Color boxDecorationColor,
    Color boxShadowColor,
    Color circularProgressIndicatorColor,
    Color errorTextColor,
  }) : super(key: key) {
    if (textColor != null) {
      this.textStyle = TextStyle(
        color: textColor,
        fontSize: 20,
        fontWeight: FontWeight.w300,
      );
    }
    if (errorTextColor != null) {
      this.errorTextStyle = TextStyle(
        color: errorTextColor,
        fontSize: 20,
        fontWeight: FontWeight.w300,
      );
    }
    if (boxDecorationColor != null) {
      this.boxDecorationColor = boxDecorationColor;
    }
    if (boxShadowColor != null) {
      this.boxShadowColor = boxShadowColor;
    }
    if (circularProgressIndicatorColor != null) {
      this.circularProgressIndicatorColor = circularProgressIndicatorColor;
    }
  }

  final String text;
  final Function onTap;
  final BaseModel model;
  TextStyle errorTextStyle = TextStyle(
    color: Colors.red[800],
    fontSize: 20,
    fontWeight: FontWeight.w300,
  );

  TextStyle textStyle = TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.w800,
  );
  Color boxShadowColor = Colors.blue[200];
  Color boxDecorationColor = Colors.blue;
  Color circularProgressIndicatorColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          model.hasErrorMessage
              ? Text(
                  model.errorMessage,
                  style: errorTextStyle,
                )
              : Container(),
          Container(
            width: 200,
            height: 80,
            alignment: Alignment.center,
            child: model.state != ViewState.Busy
                ? Text(
                    text,
                    style: textStyle,
                  )
                : CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white),),
            decoration: BoxDecoration(
              color: boxDecorationColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: boxShadowColor,
                  blurRadius: 8,
                  spreadRadius: 2,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
