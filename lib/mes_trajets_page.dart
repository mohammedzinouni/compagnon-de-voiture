import 'package:flutter/material.dart';

import 'main.dart';
import 'navigation.dart';

// =====================================
// PAGE 10 : MES TRAJETS
// =====================================

class MesTrajetsPage extends StatefulWidget {
  const MesTrajetsPage({super.key});

  @override
  State<MesTrajetsPage> createState() => _MesTrajetsPageState();
}

class _MesTrajetsPageState extends State<MesTrajetsPage> {
  bool aVenir = true;

  // CARTE D'UN TRAJET
  Widget carteTrajet(
    String statut,
    String trajet,
    String date,
    String heure,
    String info,
    String prix,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 13),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: carteNoire,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: texteGris.withAlpha(35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // STATUT ET PRIX
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                statut,
                style: const TextStyle(
                  color: jaunePrincipal,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                prix,
                style: const TextStyle(
                  color: jaunePrincipal,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // VILLES
          Text(
            trajet,
            style: const TextStyle(
              color: texteBlanc,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          // INFORMATIONS
          Wrap(
            spacing: 15,
            runSpacing: 8,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.calendar_month_outlined,
                    color: jaunePrincipal,
                    size: 17,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    date,
                    style: const TextStyle(color: texteGris, fontSize: 12),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.access_time,
                    color: jaunePrincipal,
                    size: 17,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    heure,
                    style: const TextStyle(color: texteGris, fontSize: 12),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.person_outline,
                    color: jaunePrincipal,
                    size: 17,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    info,
                    style: const TextStyle(color: texteGris, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondNoir,

      bottomNavigationBar: const BarreNavigation(selection: 1),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 25),
          children: [
            const Text(
              'Vos voyages',
              style: TextStyle(
                color: jaunePrincipal,
                fontSize: 22,
                fontFamily: 'serif',
                fontStyle: FontStyle.italic,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Mes trajets',
              style: TextStyle(
                color: texteBlanc,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            // BOUTONS A VENIR / PASSES
            Container(
              height: 50,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: carteNoire,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          aVenir = true;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: aVenir ? jaunePrincipal : Colors.transparent,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          'À venir',
                          style: TextStyle(
                            color: aVenir ? Colors.black : texteGris,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          aVenir = false;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: !aVenir ? jaunePrincipal : Colors.transparent,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          'Passés',
                          style: TextStyle(
                            color: !aVenir ? Colors.black : texteGris,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            if (aVenir) ...[
              carteTrajet(
                'Passager · Confirmé',
                'Oujda → Nador',
                "Aujourd'hui",
                '08:30',
                'Youssef B.',
                '35 DH',
              ),

              carteTrajet(
                'Conducteur · Publié',
                'Nador → Oujda',
                'Demain',
                '18:00',
                '2 / 3 places',
                '35 DH',
              ),

              carteTrajet(
                'Passager · En attente',
                'Oujda → Fès',
                '3 nov.',
                '07:00',
                'Salma K.',
                '120 DH',
              ),
            ] else ...[
              carteTrajet(
                'Passager · Terminé',
                'Oujda → Berkane',
                '1 nov.',
                '09:00',
                'Amine M.',
                '20 DH',
              ),
            ],
          ],
        ),
      ),
    );
  }
}
