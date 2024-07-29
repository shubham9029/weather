import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wather/screen/home/provider/home_provider.dart';
import 'package:wather/utils/routes_app.dart';

void main()
{
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider.value(value: HomeProvider())
    ],
    child: Consumer<HomeProvider>(
      builder: (context, value, child) {
        value.getTheme();
        value.theme=value.onTheme;
        value.isOn=value.theme;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: routes_app,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),

        );
      },

    ),

  )
  );
}