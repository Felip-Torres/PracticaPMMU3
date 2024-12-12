import 'dart:convert';

class Localizacion {
    int id;
    String name;
    String type;
    String dimension;
    List<String> residents;
    String url;
    DateTime created;

    Localizacion({
        required this.id,
        required this.name,
        required this.type,
        required this.dimension,
        required this.residents,
        required this.url,
        required this.created,
    });

    factory Localizacion.fromJson(String str) => Localizacion.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Localizacion.fromMap(Map<String, dynamic> json) => Localizacion(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        dimension: json["dimension"],
        residents: List<String>.from(json["residents"].map((x) => x)),
        url: json["url"],
        created: DateTime.parse(json["created"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "type": type,
        "dimension": dimension,
        "residents": List<dynamic>.from(residents.map((x) => x)),
        "url": url,
        "created": created.toIso8601String(),
    };
}
