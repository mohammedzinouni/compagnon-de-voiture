import 'connexion_page.dart';

import 'dart:math' as math;

import 'package:flutter/material.dart';

// ==================================
// 1. COULEURS DE L'APPLICATION
// ==================================

const Color fondNoir = Color(0xFF000000);
const Color carteNoire = Color(0xFF141419);
const Color jaunePrincipal = Color(0xFFD9B451);
const Color texteBlanc = Color(0xFFFFFFFF);
const Color texteGris = Color(0xFFAAA7B0);

// ==================================
// 2. DEMARRAGE DE L'APPLICATION
// ==================================

void main() {
  runApp(const MonApplication());
}

class MonApplication extends StatelessWidget {
  const MonApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FiftyFifty',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: fondNoir,
      ),
      home: const PageBienvenue(),
    );
  }
}

// ==================================
// 3. PAGE BIENVENUE
// ==================================

class PageBienvenue extends StatelessWidget {
  const PageBienvenue({super.key});

  // Ouvre la page Connexion sans fermer la page Bienvenue.
  void ouvrirConnexion(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ConnexionPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondNoir,

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: SizedBox(
                height: math.max(720.0, constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 18,
                  ),

                  child: Column(
                    children: [
                      const Spacer(),

                      // =========================
                      // 4. TITRE BIENVENUE
                      // =========================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 34,
                            height: 1.5,
                            color: jaunePrincipal,
                          ),

                          const SizedBox(width: 12),

                          const Flexible(
                            child: Text(
                              'Bienvenue',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: jaunePrincipal,
                                fontSize: 38,
                                fontFamily: 'serif',
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          Container(
                            width: 34,
                            height: 1.5,
                            color: jaunePrincipal,
                          ),
                        ],
                      ),

                      const Spacer(flex: 3),

                      // =========================
                      // 5. LOGO VOITURE
                      // =========================
                      Container(
                        width: 112,
                        height: 112,

                        decoration: BoxDecoration(
                          color: carteNoire,

                          borderRadius: BorderRadius.circular(30),

                          border: Border.all(
                            color: jaunePrincipal.withAlpha(85),
                            width: 1,
                          ),
                        ),

                        child: const Icon(
                          Icons.directions_car_filled_rounded,
                          color: jaunePrincipal,
                          size: 62,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // =========================
                      // 6. NOM FIFTYFIFTY
                      // =========================
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Fifty',
                              style: TextStyle(
                                color: texteBlanc,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            TextSpan(
                              text: 'Fifty',
                              style: TextStyle(
                                color: jaunePrincipal,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 20),

                      // =========================
                      // 7. SLOGAN
                      // =========================
                      const Text(
                        'Partagez vos trajets et divisez les\nfrais de Gasoil.',
                        textAlign: TextAlign.center,

                        style: TextStyle(
                          color: texteGris,
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),

                      const Spacer(flex: 4),

                      // =========================
                      // 8. LES TROIS AVANTAGES
                      // =========================
                      const Row(
                        children: [
                          Expanded(
                            child: Avantage(
                              icone: Icons.savings_outlined,
                              titre: 'Économie',
                            ),
                          ),

                          Expanded(
                            child: Avantage(
                              icone: Icons.verified_user_outlined,
                              titre: 'Confiance',
                            ),
                          ),

                          Expanded(
                            child: Avantage(
                              icone: Icons.speed_rounded,
                              titre: 'Rapidité',
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 28),

                      // =========================
                      // 9. BOUTON COMMENCER
                      // =========================
                      SizedBox(
                        width: double.infinity,
                        height: 58,

                        child: ElevatedButton(
                          onPressed: () {
                            ouvrirConnexion(context);
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: jaunePrincipal,
                            foregroundColor: Colors.black,
                            elevation: 0,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),

                          child: const Text(
                            'Commencer',

                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const Spacer(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ==================================
// 11. WIDGET POUR LES AVANTAGES
// ==================================

class Avantage extends StatelessWidget {
  final IconData icone;
  final String titre;

  const Avantage({super.key, required this.icone, required this.titre});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icone, color: jaunePrincipal, size: 32),

        const SizedBox(height: 10),

        Text(
          titre,
          textAlign: TextAlign.center,

          style: const TextStyle(
            color: texteBlanc,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
