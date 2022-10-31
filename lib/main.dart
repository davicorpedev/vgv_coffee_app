import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vgv_coffee_app/presentation/app.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}
