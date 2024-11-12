import 'package:hive/hive.dart';

class Boxes{
  static Box getUserData()=>Hive.box("userInfo");
  static Box getDmPathBox()=>Hive.box("dmPath");
  static Box getFavBox()=>Hive.box("offer");
  // static Box getDmPath()=>Hive.box("DMPath");

// static Box getAllData()=>Hive.box("allData");
}