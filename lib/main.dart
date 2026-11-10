import 'package:flutter/material.dart';

import 'connexion_page.dart';

const Color fondNoir = Color(0xFF000000);
const Color carteNoire = Color(0xFF141419);
const Color jaunePrincipal = Color(0xFFD9B451);
const Color texteBlanc = Colors.white;
const Color texteGris = Color(0xFFAAA7B0);

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

class PageBienvenue extends StatelessWidget {
  const PageBienvenue({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondNoir,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: Column(
              children: [
                const SizedBox(height: 65),
                const Text(
                  '— Bienvenue —',
                  style: TextStyle(
                    color: jaunePrincipal,
                    fontFamily: 'serif',
                    fontStyle: FontStyle.italic,
                    fontSize: 36,
                  ),
                ),
                const SizedBox(height: 80),
                Container(
                  height: 112,
                  width: 112,
                  decoration: BoxDecoration(
                    color: carteNoire,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: jaunePrincipal),
                  ),
                  child: const Icon(
                    Icons.directions_car_filled_rounded,
                    size: 62,
                    color: jaunePrincipal,
                  ),
                ),
                const SizedBox(height: 24),
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Fifty',
                        style: TextStyle(color: texteBlanc),
                      ),
                      TextSpan(
                        text: 'Fifty',
                        style: TextStyle(color: jaunePrincipal),
                      ),
                    ],
                  ),
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Partagez vos trajets et divisez les\nfrais de Gasoil.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: texteGris, fontSize: 16),
                ),
                const SizedBox(height: 90),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Avantage(Icons.savings_outlined, 'Économie'),
                    Avantage(Icons.verified_user_outlined, 'Confiance'),
                    Avantage(Icons.speed, 'Rapidité'),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ConnexionPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: jaunePrincipal,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text(
                      'Commencer',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Avantage extends StatelessWidget {
  final IconData icone;
  final String titre;

  const Avantage(this.icone, this.titre, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icone, color: jaunePrincipal, size: 30),
        const SizedBox(height: 8),
        Text(titre, style: const TextStyle(color: texteBlanc)),
      ],
    );
  }
}
