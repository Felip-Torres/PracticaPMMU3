import 'package:flutter/material.dart';
import 'package:movies_app/Models/Personaje.dart';

//AppBar personalizada para los personajes
class CustomAppBar extends StatelessWidget {
  final Personaje personaje;

  const CustomAppBar({required this.personaje});

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