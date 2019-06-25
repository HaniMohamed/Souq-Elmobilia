import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/animation.dart';
import './first_fetch.dart';
import './webview.dart';
import 'package:flutter/scheduler.dart';

String url;
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
bool prog = false;
bool neoFetch = false;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  initState() {
    super.initState();
    geturl();
  }

  Widget build(BuildContext context) {
    geturl();
    return new MaterialApp(
        title: 'Souq Elmobilia',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: firstFetch());
  }

  geturl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      url = prefs.getString('url');
      if (url != null) {
        print("goooooooooooooooooooooooo");
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return WebView();
        }));
      } else {
        neoFetch = true;
      }
    });
  }
}