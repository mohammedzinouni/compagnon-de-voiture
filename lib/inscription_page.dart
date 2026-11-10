import 'package:flutter/material.dart';

import 'main.dart';
import 'conducteur_page.dart';
import 'accueil_page.dart';

class InscriptionPage extends StatefulWidget {
  const InscriptionPage({super.key});

  @override
  State<InscriptionPage> createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  final nom = TextEditingController();
  final email = TextEditingController();
  final telephone = TextEditingController();
  final password = TextEditingController();

  bool conditions = false;
  bool cacher = true;

  @override
  void dispose() {
    nom.dispose();
    email.dispose();
    telephone.dispose();
    password.dispose();
    super.dispose();
  }

  void creerCompte() {
    if (nom.text.trim().isEmpty ||
        email.text.trim().isEmpty ||
        telephone.text.trim().isEmpty ||
        password.text.isEmpty) {
      message('Remplissez tous les champs');
      return;
    }

    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email.text.trim())) {
      message('Email invalide');
      return;
    }

    if (!RegExp(r'^[67]\d{8}$').hasMatch(telephone.text.trim())) {
      message('Téléphone invalide : 9 chiffres après +212');
      return;
    }

    if (password.text.length < 6) {
      message('Minimum 6 caractères pour le mot de passe');
      return;
    }

    if (!conditions) {
      message('Acceptez les conditions');
      return;
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const AccueilPage()),
      (route) => false,
    );
  }

  void message(String texte) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texte)));
  }

  Widget champInscription(
    String titre,
    IconData icone,
    TextEditingController controller, {
    bool motDePasse = false,
    String? prefixe,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        obscureText: motDePasse && cacher,
        style: const TextStyle(color: texteBlanc),
        decoration: InputDecoration(
          hintText: titre,
          prefixIcon: Icon(icone, color: jaunePrincipal),
          prefixText: prefixe,
          prefixStyle: const TextStyle(color: texteBlanc),
          suffixIcon: motDePasse
              ? IconButton(
                  onPressed: () => setState(() => cacher = !cacher),
                  icon: Icon(
                    cacher
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: texteGris,
                  ),
                )
              : null,
          filled: true,
          fillColor: carteNoire,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondNoir,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(27),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.chevron_left),
              ),
              const SizedBox(height: 18),
              const Text(
                'Créer un compte',
                style: TextStyle(
                  color: texteBlanc,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Rejoignez FiftyFifty en quelques secondes.',
                style: TextStyle(color: texteGris),
              ),
              const SizedBox(height: 20),
              Container(
                height: 48,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: carteNoire,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: jaunePrincipal,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text(
                          'Passager',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ConducteurPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Conducteur',
                          style: TextStyle(color: texteBlanc),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              champInscription('Nom complet', Icons.person_outline, nom),
              champInscription('Email', Icons.mail_outline, email),
              champInscription(
                '612345678',
                Icons.phone_outlined,
                telephone,
                prefixe: '+212 ',
              ),
              champInscription(
                'Mot de passe',
                Icons.lock_outline,
                password,
                motDePasse: true,
              ),
              Row(
                children: [
                  Checkbox(
                    value: conditions,
                    activeColor: jaunePrincipal,
                    onChanged: (v) {
                      setState(() => conditions = v ?? false);
                    },
                  ),
                  const Expanded(
                    child: Text(
                      "J'accepte les conditions d'utilisation\n"
                      'et la politique de confidentialité.',
                      style: TextStyle(color: texteGris, fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: creerCompte,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: jaunePrincipal,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text(
                    'Créer mon compte',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Déjà un compte ? Se connecter',
                    style: TextStyle(color: jaunePrincipal),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
