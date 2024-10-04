import 'package:flutter/material.dart';

import 'widgets/custom_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CustomContainer(
          text: 'Bulbasaur #001',
          img:
              'https://assets.pokemon.com/assets/cms2/img/pokedex/full//001.png',
        ),
      ),
    );
  }
}
