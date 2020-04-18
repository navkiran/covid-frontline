import 'package:flutter/material.dart';

const String kAppName = 'Covid Frontline';

//STYLES
const TextStyle kOptionStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
//FONTS
const String kfont1 = 'Staatliches';
//COLORS
// const Color kBgcolor = Color(0xff272936);
// const Color kFgcolor = Color(0xff3d3f50);
const Color kBgcolor = Colors.white;
const Color kFgcolor = Color.fromRGBO(252, 3, 78, 1);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(fontSize: 20),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(4.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(4.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 4.0),
    borderRadius: BorderRadius.all(Radius.circular(4.0)),
    gapPadding: 10.0,
  ),
);

const kFormTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(fontSize: 20),
  labelStyle: TextStyle(color: kFgcolor),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(4.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(4.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 4.0),
    borderRadius: BorderRadius.all(Radius.circular(4.0)),
    gapPadding: 10.0,
  ),
);
