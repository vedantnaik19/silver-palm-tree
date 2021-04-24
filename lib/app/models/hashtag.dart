// To parse this JSON data, do
//
//     final hashtag = hashtagFromJson(jsonString);

import 'dart:convert';

Hashtag hashtagFromJson(String str) => Hashtag.fromJson(json.decode(str));

String hashtagToJson(Hashtag data) => json.encode(data.toJson());

class Hashtag {
  Hashtag({
    this.id,
    this.name,
  });

  int id;
  String name;

  Hashtag copyWith({
    int id,
    String name,
    bool isMandatory,
  }) =>
      Hashtag(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Hashtag.fromJson(Map<String, dynamic> json) => Hashtag(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}
