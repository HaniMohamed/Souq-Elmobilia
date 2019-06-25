import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/animation.dart';
import './first_fetch.dart';
import 'package:flutter/scheduler.dart';

String url;
bool prog = false;
bool neoFetch = true;

class WebView extends StatefulWidget {
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  initState() {
    print("weeeeeeeeeeeeeeeeeeeeeeeeeeeeebvieeeeeeeeeeeeeeeeeeeew");
    super.initState();
    geturl();

    final flutterWebviewPlugin = new FlutterWebviewPlugin();
    flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      print('################' + state.type.toString());
      setState(() {
        if (state.type == WebViewState.shouldStart) {
          print('################' + "shooooooooowwwww");
          prog = true;
        } else if (state.type == WebViewState.startLoad) {
          print('################' + "shooooooooowwwww");
          prog = true;
        } else if (state.type == WebViewState.finishLoad) {
          print('################' + "hhhiiiiiiddddddeeeee");
          prog = false;
          controller.dispose();
        }
      });
    });

    controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    controller.forward();
  }

  Widget build(BuildContext context) {
    // print('################' + url);
    return new MaterialApp(
        title: 'Souq Elmobilia',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new WebviewScaffold(
          appBar: prog
              ? PreferredSize(
                  preferredSize: Size.fromHeight(10), // here the desired height
                  child: new LinearProgressIndicator())
              : null,
          url: url,
          withZoom: false,
          withLocalStorage: true,
          hidden: false,
          initialChild: Container(
              color: Colors.white,
              height: double.maxFinite,
              child: new Stack(
                children: <Widget>[
                  new Positioned(
                    child: new Align(
                      alignment: FractionalOffset.center,
                      child: FadeTransition(
                          opacity: animation,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Image.asset(
                                  'logo.png',
                                  width: 120.0,
                                  height: 120.0,
                                  fit: BoxFit.fill,
                                ),
                              ])),
                    ),
                  ),
                  new Positioned(
                    child: new Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: new Text(
                        "جميع الحقوق محفوظه لموقع سوق الموبيليا © 2019",
                        style: TextStyle(color: Colors.black, fontSize: 12.0),
                      ),
                    ),
                  )
                ],
              )),
        ));
  }

  geturl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      url = prefs.getString('url');
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
