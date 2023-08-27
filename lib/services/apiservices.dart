import 'dart:convert';
import 'dart:io';

import 'package:chatgptclone/constants/api_consts.dart';
import 'package:chatgptclone/models/chat_model.dart';
import 'package:chatgptclone/models/models_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<models>> getmodels() async {
    try {
      var responsebody = await http.get(
          Uri.parse(
            "$BASE_URL/models",
          ),
          headers: {"Authorization": "Bearer $API_KEY"});
      Map json = jsonDecode(responsebody.body!);

      if (json["error"] != null) {
        throw HttpException(json["error"]["message"]);
      }

      List temp = [];
      for (var value in json["data"]) {
        temp.add(value);
      }
      print(temp);

      return models.modelsfromsnapshot(temp);
    } catch (e) {
      print("error:$e");
      rethrow;
    }
  }

  static Future<List<chatmodel>> sendmessages(
      String msg, String modelid) async {
    try {
      var responsebody = await http.post(
          Uri.parse(
            "$BASE_URL/completions",
          ),
          body: jsonEncode({
            "model": modelid,
            "messages": [
              {"role": "user", "content": msg}
            ],
            "temperature": 0.7
          }),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $API_KEY"
          });
      dynamic json = jsonDecode(responsebody.body);

      if (json["error"] != null) {
        throw HttpException(json["error"]);
      }
      List<chatmodel> chatlist = [];
      if (json["choices"].length > 0) {
        chatlist = List.generate(
            json["choices"].lenght,
            (index) => chatmodel(
                msg: json["choices"]["message"]["content"],
                index: json["choices"]["index"]));
      }
      return chatlist;
    } catch (e) {
      rethrow;
    }
  }
}
