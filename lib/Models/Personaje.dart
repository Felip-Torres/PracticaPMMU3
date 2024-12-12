import 'dart:convert';

class Personaje {
  int id;
  String name;
  Status status;
  Species species;
  String ? type; 
  Gender gender;
  Location ? origin;
  Location ? location;
  String image;
  List<String> episode;
  String url;
  DateTime created;

  Personaje({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    this.type,
    required this.gender,
    this.origin,
    this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  factory Personaje.fromJson(String str) => Personaje.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Personaje.fromMap(Map<String, dynamic> json) => Personaje(
        id: json["id"],
        name: json["name"],
        status: statusValues.map[json["status"]] ?? Status.UNKNOWN,
        species: speciesValues.map[json["species"]] ?? Species.UNKNOWN,
        gender: genderValues.map[json["gender"]] ?? Gender.UNKNOWN,
        type: json["type"] ?? "Unknown",
        origin: json["origin"] != null ? Location.fromMap(json["origin"]) : null,
        location: json["location"] != null ? Location.fromMap(json["location"]) : null,
        image: json["image"],
        episode: json["episode"] != null? List<String>.from(json["episode"].map((x) => x)): [],
        url: json["url"],
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "status": statusValues.reverse[status],
        "species": speciesValues.reverse[species],
        "type": type,
        "gender": genderValues.reverse[gender],
        "origin": origin?.toMap(),
        "location": location?.toMap(),
        "image": image,
        "episode": List<dynamic>.from(episode.map((x) => x)),
        "url": url,
        "created": created.toIso8601String(),
      };
}

enum Gender { FEMALE, MALE, UNKNOWN }

final genderValues = EnumValues(
    {"Female": Gender.FEMALE, "Male": Gender.MALE, "unknown": Gender.UNKNOWN});

class Location {
  String name;
  String url;

  Location({
    required this.name,
    required this.url,
  });

  factory Location.fromJson(String str) => Location.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Location.fromMap(Map<String, dynamic> json) => Location(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "url": url,
      };
}

enum Species { ALIEN, HUMAN, UNKNOWN}

final speciesValues =
    EnumValues({"Alien": Species.ALIEN, "Human": Species.HUMAN, "unknown": Species.UNKNOWN});

enum Status { ALIVE, DEAD, UNKNOWN }

final statusValues = EnumValues(
    {"Alive": Status.ALIVE, "Dead": Status.DEAD, "unknown": Status.UNKNOWN});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
