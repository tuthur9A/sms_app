import 'dart:ffi';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_sms/flutter_sms.dart';


import 'chat.dart';
import 'listContact.dart';

void main() {
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
        primaryColor: Colors.blueAccent,
        primaryIconTheme: const IconThemeData(color: Colors.white, size: 20, opacity: 1.0)
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> people = [];

  @override
  void initState() {
    super.initState();
  }


  Widget cardChat(Contact contact) {
    // ignore: sized_box_for_whitespace
    return Container(
      width: double.infinity,
      height: 60,
      child: Row(children: [
          (contact.photo != null && contact.photo!.isNotEmpty) ?  CircleAvatar(backgroundImage: MemoryImage(contact.photo! , scale: 1.0)) : CircleAvatar(
                          child: const Text('AC'),
                          backgroundColor: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                        ),

          Column(
            children: [Text(contact.displayName),]
            ),
        ]),
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          // ignore: sized_box_for_whitespace
          title:  Container(
                width: double.infinity,
                height: 30,
            child: const TextField(
                    decoration: InputDecoration(
                      hintText: "Rechercher",
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none
                    ),
                ),
             ),
             actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: const Icon(
                        Icons.more_vert
                    ),
                  )
                ),
             ],
             actionsIconTheme: Theme.of(context).primaryIconTheme,

        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,

          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      // ignore: deprecated_member_use
                      (states) => Theme.of(context).accentColor),
                  padding: MaterialStateProperty.resolveWith(
                      (states) => const EdgeInsets.symmetric(vertical: 16)),
                ),
                onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ChatPage()));

                },
                child: Text(
                  'page chat',
                  // ignore: deprecated_member_use
                  style: Theme.of(context).accentTextTheme.button,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      // ignore: deprecated_member_use
                      (states) => Theme.of(context).accentColor),
                  padding: MaterialStateProperty.resolveWith(
                      (states) => const EdgeInsets.symmetric(vertical: 16)),
                ),
                onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => FlutterContactsExample()));

                },
                child: Text(
                  'page list contact',
                  // ignore: deprecated_member_use
                  style: Theme.of(context).accentTextTheme.button,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
