import 'package:firebase_core/firebase_core.dart';
import 'package:firebasedemo/fbfst.dart';
import 'package:firebasedemo/insertpage.dart';
import 'package:firebasedemo/logingoogl.dart';
import 'package:firebasedemo/otpdemo.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();// to initilize with fire base
  runApp(MaterialApp(home:logingoogl(),));
}
