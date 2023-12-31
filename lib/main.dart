import 'package:firewatch/Pages/general_information_page.dart';
import 'package:firewatch/Pages/interactive_map_page.dart';
import 'package:firewatch/Pages/login_screen_page.dart';
import 'package:firewatch/Pages/wildfire_information_page.dart';
import 'package:firewatch/Pages/report_wildfire_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,

  theme: ThemeData(
      primaryColor: const Color(0xFF851229),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF851229),
      )
  ),

  initialRoute: '/InterMap',
  routes: {
    '/': (context) => LoginScreen(),
    '/WildfireInfo': (context) => WildfireInformation(),
    '/InterMap': (context) => InteractiveMap(),
    '/GeneralInfo': (context) => GeneralInformation(),
    '/WildfireRep' : (context) => WildfireReport(),

  },
));

