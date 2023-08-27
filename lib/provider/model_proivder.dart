import 'package:chatgptclone/models/models_model.dart';
import 'package:chatgptclone/services/apiservices.dart';
import 'package:flutter/material.dart';

class modelprovider with ChangeNotifier {
  String currentModel = "gpt-3.5-turbo";
  String get getcurrentModel {
    return currentModel;
  }

  void setcurrentModel(String newModel) {
    currentModel = newModel;
    notifyListeners();
  }

  List<models> modelslist = [];
  List<models> get getmodelslist {
    return modelslist;
  }

  Future<List<models>> getallmodels() async {
    modelslist = await ApiService.getmodels();
    return modelslist;
  }
}
