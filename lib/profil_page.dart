import 'package:flutter/material.dart';

import 'main.dart';
import 'navigation.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  bool conducteur = false;

  void message(String texte) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('$texte : à venir')));
  }

  Widget option(IconData icone, String titre, VoidCallback action) {
    return ListTile(
      leading: Icon(icone, color: jaunePrincipal),
      title: Text(titre),
      trailing: const Icon(Icons.chevron_right, color: texteGris),
      onTap: action,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondNoir,
      bottomNavigationBar: const BarreNavigation(selection: 4),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const SizedBox(height: 20),
            const Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: jaunePrincipal,
                child: Text(
                  'M',
                  style: TextStyle(fontSize: 35, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Center(
              child: Text(
                'Mohammed',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            const Center(
              child: Text(
                'exemple@fiftyfifty.ma',
                style: TextStyle(color: texteGris),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Chip(label: Text(conducteur ? 'Conducteur' : 'Passager')),
            ),
            const SizedBox(height: 22),
            carteSombre(
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        '12',
                        style: TextStyle(color: jaunePrincipal, fontSize: 22),
                      ),
                      Text('Trajets'),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '4,9',
                        style: TextStyle(color: jaunePrincipal, fontSize: 22),
                      ),
                      Text('Note'),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '320 DH',
                        style: TextStyle(color: jaunePrincipal, fontSize: 22),
                      ),
                      Text('Économisés'),
                    ],
                  ),
                ],
              ),
            ),
            carteSombre(
              Column(
                children: [
                  option(
                    Icons.person_outline,
                    'Mes informations',
                    () => message('Mes informations'),
                  ),
                  const Divider(),
                  option(
                    Icons.directions_car_outlined,
                    conducteur
                        ? 'Passer en mode passager'
                        : 'Passer en mode conducteur',
                    () {
                      setState(() => conducteur = !conducteur);
                    },
                  ),
                  const Divider(),
                  option(
                    Icons.notifications_outlined,
                    'Notifications',
                    () => message('Notifications'),
                  ),
                  const Divider(),
                  option(
                    Icons.language,
                    'Langue · Français',
                    () => message('Langue'),
                  ),
                  const Divider(),
                  option(
                    Icons.help_outline,
                    'Aide et assistance',
                    () => message('Aide'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const PageBienvenue()),
                  (route) => false,
                );
              },
              icon: const Icon(Icons.logout, color: Colors.redAccent),
              label: const Text(
                'Se déconnecter',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
