import 'package:flutter/material.dart';
import 'package:movies_app/Models/Personaje.dart';

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
                _Overview(personaje: personaje),
                // Otros widgets que necesiten datos
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
      backgroundColor: Color(0xFF8dd122),
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

class _Overview extends StatelessWidget {
  final Personaje personaje;

  const _Overview({required this.personaje});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        'Localización Original: ${personaje.origin.name}.\nLocalización actual: ${personaje.location.name}',
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}

