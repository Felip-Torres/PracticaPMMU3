import 'dart:convert';

import 'package:movies_app/Models/Personaje.dart';


class Resultados {
  Info info;
  List<Personaje> results;

  Resultados({
    required this.info,
    required this.results,
  });

  factory Resultados.fromJson(String str) => Resultados.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Resultados.fromMap(Map<String, dynamic> json) => Resultados(
        info: Info.fromMap(json["info"]),
        results:
            List<Personaje>.from(json["results"].map((x) => Personaje.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "info": info.toMap(),
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
      };
}

class Info {
  int count;
  int pages;
  String next;
  dynamic prev;

  Info({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  factory Info.fromJson(String str) => Info.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Info.fromMap(Map<String, dynamic> json) => Info(
        count: json["count"],
        pages: json["pages"],
        next: json["next"],
        prev: json["prev"],
      );

  Map<String, dynamic> toMap() => {
        "count": count,
        "pages": pages,
        "next": next,
        "prev": prev,
      };
}
