// To parse this JSON data, do
//
//     final berlariDetailModel = berlariDetailModelFromJson(jsonString);

import 'dart:convert';

BerlariDetailModel berlariDetailModelFromJson(String str) =>
    BerlariDetailModel.fromJson(json.decode(str));

String berlariDetailModelToJson(BerlariDetailModel data) =>
    json.encode(data.toJson());

class BerlariDetailModel {
  BerlariDetailModel({
    required this.id,
    required this.lariId,
    required this.latitude,
    required this.longitude,
    required this.waktu,
  });

  int id;
  int lariId;
  double latitude;
  double longitude;
  String waktu;

  factory BerlariDetailModel.fromJson(Map<String, dynamic> json) =>
      BerlariDetailModel(
        id: json["id"],
        lariId: json["lari_id"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        waktu: json["waktu"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lari_id": lariId,
        "latitude": latitude,
        "longitude": longitude,
        "waktu": waktu,
      };
}
