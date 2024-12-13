import 'package:flutter/material.dart';
import 'package:movies_app/Models/Personaje.dart';
import 'package:movies_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final personaje = ModalRoute.of(context)?.settings.arguments as Personaje;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomAppBar(personaje: personaje),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                PosterAndTitle(personaje: personaje),
                SizedBox(height: 20),
                LocationDropdown(title: "Localización Original: ${personaje.origin?.name}", locationUrl: personaje.origin!.url),
                LocationDropdown(title: "Localización actual: ${personaje.location?.name}", locationUrl: personaje.location!.url),
              ],
            ),
          ),
        ],
      ),
    );
  }
}









