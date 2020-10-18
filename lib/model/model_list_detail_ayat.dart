import 'dart:convert';

List<ModelDetailAyat> modelDetailAyatFromJson(String str) =>
    List<ModelDetailAyat>.from(
        json.decode(str).map((x) => ModelDetailAyat.fromJson(x)));

String modelDetailAyatToJson(List<ModelDetailAyat> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelDetailAyat {
  ModelDetailAyat({
    this.number,
    this.meta,
    this.text,
    this.translation,
    this.audio,
    this.tafsir,
  });

  Number number;
  Meta meta;
  Text text;
  Translation translation;
  Audio audio;
  Tafsir tafsir;
  bool isSelected = false;
  bool buttonPlayer = false;
  bool isTafsir = false;

  factory ModelDetailAyat.fromJson(Map<String, dynamic> json) =>
      ModelDetailAyat(
        number: Number.fromJson(json["number"]),
        meta: Meta.fromJson(json["meta"]),
        text: Text.fromJson(json["text"]),
        translation: Translation.fromJson(json["translation"]),
        audio: Audio.fromJson(json["audio"]),
        tafsir: Tafsir.fromJson(json["tafsir"]),
      );

  Map<String, dynamic> toJson() => {
        "number": number.toJson(),
        "meta": meta.toJson(),
        "text": text.toJson(),
        "translation": translation.toJson(),
        "audio": audio.toJson(),
        "tafsir": tafsir.toJson(),
      };
}

class Audio {
  Audio({
    this.primary,
    this.secondary,
  });

  String primary;
  List<String> secondary;

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        primary: json["primary"],
        secondary: List<String>.from(json["secondary"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "primary": primary,
        "secondary": List<dynamic>.from(secondary.map((x) => x)),
      };
}

class Meta {
  Meta({
    this.juz,
    this.page,
    this.sajda,
    this.manzil,
    this.ruku,
    this.hizbQuarter,
  });

  int juz;
  int page;
  bool sajda;
  int manzil;
  int ruku;
  int hizbQuarter;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        juz: json["juz"],
        page: json["page"],
        sajda: json["sajda"],
        manzil: json["manzil"],
        ruku: json["ruku"],
        hizbQuarter: json["hizbQuarter"],
      );

  Map<String, dynamic> toJson() => {
        "juz": juz,
        "page": page,
        "sajda": sajda,
        "manzil": manzil,
        "ruku": ruku,
        "hizbQuarter": hizbQuarter,
      };
}

class Number {
  Number({
    this.inQuran,
    this.inSurah,
  });

  int inQuran;
  int inSurah;

  factory Number.fromJson(Map<String, dynamic> json) => Number(
        inQuran: json["inQuran"],
        inSurah: json["inSurah"],
      );

  Map<String, dynamic> toJson() => {
        "inQuran": inQuran,
        "inSurah": inSurah,
      };
}

class Tafsir {
  Tafsir({
    this.id,
  });

  Id id;

  factory Tafsir.fromJson(Map<String, dynamic> json) => Tafsir(
        id: Id.fromJson(json["id"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id.toJson(),
      };
}

class Id {
  Id({
    this.short,
    this.long,
  });

  String short;
  String long;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        short: json["short"],
        long: json["long"],
      );

  Map<String, dynamic> toJson() => {
        "short": short,
        "long": long,
      };
}

class Text {
  Text({
    this.arab,
    this.transliteration,
  });

  String arab;
  Transliteration transliteration;

  factory Text.fromJson(Map<String, dynamic> json) => Text(
        arab: json["arab"],
        transliteration: Transliteration.fromJson(json["transliteration"]),
      );

  Map<String, dynamic> toJson() => {
        "arab": arab,
        "transliteration": transliteration.toJson(),
      };
}

class Transliteration {
  Transliteration({
    this.en,
  });

  String en;

  factory Transliteration.fromJson(Map<String, dynamic> json) =>
      Transliteration(
        en: json["en"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
      };
}

class Translation {
  Translation({
    this.en,
    this.id,
  });

  String en;
  String id;

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        en: json["en"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
        "id": id,
      };
}
