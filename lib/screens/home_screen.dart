import 'package:flutter/material.dart';
import 'package:movies_app/Models/Personaje.dart';
import 'package:movies_app/providers/provider.dart';
import 'package:movies_app/widgets/widgets.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final serieProvider = Provider.of<SerieProvider>(context);


    return Scaffold(
      appBar: AppBar(
        title: const Text('Personajes'),
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              // Usar FutureBuilder para manejar los datos asíncronos
              FutureBuilder<List<Personaje>>(
                future: serieProvider.getPersonajes('https://rickandmortyapi.com/api/character'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No hay personajes disponibles.'));
                  } else {
                    final personajes = snapshot.data!;
                    return Column(
                      children: [
                        // Pasar los personajes al CardSwiper
                        CardSwiper(personajes: personajes),

                        // Pasar los personajes al MovieSlider
                        MovieSlider(personajes: personajes),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
