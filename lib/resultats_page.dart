import 'package:flutter/material.dart';

import 'main.dart';
import 'navigation.dart';
import 'detail_trajet_page.dart';

class ResultatsPage extends StatefulWidget {
  final String depart;
  final String arrivee;
  final int passagers;

  const ResultatsPage({
    super.key,
    required this.depart,
    required this.arrivee,
    required this.passagers,
  });

  @override
  State<ResultatsPage> createState() => _ResultatsPageState();
}

class _ResultatsPageState extends State<ResultatsPage> {
  String filtre = 'Tous';

  final trajets = [
    {
      'heure': '08:30',
      'chauffeur': 'Youssef B.',
      'prix': 35,
      'note': 4.9,
      'places': 3,
    },
    {
      'heure': '11:00',
      'chauffeur': 'Salma K.',
      'prix': 40,
      'note': 4.8,
      'places': 2,
    },
    {
      'heure': '14:15',
      'chauffeur': 'Amine M.',
      'prix': 30,
      'note': 4.7,
      'places': 1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final visibles = trajets
        .where((t) => (t['places'] as int) >= widget.passagers)
        .toList();

    if (filtre == 'Matin') {
      visibles.removeWhere(
        (t) => int.parse((t['heure'] as String).split(':')[0]) >= 12,
      );
    }

    if (filtre == 'Moins cher') {
      visibles.sort((a, b) => (a['prix'] as int).compareTo(b['prix'] as int));
    }

    if (filtre == 'Mieux notés') {
      visibles.sort(
        (a, b) => (b['note'] as double).compareTo(a['note'] as double),
      );
    }

    return Scaffold(
      backgroundColor: fondNoir,
      appBar: AppBar(
        backgroundColor: fondNoir,
        title: Text('${widget.depart} → ${widget.arrivee}'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(22),
        children: [
          Text(
            '${widget.passagers} passager(s)',
            style: const TextStyle(color: texteGris),
          ),
          const SizedBox(height: 18),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ['Tous', 'Matin', 'Moins cher', 'Mieux notés'].map((f) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(f),
                    selected: filtre == f,
                    selectedColor: jaunePrincipal,
                    onSelected: (_) {
                      setState(() => filtre = f);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 22),
          Text(
            '${visibles.length} trajets disponibles',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          ...visibles.map((t) {
            final chauffeur = t['chauffeur'] as String;
            final heure = t['heure'] as String;
            final prix = t['prix'] as int;
            final places = t['places'] as int;
            final note = t['note'] as double;

            return InkWell(
              onTap: () {
                afficherPage(
                  context,
                  DetailTrajetPage(
                    depart: widget.depart,
                    arrivee: widget.arrivee,
                    chauffeur: chauffeur,
                    heure: heure,
                    prix: prix,
                  ),
                );
              },
              child: carteSombre(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          heure,
                          style: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          '1 h 20',
                          style: TextStyle(color: texteGris),
                        ),
                        Text(
                          widget.arrivee,
                          style: const TextStyle(color: jaunePrincipal),
                        ),
                      ],
                    ),
                    const Divider(height: 28),
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: jaunePrincipal,
                          child: Icon(Icons.person, color: Colors.black),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(chauffeur),
                              Text(
                                '$note ★ · $places places',
                                style: const TextStyle(color: texteGris),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '$prix DH',
                          style: const TextStyle(
                            color: jaunePrincipal,
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
