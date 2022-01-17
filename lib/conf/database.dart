import 'package:hive/hive.dart';

class YaviDatabase {
  var box;
  String nameBox = "";
  YaviDatabase(name) {
    nameBox = name;
  }

  initDB(name) async {
    box = await Hive.openBox(name);
  }
}
