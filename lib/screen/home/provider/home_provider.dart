import 'package:flutter/material.dart';
import 'package:wather/screen/home/model/home_model.dart';
import 'package:wather/utils/helper.dart';
import 'package:wather/utils/shared_helper.dart';


class HomeProvider with ChangeNotifier
{
  List<String> l3=[];
  ThemeMode mode=ThemeMode.light;
  bool onTheme=false;
  bool theme=true;
  bool isOn=true;
  IconData themeMode=Icons.dark_mode;


  List l1=[
    "14:00",
    "15:00",
    "16:00",
    "17:00",
    "18:00",
    "19:00",
  ];


  List l2=[
    "32`",
    "33",
    "34`",
    "35`",
    "36`",
    "37`",
  ];

  List Imagelist=[
    Image.asset("assets/image/12.png"),
  ];




  HomeModel? homeModel;
  APIHelper helper =APIHelper();
  SharedHelper  shr= SharedHelper();
  Future<HomeModel?>? model;



  Future<void> weathergetData(String? city)
  async {
    APIHelper helper=APIHelper();
    model=helper.PostAPIcall(city!);

    model!.then((value) {
      if(value!=null){
        notifyListeners();
      }
    },);
  }


  void setTheme()async
  {
    theme=!theme;
    shr.saveTheme(isTheme: theme);
    onTheme=(await shr.applyTheme())!;
    if(onTheme==true)
    {
      mode=ThemeMode.dark;
      themeMode=Icons.light;
    }
    else if(themeMode==false)
    {
      mode=ThemeMode.light;
      themeMode=Icons.dark_mode;
    }
    else
    {
      mode=ThemeMode.light;
      themeMode=Icons.dark_mode;
    }
    notifyListeners();
  }

  void getTheme()async
  {
    if(await shr.applyTheme()==null){

      onTheme=false;

    }
    else
    {
      onTheme=(await shr.applyTheme())!;
    }
    if(onTheme==true)
    {
      mode=ThemeMode.dark;
      themeMode=Icons.light_mode;
    }
    else if(onTheme==false)
    {
      mode=ThemeMode.light;
      themeMode=Icons.dark_mode;
    }
    else
    {
      mode=ThemeMode.light;
      themeMode=Icons.dark_mode;
    }
    notifyListeners();
  }


  void getData() async {
    if (await shr.applyData() == null) {
      l3 = [];
    } else {
      l3 = (await shr.applyData())!;
    }
    notifyListeners();
  }

  void setData(String city) {
    getData();
    l3.add(city);
    shr.saveData(bookMark1: l3);
    getData();
    notifyListeners();
  }

  void deleteContact(int i) {
    getData();
    l3.removeAt(i);
    shr.saveData(bookMark1: l3);
    getData();
    notifyListeners();
  }


}