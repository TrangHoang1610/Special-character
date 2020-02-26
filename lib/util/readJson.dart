import 'dart:convert';

import 'package:flutter/services.dart';

Future<List<String>> loadAsset(String name) async {
  List<String> list = [];
  String jsonString = await rootBundle.loadString('assets/fixture/$name.json');
  dynamic jsonParser = jsonDecode(jsonString);
  jsonParser.forEach((e) {
    list.add(e);
  });
  return list;
}
