import 'package:flutter/material.dart';

import 'main.dart';
import 'navigation.dart';
import 'messages_page.dart';

class ConfirmationPage extends StatelessWidget {
  final String depart;
  final String arrivee;
  final String chauffeur;
  final String heure;
  final int prix;

  const ConfirmationPage({
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
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(25),
          children: [
            const SizedBox(height: 35),
            const Icon(Icons.check_circle, color: jaunePrincipal, size: 90),
            const SizedBox(height: 20),
            const Text(
              'Réservation confirmée',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Votre réservation est confirmée '
              'dans cette démonstration.',
              textAlign: TextAlign.center,
              style: TextStyle(color: texteGris),
            ),
            const SizedBox(height: 25),
            carteSombre(
              Column(
                children: [
                  Text(
                    '$depart → $arrivee',
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text('Départ : $heure'),
                  const SizedBox(height: 8),
                  const Text('Places : 1'),
                  const Divider(height: 28),
                  Text('Conducteur : $chauffeur'),
                  const SizedBox(height: 16),
                  Text(
                    'À payer au conducteur : $prix DH',
                    style: const TextStyle(
                      color: jaunePrincipal,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            boutonOr(
              'Contacter le conducteur',
              () => afficherPage(context, const MessagesPage()),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => allerAccueil(context),
              child: const Text(
                "Retour à l'accueil",
                style: TextStyle(color: jaunePrincipal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
