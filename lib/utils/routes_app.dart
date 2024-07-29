import 'package:flutter/cupertino.dart';
import 'package:wather/screen/home/model/home_model.dart';
import 'package:wather/screen/home/view/home_screen.dart';
import 'package:wather/screen/splash/view/splash_screen.dart';

Map<String,WidgetBuilder>routes_app={
  '/':(context)=>SplashScreen(),
  'home':(context)=>HomeScreen(),
};