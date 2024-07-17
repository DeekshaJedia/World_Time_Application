import 'package:flutter/material.dart';
import 'package:world_time_application/pages/home.dart';
import 'package:world_time_application/pages/loading.dart';
import 'package:world_time_application/pages/choose_location.dart';

void main() => runApp(MaterialApp(initialRoute: '/', routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/location': (context) => ChooseLocation(),
    }));
