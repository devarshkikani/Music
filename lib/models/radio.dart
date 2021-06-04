import 'dart:convert';

import 'package:flutter/foundation.dart';

class MyRadioList {
  final List<MyRadio> radios;

  MyRadioList({required this.radios});

  MyRadioList copyWith(List<MyRadio> radios) {
    return MyRadioList(
      radios: radios != this.radios ? this.radios : radios,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'radios': radios.map((x) => x.toMap()).toList(),
    };
  }

  factory MyRadioList.fromMap(Map<String, dynamic> map) {
    return MyRadioList(
      radios: List<MyRadio>.from(map['radios']?.map((x) => MyRadio.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory MyRadioList.fromJson(String source) =>
      MyRadioList.fromMap(json.decode(source));

  String tostirng() => 'MyRadioList($radios)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is MyRadioList && listEquals(o.radios, radios);
  }

  @override
  int get hashCode => radios.hashCode;
}

class MyRadio {
  final int id;
  final int order;
  final String name;
  final String tagline;
  final String fColor;
  final String sColor;
  final String desc;
  final String icon;
  final String url;
  final String image;
  final String lang;
  final String category;
  final String artist;
  bool like;

  MyRadio(
    this.id,
    this.order,
    this.name,
    this.tagline,
    this.fColor,
    this.sColor,
    this.desc,
    this.icon,
    this.url,
    this.image,
    this.lang,
    this.category,
    this.artist,
    this.like,
  );

  MyRadio copyWith(
    int id,
    int order,
    String name,
    String tagline,
    String fColor,
    String sColor,
    String desc,
    String icon,
    String url,
    String image,
    String lang,
    String category,
    String artist,
    bool like,
  ) {
    return MyRadio(
      id != this.id ? this.id : id,
      order != this.order ? this.order : order,
      name != this.name ? this.name : name,
      tagline != this.tagline ? this.tagline : tagline,
      fColor != this.fColor ? this.fColor : fColor,
      sColor != this.sColor ? this.sColor : sColor,
      desc != this.desc ? this.desc : desc,
      icon != this.icon ? this.icon : icon,
      url != this.url ? this.url : url,
      image != this.image ? this.image : image,
      lang != this.lang ? this.lang : lang,
      category != this.category ? this.category : category,
      artist != this.artist ? this.artist : artist,
      like != this.like ? this.like : like,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "order": order,
      "name": name,
      "tagline": tagline,
      "fColor": fColor,
      "sColor": sColor,
      "desc": desc,
      "icon": icon,
      "url": url,
      "image": image,
      "lang": lang,
      "category": category,
      "artist": artist,
      "like": like,
    };
  }

  factory MyRadio.fromMap(Map<String, dynamic> map) {
    return MyRadio(
      map["id"],
      map['order'],
      map['name'],
      map['tagline'],
      map['fColor'],
      map['sColor'],
      map['desc'],
      map['icon'],
      map['url'],
      map['image'],
      map['lang'],
      map['category'],
      map['artist'],
      map['like'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MyRadio.fromJson(String source) =>
      MyRadio.fromMap(json.decode(source));

  @override
  String toString() {
    return "MyRadio($id, $order, $name, $tagline, $fColor , $sColor, $desc, $icon, $url, $image, $lang, $category, $artist, $like)";
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is MyRadio &&
        o.id == id &&
        o.order == order &&
        o.name == name &&
        o.tagline == tagline &&
        o.fColor == fColor &&
        o.sColor == sColor &&
        o.desc == desc &&
        o.icon == icon &&
        o.url == url &&
        o.image == image &&
        o.lang == lang &&
        o.category == category &&
        o.artist == artist &&
        o.like == like;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        order.hashCode ^
        name.hashCode ^
        tagline.hashCode ^
        fColor.hashCode ^
        sColor.hashCode ^
        desc.hashCode ^
        icon.hashCode ^
        url.hashCode ^
        image.hashCode ^
        lang.hashCode ^
        category.hashCode ^
        artist.hashCode ^
        like.hashCode;
  }
}
