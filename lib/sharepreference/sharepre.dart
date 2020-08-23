import 'package:shared_preferences/shared_preferences.dart';

class PreUtil{
  static String lockkey = 'lockkey';
  static const langauge = "langauge";


  static Future<bool> setData(String key,String data) async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return  preferences.setString(key, data);
  }

  static Future<String> getData(String key) async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return preferences.getString(key);
  }


}

