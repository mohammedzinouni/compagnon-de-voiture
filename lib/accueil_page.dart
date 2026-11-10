import 'package:flutter/material.dart';

import 'main.dart';
import 'navigation.dart';
import 'resultats_page.dart';

class AccueilPage extends StatefulWidget {
  const AccueilPage({super.key});

  @override
  State<AccueilPage> createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  final depart = TextEditingController(text: 'Oujda');
  final arrivee = TextEditingController(text: 'Nador');

  DateTime date = DateTime.now();
  int passagers = 1;

  @override
  void dispose() {
    depart.dispose();
    arrivee.dispose();
    super.dispose();
  }

  void message(String texte) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texte)));
  }

  Future<void> choisirDate() async {
    final maintenant = DateTime.now();
    final minimum = DateTime(maintenant.year, maintenant.month, maintenant.day);

    final resultat = await showDatePicker(
      context: context,
      initialDate: date.isBefore(minimum) ? minimum : date,
      firstDate: minimum,
      lastDate: DateTime(2035),
    );

    if (resultat != null && mounted) {
      setState(() => date = resultat);
    }
  }

  void rechercher() {
    String villeDepart = depart.text.trim();
    String villeArrivee = arrivee.text.trim();

    if (villeDepart.isEmpty || villeArrivee.isEmpty) {
      message('Veuillez remplir les villes');
      return;
    }

    if (villeDepart.toLowerCase() == villeArrivee.toLowerCase()) {
      message('Choisissez deux villes différentes');
      return;
    }

    afficherPage(
      context,
      ResultatsPage(
        depart: villeDepart,
        arrivee: villeArrivee,
        passagers: passagers,
      ),
    );
  }

  Widget champVille(
    String titre,
    TextEditingController controller,
    IconData icone,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: fondNoir,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icone, color: jaunePrincipal),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(color: texteBlanc),
              decoration: InputDecoration(
                labelText: titre,
                labelStyle: const TextStyle(color: texteGris),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget trajetPopulaire(String destination, String info, int prix) {
    return InkWell(
      onTap: () {
        afficherPage(
          context,
          ResultatsPage(depart: 'Oujda', arrivee: destination, passagers: 1),
        );
      },
      child: carteSombre(
        Row(
          children: [
            const Icon(
              Icons.directions_car_outlined,
              color: jaunePrincipal,
              size: 32,
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Oujda → $destination',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    info,
                    style: const TextStyle(color: texteGris, fontSize: 12),
                  ),
                ],
              ),
            ),
            Text(
              '$prix DH',
              style: const TextStyle(
                color: jaunePrincipal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondNoir,
      bottomNavigationBar: const BarreNavigation(selection: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Bonjour, Mohammed',
                style: TextStyle(
                  color: jaunePrincipal,
                  fontFamily: 'serif',
                  fontStyle: FontStyle.italic,
                  fontSize: 23,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Où allez-vous ?',
                style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              carteSombre(
                Column(
                  children: [
                    champVille('Départ', depart, Icons.radio_button_checked),
                    IconButton(
                      onPressed: () {
                        final temp = depart.text;
                        setState(() {
                          depart.text = arrivee.text;
                          arrivee.text = temp;
                        });
                      },
                      icon: const Icon(Icons.swap_vert, color: jaunePrincipal),
                    ),
                    champVille('Arrivée', arrivee, Icons.location_on_outlined),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: choisirDate,
                            icon: const Icon(Icons.calendar_month),
                            label: Text(
                              '${date.day}/${date.month}/${date.year}',
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            initialValue: passagers,
                            decoration: const InputDecoration(
                              labelText: 'Passagers',
                            ),
                            items: [1, 2, 3, 4].map((n) {
                              return DropdownMenuItem(
                                value: n,
                                child: Text('$n'),
                              );
                            }).toList(),
                            onChanged: (n) {
                              setState(() => passagers = n ?? 1);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    boutonOr('Rechercher', rechercher),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Trajets populaires',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                  ),
                  TextButton(
                    onPressed: rechercher,
                    child: const Text(
                      'Voir tout',
                      style: TextStyle(color: jaunePrincipal),
                    ),
                  ),
                ],
              ),
              trajetPopulaire('Nador', "Aujourd'hui · 08:30 · 3 places", 35),
              trajetPopulaire('Fès', 'Demain · 07:00 · 2 places', 120),
              trajetPopulaire('Berkane', "Aujourd'hui · 17:15 · 4 places", 20),
            ],
          ),
        ),
      ),
    );
  }
}
