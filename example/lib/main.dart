import 'package:flutter/material.dart';
import 'package:custom_sheet/custom_sheet.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ExampleHome());
  }
}

class ExampleHome extends StatelessWidget {
  ExampleHome({Key key}) : super(key: key);
  final CustomSheet _sheet =  CustomSheet();

  void _showLoading(BuildContext context,{
      String text,
      Color color,
      Color textColor,
      bool dissmissable = false,
      bool draggable = false,
      bool block = true}) async {
    (_sheet..setColors(context:context,sheetColor:color,textColor:textColor)).showLoading(
      isDismissible: dissmissable,
      loadingMsg: text,
      enableDrag: draggable,
      block: block);
    if (!(dissmissable || draggable)) _sheet.dismiss(milliseconds: 3000);
  }

  void _showBottomSheetTitle(BuildContext context,
      {bool showSecondColor = false, Color secondColor}) {
    _sheet
    ..setColors(secondColor:secondColor,context:context)
    ..showTitleBody(
          title: "HI",
          body: "My name is Joe Doe",
          bodySecondColorEnabled: showSecondColor);
  }

  void _showBottomSheetTitleButton(BuildContext context,
      {String title,
      String body,
      bool showSecondColor = false,
      Color secondColor,
      double buttonHeight}) {
    _sheet
    ..setColors(context:context, secondColor: secondColor)
    ..showTitleBodyButtons(
        bodySecondColorEnabled: showSecondColor,
        buttonHeight: buttonHeight,
        title: title,
        body: body,
        options: <OptionButton>[
          OptionButton("do nothing", () {}),
          OptionButton("bye", () => Navigator.of(context).pop()),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Custom Sheet Example"), centerTitle: true),
      body: ListView(
        children: [
          FlatButton(
              onPressed: () => _showLoading(context), child: Text("Loading")),
          FlatButton(
              onPressed: () => _showLoading(context, textColor: Colors.black),
              child: Text("Loading Text black")),
          FlatButton(
              onPressed: () => _showLoading(context, color: Colors.red),
              child: Text("Loading red")),
          FlatButton(
              onPressed: () => _showLoading(context,
                  text: "Click outside the bottom sheet to dismiss",
                  dissmissable: true),
              child: Text("Loading dismissable")),
          FlatButton(
              onPressed: () => _showLoading(context,
                  text: "Swipe downward to dismiss the bottom sheet",
                  draggable: true),
              child: Text("Loading draggable")),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(),
          ),
          FlatButton(
              onPressed: () => _showBottomSheetTitle(context),
              child: Text("Show bottom sheet with title and body")),
          FlatButton(
              onPressed: () =>
                  _showBottomSheetTitle(context, showSecondColor: true),
              child: Text(
                  "Show bottom sheet with title and body with second color")),
          FlatButton(
              onPressed: () => _showBottomSheetTitle(context,
                  showSecondColor: true, secondColor: Colors.red),
              child: Text(
                  "Show bottom sheet with title and body with custom second color")),
          FlatButton(
              onPressed: () => _showBottomSheetTitleButton(context,
                  title: "HELLO", body: "My name is Joe Doe"),
              child: Text("Show bottom sheet with title body and buttons")),
          FlatButton(
              onPressed: () => _showBottomSheetTitleButton(
                    context,
                    title: "HELLO",
                  ),
              child: Text("Show bottom sheet with title and buttons")),
          FlatButton(
              onPressed: () => _showBottomSheetTitleButton(context,
                  body: "My name is Joe Doe"),
              child: Text("Show bottom sheet with body and buttons")),
          FlatButton(
              onPressed: () => _showBottomSheetTitleButton(context,
                  body: "My name is Joe Doe", buttonHeight: 200),
              child: Text(
                  "Show bottom sheet with body and buttons with custom height")),
          FlatButton(
              onPressed: () => _showBottomSheetTitleButton(context,
                  body: "My name is Joe Doe", secondColor: Colors.black),
              child: Text("Show bottom sheet with body and colored buttons ")),
          FlatButton(
              onPressed: () => _sheet
              ..context=context
              ..showTitleBodyButtons(
                      title: "HEY",
                      body: "YOU",
                      options: <SizedBox>[
                        SizedBox(
                            width: double.infinity,
                            child: RaisedButton(
                                child: Text("BUTTON 1"), onPressed: () {})),
                        SizedBox(
                            width: double.infinity,
                            child: RaisedButton(
                                child: Text("BUTTON 2"), onPressed: () {})),
                      ]),
              child: Text("Show bottom sheet with custom buttons ")),
          FlatButton(
              onPressed: () => _sheet.showBS(
                context: context,
                  top: Icon(Icons.ac_unit), body: Text("My name is Joe Doe")),
              child: Text("Show bottom sheet with custom title and body ")),
        ],
      ),
    );
  }
}
