import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // const spinkit = SpinKitRotatingCircle(
    //   color: Colors.red,
    //   size: 50.0,
    // );
    final spinkit = SpinKitFadingCircle(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.black12, // index.isEven ? Colors.red : Colors.green,
          ),
        );
      },
    );
    // final spinkit = SpinKitSquareCircle(
    //   color: Colors.white,
    //   size: 50.0,
    //   controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
    // );
    return Container(
      color: Colors.white,
      child: spinkit,
    );
  }
}
