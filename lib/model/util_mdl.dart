class IdNameMdl {
  int id;
  String name;
  IdNameMdl({
    required this.id,
    required this.name,
  });
  factory IdNameMdl.fromJson(Map<String, dynamic> json) => IdNameMdl(
        id: json["id"] ?? json["key"],
        name: json["name"] ?? json["value"],
      );
  Map<String, dynamic> toJsonName() => {"id": id, "name": name};
  Map<String, dynamic> toJsonValue() => {"id": id, "value": name};
}

class IdNameVisibleMdl {
  int id;
  String name;
  bool isVisible;
  IdNameVisibleMdl({
    required this.id,
    required this.name,
    required this.isVisible,
  });
  factory IdNameVisibleMdl.fromJson(Map<String, dynamic> json) =>
      IdNameVisibleMdl(
          id: json["id"] ?? json["key"],
          name: json["name"] ?? json["value"],
          isVisible: false);
  Map<String, dynamic> toJsonName() => {"id": id, "name": name};
  Map<String, dynamic> toJsonValue() => {"id": id, "value": name};
}
