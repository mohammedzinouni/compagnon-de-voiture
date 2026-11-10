import 'package:flutter/material.dart';

import 'main.dart';
import 'navigation.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final conversations = [
      (
        'Youssef B.',
        'Oujda → Nador · 08:30',
        'Je suis devant la gare, voiture grise.',
        '08:12',
      ),
      ('Salma K.', 'Oujda → Fès', "D'accord, je valide votre demande.", 'Hier'),
      (
        'Amine M.',
        'Oujda → Berkane',
        'Merci pour le trajet, à bientôt !',
        'Lun.',
      ),
    ];

    return Scaffold(
      backgroundColor: fondNoir,
      bottomNavigationBar: const BarreNavigation(selection: 3),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Text(
              'Messages',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const Text('Vos échanges', style: TextStyle(color: texteGris)),
            const SizedBox(height: 25),
            ...conversations.map((conversation) {
              return InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Conversation à connecter au backend'),
                    ),
                  );
                },
                child: carteSombre(
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: jaunePrincipal,
                        child: Text(
                          conversation.$1.substring(0, 1),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              conversation.$1,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              conversation.$2,
                              style: const TextStyle(
                                color: jaunePrincipal,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              conversation.$3,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: texteGris,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        conversation.$4,
                        style: const TextStyle(color: texteGris, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
