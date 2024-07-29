import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper
{
  void saveData({required List<String> bookMark1}) async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    shr.setStringList("city", bookMark1);
  }

  Future<List<String>?> applyData() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    return shr.getStringList("city");
  }

  void saveTheme({required bool isTheme})
  async{
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    sharedPreferences.setBool("theme", isTheme);
  }

  Future<bool?> applyTheme() async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool("theme");
  }
}