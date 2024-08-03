import 'package:hive/hive.dart';

class Boxes{
  static Box getUserData()=>Hive.box("userInfo");
  // static Box getAllData()=>Hive.box("allData");
}