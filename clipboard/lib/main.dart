import 'dart:async';
import 'dart:io';
import 'package:hive/hive.dart';
import 'main_page.dart';
import 'hive_base.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as pp;

void main() async {
  final appDocumentDir = Directory.current;
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(ClipboardAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: Hive.openBox("Clip_board"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError)
              return Text(snapshot.error.toString());
            else
              return home_page();
          }
          // Although opening a Box takes a very short time,
          // we still need to return something before the Future completes.
          else
            return Scaffold();
        },
      ),
    );
  }
}
