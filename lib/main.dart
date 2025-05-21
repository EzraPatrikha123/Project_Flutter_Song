import 'package:flutter/material.dart';
import 'package:project_flutter/views/create_song.dart';
import 'package:project_flutter/views/home_page.dart';
import 'package:project_flutter/views/login_page.dart';
import 'dart:io';


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
    ..badCertificateCallback = (X509Certificate cert, String host, int port) => true; 
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/' :   (_) => LoginPage(),
      '/home' : (_) => HomePage(),
      '/add' : (_) => AddSongPage()
    },
  ));
}
