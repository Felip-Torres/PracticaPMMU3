import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movies_app/Models/Personaje.dart';
import 'package:movies_app/providers/provider.dart';
import 'package:provider/provider.dart';

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

    factory Localizacion.fromMap(Map<String, dynamic> json) => Localizacion(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        dimension: json["dimension"],
        residents: List<String>.from(json["residents"].map((x) => x)),
        url: json["url"],
        created: DateTime.parse(json["created"]),
    );

  // Método que devuelve la URL concatenada de los personajes
  String getCharactersURL() {
    // Extraer solo los IDs de las URLs de los residentes
    List<String> residentIds = residents.map((url) => url.split('/').last).toList();

    // Concatenar los IDs en una sola cadena, separada por comas
    String concatenatedIds = residentIds.join(',');

    // Construir la URL completa para obtener los personajes
    return 'https://rickandmortyapi.com/api/character/$concatenatedIds';
  }

}
