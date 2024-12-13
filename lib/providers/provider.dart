import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:movies_app/Models/Localizacion.dart';
import 'package:movies_app/Models/Personaje.dart';

class SerieProvider extends ChangeNotifier{

  List<Personaje> personajes = [];

  SerieProvider(){
      getPersonajes('https://rickandmortyapi.com/api/character');
  }

  //Devuelve la lista de personajes(Tiene en cuenta diferentes respuestas posibles)
  Future<List<Personaje>> getPersonajes(String charactersUrl) async {
    final response = await http.get(Uri.parse(charactersUrl));

    if (response.statusCode == 200) {
      final dynamic jsonResponse = json.decode(response.body);

      // Verificamos si la respuesta tiene el campo 'results'
      if (jsonResponse is Map<String, dynamic> && jsonResponse.containsKey('results')) {
        final List<dynamic> personajesJson = jsonResponse['results'];
        return personajesJson.map((json) => Personaje.fromMap(json)).toList();
      }
      // Si la respuesta es una lista directa de personajes
      else if (jsonResponse is List) {
        return jsonResponse.map((json) => Personaje.fromMap(json)).toList();
      }
      // Si la respuesta es un solo personaje
      else if (jsonResponse is Map<String, dynamic>) {
        Personaje personaje = Personaje.fromMap(jsonResponse);
        return [personaje];
      } else {
        throw Exception('Formato de respuesta inesperado');
      }
    } else {
      throw Exception('Error al cargar los personajes');
    }
  }

  //Devuelve la localizacion
  Future<Localizacion> getLocalizacion(String url) async {
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return Localizacion.fromMap(jsonResponse);
    } else {
      throw Exception('Error al cargar localización: ${response.statusCode}');
    }
  }
}