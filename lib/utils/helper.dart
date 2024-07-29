import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart 'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wather/screen/home/model/home_model.dart';

class APIHelper
{
  Future<HomeModel?>? PostAPIcall(String city)async
  {
    String? Link="https://api.openweathermap.org/data/2.5/weather?q=$city&appid=c7cbbe4edb4df7d4449f3291ab40735e";

    Response response=await http.get(Uri.parse(Link));

    if(response.statusCode==200)
      {
        var json=jsonDecode(response.body);
        HomeModel model=HomeModel.mapToModel(json);
        return model;

      }
    return null;
  }


}