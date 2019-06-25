import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './main.dart';
import './webview.dart';

class firstFetch extends StatefulWidget {
  _firstFetchState createState() => _firstFetchState();
}

class _firstFetchState extends State<firstFetch> with TickerProviderStateMixin {
  bool _visible = false;
  double opacity = 0.0;

  initState() {
    checkURL();
    print("firsssssssssssssssssssssssst");
    super.initState();
    setState(() {
      _visible = !_visible;
    });
  }

  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Souq Elmobilia',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new Scaffold(
            backgroundColor: Colors.white,
            body: Container(
                color: Colors.white,
                height: double.maxFinite,
                child: new Stack(
                  children: <Widget>[
                    new Positioned(
                      child: new Align(
                          alignment: FractionalOffset.topCenter,
                          child: new Stack(
                            children: <Widget>[
                              new Container(
                                  height: double.maxFinite,
                                  width: double.maxFinite,
                                  decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                      image: new AssetImage("back.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: new Container(
                                    decoration: new BoxDecoration(
                                        border: new Border.all(
                                            width: double.maxFinite,
                                            color: Colors
                                                .transparent), //color is transparent so that it does not blend with the actual color specified
                                        color: new Color.fromRGBO(0, 0, 0,
                                            0.7) // Specifies the background color and the opacity
                                        ),
                                  )),
                            ],
                          )),
                    ),
                    new Container(
                        height: double.maxFinite,
                        width: double.maxFinite,
                        child: new Padding(
                            padding: EdgeInsets.only(top: 60),
                            child: new Column(
                              children: <Widget>[
                                new Image.asset(
                                  "logo.png",
                                  height: 120,
                                  width: 120,
                                ),
                                new Text(
                                  "بيع - اشتري - قسط",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800),
                                )
                              ],
                            ))),
                    new Positioned(
                        child: new Opacity(
                            opacity: opacity,
                            child: new Align(
                                alignment: FractionalOffset.bottomCenter,
                                child: new Padding(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Padding(
                                          padding: EdgeInsets.all(10),
                                          child: new GestureDetector(
                                              onTap: () {
                                                seturl(
                                                    "https://eg.souqelmobilia.com/");
                                              },
                                              child: new Image.asset(
                                                "eg.png",
                                                width: 50,
                                                height: 50,
                                              ))),
                                      new Padding(
                                          padding: EdgeInsets.all(10),
                                          child: new GestureDetector(
                                              onTap: () {
                                                seturl(
                                                    "https://sa.souqelmobilia.com/");
                                              },
                                              child: new Image.asset(
                                                "sa.png",
                                                width: 50,
                                                height: 50,
                                              )))
                                    ],
                                  ),
                                )))),
                    new Positioned(
                        child: new Opacity(
                            opacity: opacity,
                            child: new Align(
                                alignment: FractionalOffset.bottomCenter,
                                child: new Padding(
                                  padding: EdgeInsets.only(bottom: 100),
                                  child: new Text(
                                    "مرحبا بك, الرجاء إختيار دولتك",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ))))
                  ],
                ))));
  }

  seturl(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('url', url);
      prefs.setBool('new', false);
    });

    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return WebView();
    }));
  }

  checkURL() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.getString('url') == null) {
        opacity = 1.0;
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return WebView();
        }));
      }
    });
  }
}
