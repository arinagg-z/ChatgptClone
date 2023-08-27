import 'package:chatgptclone/services/apiservices.dart';
import 'package:flutter/material.dart';

import '../models/chat_model.dart';

class ChatProvider with ChangeNotifier {
  List<chatmodel> chatlist = [];
  List<chatmodel> get getchatlist {
    return chatlist;
  }

  void addusermessage({required String msg}) {
    chatlist.add(chatmodel(msg: msg, index: 1));
    notifyListeners();
  }

  Future<void> sendmessageandgetanswer(
      {required String msg, required String modelid}) async {
    print(modelid);
    chatlist.addAll(await ApiService.sendmessages(msg, modelid));
  }
}
