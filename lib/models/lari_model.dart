// To parse this JSON data, do
//
//     final berlariModel = berlariModelFromJson(jsonString);

import 'dart:convert';

BerlariModel berlariModelFromJson(String str) =>
    BerlariModel.fromJson(json.decode(str));

String berlariModelToJson(BerlariModel data) => json.encode(data.toJson());

class BerlariModel {
  BerlariModel({
    required this.id,
    required this.mulai,
    required this.selesai,
  });

  int id;
  String mulai;
  String selesai;

  factory BerlariModel.fromJson(Map<String, dynamic> json) => BerlariModel(
      id: json["id"], mulai: json["mulai"], selesai: json["selesai"]);

  Map<String, dynamic> toJson() =>
      {"id": id, "mulai": mulai, "selesai": selesai};
}
