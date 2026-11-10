import 'package:flutter/material.dart';

import 'main.dart';
import 'navigation.dart';

// =====================================
// PAGE 9 : PUBLIER UN TRAJET
// =====================================

class PublierTrajetPage extends StatefulWidget {
  const PublierTrajetPage({super.key});

  @override
  State<PublierTrajetPage> createState() => _PublierTrajetPageState();
}

class _PublierTrajetPageState extends State<PublierTrajetPage> {
  final departController = TextEditingController();
  final arriveeController = TextEditingController();
  final prixController = TextEditingController();

  DateTime dateChoisie = DateTime.now();
  TimeOfDay heureChoisie = TimeOfDay.now();

  int places = 3;

  @override
  void dispose() {
    departController.dispose();
    arriveeController.dispose();
    prixController.dispose();
    super.dispose();
  }

  // =====================================
  // MESSAGE
  // =====================================

  void afficherMessage(String texte) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texte)));
  }

  // =====================================
  // CHOISIR LA DATE
  // =====================================

  Future<void> choisirDate() async {
    final maintenant = DateTime.now();

    final minimum = DateTime(maintenant.year, maintenant.month, maintenant.day);

    final resultat = await showDatePicker(
      context: context,
      initialDate: dateChoisie.isBefore(minimum) ? minimum : dateChoisie,
      firstDate: minimum,
      lastDate: DateTime(2035),
    );

    if (resultat != null && mounted) {
      setState(() {
        dateChoisie = resultat;
      });
    }
  }

  // =====================================
  // CHOISIR L'HEURE
  // =====================================

  Future<void> choisirHeure() async {
    final resultat = await showTimePicker(
      context: context,
      initialTime: heureChoisie,
    );

    if (resultat != null && mounted) {
      setState(() {
        heureChoisie = resultat;
      });
    }
  }

  // =====================================
  // PUBLIER
  // =====================================

  void publierTrajet() {
    String depart = departController.text.trim();
    String arrivee = arriveeController.text.trim();
    String prixTexte = prixController.text.trim();

    if (depart.isEmpty || arrivee.isEmpty || prixTexte.isEmpty) {
      afficherMessage('Veuillez remplir tous les champs');
      return;
    }

    if (depart.toLowerCase() == arrivee.toLowerCase()) {
      afficherMessage('Choisissez deux villes différentes');
      return;
    }

    final prix = double.tryParse(prixTexte.replaceAll(',', '.'));

    if (prix == null || prix <= 0) {
      afficherMessage('Veuillez entrer un prix valide');
      return;
    }

    // Plus tard : enregistrement dans le backend
    afficherMessage('Trajet validé en mode démonstration');
  }

  // =====================================
  // CHAMP DE TEXTE
  // =====================================

  Widget champ(
    String titre,
    IconData icone,
    TextEditingController controller, {
    TextInputType clavier = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: TextField(
        controller: controller,
        keyboardType: clavier,
        style: const TextStyle(color: texteBlanc, fontSize: 16),
        decoration: InputDecoration(
          labelText: titre,
          labelStyle: const TextStyle(color: texteGris),
          prefixIcon: Icon(icone, color: jaunePrincipal),
          filled: true,
          fillColor: carteNoire,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // =====================================
  // DESIGN
  // =====================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondNoir,

      bottomNavigationBar: const BarreNavigation(selection: 2),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 25),
          children: [
            const Text(
              'Publier un trajet',
              style: TextStyle(
                color: texteBlanc,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Partagez vos frais de gasoil',
              style: TextStyle(color: texteGris, fontSize: 14),
            ),

            const SizedBox(height: 30),

            // VILLE DE DEPART
            champ(
              'Ville de départ',
              Icons.radio_button_checked,
              departController,
            ),

            // VILLE D'ARRIVEE
            champ(
              "Ville d'arrivée",
              Icons.location_on_outlined,
              arriveeController,
            ),

            const SizedBox(height: 10),

            // DATE ET HEURE
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: choisirDate,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: carteNoire,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: jaunePrincipal,
                                size: 20,
                              ),
                              SizedBox(width: 8),
                              Text('Date', style: TextStyle(color: texteGris)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${dateChoisie.day}/${dateChoisie.month}/${dateChoisie.year}',
                            style: const TextStyle(
                              color: texteBlanc,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: InkWell(
                    onTap: choisirHeure,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: carteNoire,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: jaunePrincipal,
                                size: 20,
                              ),
                              SizedBox(width: 8),
                              Text('Heure', style: TextStyle(color: texteGris)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            heureChoisie.format(context),
                            style: const TextStyle(
                              color: texteBlanc,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // PLACES DISPONIBLES
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: carteNoire,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Places disponibles',
                          style: TextStyle(
                            color: texteBlanc,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Maximum 4 passagers',
                          style: TextStyle(color: texteGris, fontSize: 12),
                        ),
                      ],
                    ),
                  ),

                  IconButton(
                    onPressed: places > 1
                        ? () {
                            setState(() {
                              places--;
                            });
                          }
                        : null,
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      color: jaunePrincipal,
                    ),
                  ),

                  Text(
                    '$places',
                    style: const TextStyle(
                      color: texteBlanc,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  IconButton(
                    onPressed: places < 4
                        ? () {
                            setState(() {
                              places++;
                            });
                          }
                        : null,
                    icon: const Icon(Icons.add_circle, color: jaunePrincipal),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // PRIX
            champ(
              'Prix par place (DH)',
              Icons.payments_outlined,
              prixController,
              clavier: TextInputType.number,
            ),

            const Text(
              'Part conseillée pour ce trajet : 35 DH (exemple)',
              style: TextStyle(color: jaunePrincipal, fontSize: 12),
            ),

            const SizedBox(height: 45),

            // BOUTON PUBLIER
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: publierTrajet,
                style: ElevatedButton.styleFrom(
                  backgroundColor: jaunePrincipal,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Publier le trajet',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
