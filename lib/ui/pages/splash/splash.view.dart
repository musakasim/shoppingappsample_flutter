import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'splash.model.dart';

class SplashView extends StatelessWidget {
  SplashView({Key key}) : super(key: key);

  final List<Widget> introPages = [
    Image(
      image: AssetImage('assets/splash1.jpg'),
      fit: BoxFit.fill,
    ),
    Image(
      image: AssetImage('assets/splash2.jpg'),
      fit: BoxFit.fill,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SplashModel(),
      child: Consumer<SplashModel>(
        builder: (context, model, child) => Stack(
          children: <Widget>[
            Container(
              child: PageView.builder(
                controller: model.pageController,
                itemBuilder: (_, index) => introPages[index],
                itemCount: model.imageCount,
                onPageChanged: (idx) => model.jumpTo(idx),
              ),
              constraints: BoxConstraints.expand(),
            ),
            Positioned(
              bottom: 50,
              child: Align(
                alignment: Alignment.center,
                child: FlatButton(
                  padding: EdgeInsets.all(5),
                  color: Colors.amber,
                  disabledColor: Colors.white12,
                  disabledTextColor: Colors.white,
                  onPressed: model.isFirstPage ? null : () => model.previous(),
                  child: Center(
                    child: Text(
                      model.isFirstPage ? "" : "Önceki",
                      style: TextStyle(fontFamily: "Roboto", fontSize: 11),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              right: 0,
              child: Align(
                alignment: Alignment.center,
                child: FlatButton(
                  padding: EdgeInsets.all(5),
                  color: Colors.amber,
                  onPressed: () => model.next(),
                  child: Center(
                    child: Text(
                      model.isLastPage ? "Başla" : "Sonraki",
                      style: TextStyle(fontFamily: "Roboto", fontSize: 11),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: FlatButton(
                    padding: EdgeInsets.all(5),
                    onPressed: () => model.skipFinish(),
                    child: Center(
                      child: Text(
                        "Atla",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 10,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
