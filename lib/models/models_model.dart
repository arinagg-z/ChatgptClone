class models {
  final String id;
  final int created;
  final String root;

  models({required this.id, required this.created, required this.root});

  factory models.fromjson(Map<String, dynamic> json) {
    return models(id: json["id"], created: json["created"], root: json["root"]);
  }

  static List<models> modelsfromsnapshot(List modelsnapshot) {
    return modelsnapshot.map((e) => models.fromjson(e)).toList();
  }
}
