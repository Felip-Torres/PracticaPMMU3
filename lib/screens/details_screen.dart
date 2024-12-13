import 'package:flutter/material.dart';
import 'package:movies_app/Models/Localizacion.dart';
import 'package:movies_app/Models/Personaje.dart';
import 'package:movies_app/providers/provider.dart';
import 'package:movies_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final personaje = ModalRoute.of(context)?.settings.arguments as Personaje;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(personaje: personaje),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitle(personaje: personaje),
                SizedBox(height: 20),
                _LocationDropdown(title: "Localización Original: ${personaje.origin?.name}", locationUrl: personaje.origin!.url),
                _LocationDropdown(title: "Localización actual: ${personaje.location?.name}", locationUrl: personaje.location!.url),
              
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _CustomAppBar extends StatelessWidget {
  final Personaje personaje;

  const _CustomAppBar({required this.personaje});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: const Color(0xFF8dd122),
      expandedHeight: 50,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            personaje.name,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Personaje personaje;

  const _PosterAndTitle({required this.personaje});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/loading.gif'),
              image: NetworkImage(personaje.image),
              height: 150,
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                personaje.name,
                style: textTheme.headlineSmall,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                "Estado: ${personaje.status.name}.\nEspecie: ${personaje.species.name}.",
                style: textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _LocationDropdown extends StatelessWidget {
  final String title;
  final String locationUrl;

  const _LocationDropdown({required this.title, required this.locationUrl});

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
            } else if (snapshot.hasError) {
              return Text(
                'Error al cargar la localización: ${snapshot.error}',
                style: Theme.of(context).textTheme.bodyMedium,
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
                      style: Theme.of(context).textTheme.bodyMedium,
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
                            MovieSlider(personajes: personajes),  // Asegúrate de que MovieSlider pueda recibir una lista de personajes
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


