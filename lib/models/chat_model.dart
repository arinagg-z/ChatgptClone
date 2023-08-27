class chatmodel {
  final String msg;
  final int index;

  chatmodel({required this.msg, required this.index});

   factory chatmodel.fromjson(Map<String, dynamic> json) {
    return chatmodel(
      msg: json["message"]["content"],
      index: json["index"],
    );
  }

}
