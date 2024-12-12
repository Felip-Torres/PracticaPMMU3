import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:movies_app/Models/Personaje.dart';
import 'package:movies_app/Models/resultados.dart';

class SerieProvider extends ChangeNotifier{

  final String _baseUrl = "rickandmortyapi.com";
  final String _language = "es-Es";
  final String _page = "1";

  List<Personaje> personajes = [];

  SerieProvider(){
      getPersonajes();
  }

  getPersonajes() async{
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url =
        Uri.https(_baseUrl, '/api/character', {
          'language': _language,
          'page' : _page
        });

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);
    final resultados = Resultados.fromJson(result.body);
    personajes = resultados.results;
    notifyListeners();
  }
}