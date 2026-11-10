import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import 'main.dart';
import 'accueil_page.dart';

class ConducteurPage extends StatefulWidget {
  const ConducteurPage({super.key});

  @override
  State<ConducteurPage> createState() => _ConducteurPageState();
}

class _ConducteurPageState extends State<ConducteurPage> {
  final nom = TextEditingController();
  final email = TextEditingController();
  final telephone = TextEditingController();
  final password = TextEditingController();

  bool conditions = false;
  bool cacher = true;

  final Map<String, PlatformFile> documents = {};

  @override
  void dispose() {
    nom.dispose();
    email.dispose();
    telephone.dispose();
    password.dispose();
    super.dispose();
  }

  void message(String texte) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texte)));
  }

  Future<void> choisirDocument(String type) async {
    try {
      final resultat = await FilePicker.pickFile(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      );

      if (!mounted) return;

      if (resultat != null) {
        setState(() {
          documents[type] = resultat;
        });
      }
    } catch (e) {
      if (mounted) message('Erreur de sélection du document');
    }
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
      message('Téléphone invalide');
      return;
    }

    if (password.text.length < 6) {
      message('Mot de passe : minimum 6 caractères');
      return;
    }

    if (documents.length < 5) {
      message('Ajoutez tous les documents');
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

  Widget champConducteur(
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
                  onPressed: () {
                    setState(() => cacher = !cacher);
                  },
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

  Widget carteDocument(String titre, String description, String type) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: carteNoire,
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        leading: const Icon(Icons.description_outlined, color: jaunePrincipal),
        title: Text(titre),
        subtitle: Text(
          documents[type]?.name ?? description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: texteGris),
        ),
        trailing: IconButton(
          onPressed: () => choisirDocument(type),
          icon: Icon(
            documents.containsKey(type)
                ? Icons.check_circle
                : Icons.add_circle_outline,
            color: jaunePrincipal,
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
          padding: const EdgeInsets.all(24),
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
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Inscription conducteur',
                style: TextStyle(color: texteGris),
              ),
              const SizedBox(height: 18),
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
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Passager'),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: jaunePrincipal,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text(
                          'Conducteur',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              champConducteur('Nom complet', Icons.person_outline, nom),
              champConducteur('Email', Icons.mail_outline, email),
              champConducteur(
                '612345678',
                Icons.phone_outlined,
                telephone,
                prefixe: '+212 ',
              ),
              champConducteur(
                'Mot de passe',
                Icons.lock_outline,
                password,
                motDePasse: true,
              ),
              const SizedBox(height: 15),
              const Text(
                'Documents du conducteur',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              carteDocument('Carte CIN - Recto', 'Photo du recto', 'cin_recto'),
              carteDocument('Carte CIN - Verso', 'Photo du verso', 'cin_verso'),
              carteDocument('Permis de conduire', 'Photo du permis', 'permis'),
              carteDocument(
                'Carte grise du véhicule',
                'Photo du document',
                'carte_grise',
              ),
              carteDocument(
                'Assurance automobile',
                'Justificatif valide',
                'assurance',
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
                      "J'accepte les conditions d'utilisation",
                      style: TextStyle(color: texteGris),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
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
              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Déjà un compte ? Se connecter',
                    style: TextStyle(color: jaunePrincipal),
                  ),
                ),
              ),
              const Center(
                child: Text(
                  'Documents privés : vérification uniquement.',
                  style: TextStyle(color: texteGris, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
