class RadioList {
  int id;
  int order;
  String name;
  String tagline;
  String color;
  String desc;
  String url;
  String image;
  String lang;
  String category;

  RadioList(this.id, this.order, this.name, this.tagline, this.color, this.desc,
      this.url, this.image, this.lang, this.category);

/*
  RadioList.fromjson(Map<String, dynamic> map) {
    id = map["id"];
    order = map['order'];
    name = map['name'];
    tagline = map['tagline'];
    color = map['color'];
    desc = map['desc'];
    url = map['url'];
    image = map['image'];
    lang = map['lang'];
    category = map['category'];
  }
*/
}
