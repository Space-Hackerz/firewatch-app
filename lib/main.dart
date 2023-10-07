import 'package:firewatch/Pages/general_information_page.dart';
import 'package:firewatch/Pages/interactive_map_page.dart';
import 'package:firewatch/Pages/login_screen_page.dart';
import 'package:firewatch/Pages/wildfire_information_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(

  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF851229))
  ),

  routes: {
    '/': (context) => LoginScreen(),
    '/WildfireInfo': (context) => WildfireInformation(),
    '/InterMap': (context) => InteractiveMap(),
    '/GeneralInfo': (context) => GeneralInformation(),

  },
));

