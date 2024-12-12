import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:movies_app/Models/Personaje.dart';

class SerieProvider extends ChangeNotifier{

  final String _baseUrl = "rickandmortyapi.com";
  final String _language = "es-Es";
  final String _page = "1";

  List<Personaje> personajes = [];

  SerieProvider(){
      getPersonajes();
  }

  Future<List<Personaje>> getPersonajes() async {
    final url = Uri.https(_baseUrl, '/api/character', {
      'language' : _language
      });
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      final List<dynamic> results = jsonResponse['results'];

      return results.map((item) => Personaje.fromMap(item)).toList();
    } else {
      throw Exception('Error al cargar personajes: ${response.statusCode}');
    }
  }
}