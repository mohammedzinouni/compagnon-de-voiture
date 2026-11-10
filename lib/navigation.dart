import 'package:flutter/material.dart';

import 'main.dart';
import 'accueil_page.dart';
import 'mes_trajets_page.dart';
import 'publier_trajet_page.dart';
import 'messages_page.dart';
import 'profil_page.dart';

void afficherPage(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => page));
}

void allerAccueil(BuildContext context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (_) => const AccueilPage()),
    (route) => false,
  );
}

Widget carteSombre(Widget enfant) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: carteNoire,
      borderRadius: BorderRadius.circular(18),
    ),
    child: enfant,
  );
}

Widget boutonOr(String titre, VoidCallback action) {
  return SizedBox(
    width: double.infinity,
    height: 54,
    child: ElevatedButton(
      onPressed: action,
      style: ElevatedButton.styleFrom(
        backgroundColor: jaunePrincipal,
        foregroundColor: Colors.black,
      ),
      child: Text(
        titre,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      ),
    ),
  );
}

class BarreNavigation extends StatelessWidget {
  final int selection;

  const BarreNavigation({super.key, required this.selection});

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const AccueilPage(),
      const MesTrajetsPage(),
      const PublierTrajetPage(),
      const MessagesPage(),
      const ProfilPage(),
    ];

    final icones = <IconData>[
      Icons.home_outlined,
      Icons.route_outlined,
      Icons.add_circle_outline,
      Icons.chat_bubble_outline,
      Icons.person_outline,
    ];

    final titres = ['Accueil', 'Trajets', 'Publier', 'Messages', 'Profil'];

    return SafeArea(
      child: Container(
        color: carteNoire,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: List.generate(5, (index) {
            bool actif = selection == index;

            return Expanded(
              child: InkWell(
                onTap: () {
                  if (!actif) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => pages[index]),
                    );
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      icones[index],
                      color: actif ? jaunePrincipal : texteGris,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      titres[index],
                      style: TextStyle(
                        fontSize: 10,
                        color: actif ? jaunePrincipal : texteGris,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
