import 'package:flutter/material.dart';

import 'main.dart';
import 'navigation.dart';
import 'confirmation_page.dart';

class DetailTrajetPage extends StatelessWidget {
  final String depart;
  final String arrivee;
  final String chauffeur;
  final String heure;
  final int prix;

  const DetailTrajetPage({
    super.key,
    required this.depart,
    required this.arrivee,
    required this.chauffeur,
    required this.heure,
    required this.prix,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondNoir,
      appBar: AppBar(
        backgroundColor: fondNoir,
        title: const Text('Détail du trajet'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          carteSombre(
            const Column(
              children: [
                Icon(
                  Icons.directions_car_outlined,
                  color: jaunePrincipal,
                  size: 90,
                ),
                Text('1 h 20 en voiture', style: TextStyle(color: texteGris)),
              ],
            ),
          ),
          carteSombre(
            Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.radio_button_checked,
                    color: jaunePrincipal,
                  ),
                  title: Text(depart),
                  subtitle: const Text('Gare routière'),
                  trailing: Text(heure),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(
                    Icons.location_on_outlined,
                    color: jaunePrincipal,
                  ),
                  title: Text(arrivee),
                  subtitle: const Text('Centre-ville'),
                ),
              ],
            ),
          ),
          carteSombre(
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: jaunePrincipal,
                child: Icon(Icons.person, color: Colors.black),
              ),
              title: Text(chauffeur),
              subtitle: const Text('4,9 ★ · Dacia Logan grise'),
            ),
          ),
          carteSombre(
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('3 places'),
                Text('Petit bagage'),
                Text('Espèces'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Frais de gasoil partagés à parts égales.',
            textAlign: TextAlign.center,
            style: TextStyle(color: texteGris),
          ),
          const SizedBox(height: 30),
          Text(
            'Prix par place : $prix DH',
            style: const TextStyle(
              color: jaunePrincipal,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 15),
          boutonOr('Réserver', () {
            afficherPage(
              context,
              ConfirmationPage(
                depart: depart,
                arrivee: arrivee,
                chauffeur: chauffeur,
                prix: prix,
                heure: heure,
              ),
            );
          }),
        ],
      ),
    );
  }
}
