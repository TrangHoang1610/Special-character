import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:special_character/constaints/constaints.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

Future<List<String>> getName(text, canhtrai, canhphai) async {
  List<String> listName = [];

  var response = await http.post(
    URL,
    body: {
      'text': text,
      'canhtrai': canhtrai,
      'canhphai': canhphai,
    },
  );
  String body = response.body;
  // print(bytes);
  var document = parse(response.body);
  var priceElement = document.getElementsByClassName("form-control");
  priceElement.forEach((element) {
    listName.add(element.attributes['value']);
  });

  return listName;
}
