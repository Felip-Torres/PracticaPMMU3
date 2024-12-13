import 'package:flutter/material.dart';
import 'package:movies_app/Models/Localizacion.dart';
import 'package:movies_app/Models/Personaje.dart';
import 'package:movies_app/providers/provider.dart';
import 'package:movies_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

//Dropdown co la informacion del lugar
class LocationDropdown extends StatelessWidget {
  final String title;
  final String locationUrl;

  const LocationDropdown({required this.title, required this.locationUrl});

  @override
  Widget build(BuildContext context) {
    final serieProvider = Provider.of<SerieProvider>(context, listen: false);

    return ExpansionTile(
      title: Text(title),
      backgroundColor: const Color(0xFF499000),
      collapsedBackgroundColor: const Color(0xFF8dd122),
      children: [
        FutureBuilder<Localizacion>(
          future: serieProvider.getLocalizacion(locationUrl),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }else if (title.contains("unknown")){
              return Text(
                'Localizacion desconocida',
                style: Theme.of(context).textTheme.bodyLarge,
              );
            } else if (snapshot.hasError) {
              return Text(
                'Error al cargar la localización: ${snapshot.error}',
                style: Theme.of(context).textTheme.bodyLarge,
              );
            } else if (snapshot.hasData) {
              final localizacion = snapshot.data!;
              
              // Aquí usamos el método getCharactersUrl() para obtener la URL de los personajes
              String charactersUrl = localizacion.getCharactersURL();
              print(charactersUrl);

              // Ahora hacemos una nueva llamada a la API para obtener los personajes
              return FutureBuilder<List<Personaje>>(
                future: serieProvider.getPersonajes(charactersUrl),
                builder: (context, personajesSnapshot) {
                  if (personajesSnapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (personajesSnapshot.hasError) {
                    print('Error al cargar los personajes: ${personajesSnapshot.error}');
                    return Text(
                      'Error al cargar los personajes: ${personajesSnapshot.error}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    );
                  } else if (personajesSnapshot.hasData) {
                    final personajes = personajesSnapshot.data!;
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              'Nombre: ${localizacion.name}\nTipo: ${localizacion.type}\nDimensión: ${localizacion.dimension}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            CharacterSlider(personajes: personajes),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Text('No hay personajes disponibles.');
                  }
                },
              );
            } else {
              return const Text('No hay datos de localización disponibles.');
            }
          },
        ),
      ],
    );
  }
}