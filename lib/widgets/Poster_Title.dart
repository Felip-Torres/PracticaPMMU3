import 'package:flutter/material.dart';
import 'package:movies_app/Models/Personaje.dart';


//Widget que muestra la imagen y los datos del personaje
class PosterAndTitle extends StatelessWidget {
  final Personaje personaje;

  const PosterAndTitle({required this.personaje});

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