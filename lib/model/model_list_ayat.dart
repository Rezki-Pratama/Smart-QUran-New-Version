// To parse this JSON data, do
//
//     final modelListAyat = modelListAyatFromJson(jsonString);

import 'dart:convert';

List<ModelListAyat> modelListAyatFromJson(String str) =>
    List<ModelListAyat>.from(
        json.decode(str).map((x) => ModelListAyat.fromJson(x)));

String modelListAyatToJson(List<ModelListAyat> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelListAyat {
  ModelListAyat({
    this.nomor,
    this.nama,
    this.asma,
    this.name,
    this.start,
    this.ayat,
    this.type,
    this.urut,
    this.rukuk,
    this.arti,
    this.keterangan,
  });

  String nomor;
  String nama;
  String asma;
  String name;
  String start;
  String ayat;
  String type;
  String urut;
  String rukuk;
  String arti;
  String keterangan;

  factory ModelListAyat.fromJson(Map<String, dynamic> json) => ModelListAyat(
        nomor: json["nomor"],
        nama: json["nama"],
        asma: json["asma"],
        name: json["name"],
        start: json["start"],
        ayat: json["ayat"],
        type: json["type"],
        urut: json["urut"],
        rukuk: json["rukuk"],
        arti: json["arti"],
        keterangan: json["keterangan"],
      );

  Map<String, dynamic> toJson() => {
        "nomor": nomor,
        "nama": nama,
        "asma": asma,
        "name": name,
        "start": start,
        "ayat": ayat,
        "type": type,
        "urut": urut,
        "rukuk": rukuk,
        "arti": arti,
        "keterangan": keterangan,
      };
}
