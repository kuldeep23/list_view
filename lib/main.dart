import 'package:flutter/material.dart';
import 'package:list_view/index.dart';
import 'package:list_view/theme/colors.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: primary),
    home: Index(),
  ));
}
