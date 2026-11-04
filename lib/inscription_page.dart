import 'dart:math' as math;

import 'package:flutter/material.dart';

// Couleurs deja utilisees dans les pages Bienvenue et Connexion.
import 'main.dart';

class InscriptionPage extends StatefulWidget {
  const InscriptionPage({super.key});

  @override
  State<InscriptionPage> createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  final _formKey = GlobalKey<FormState>();

  final nomController = TextEditingController();
  final emailController = TextEditingController();
  final telephoneController = TextEditingController();
  final motDePasseController = TextEditingController();

  bool estPassager = true;
  bool motDePasseCache = true;
  bool conditionsAcceptees = false;

  @override
  void dispose() {
    nomController.dispose();
    emailController.dispose();
    telephoneController.dispose();
    motDePasseController.dispose();
    super.dispose();
  }

  // La page Connexion a ouvert cette page : on y retourne.
  void retournerConnexion() {
    Navigator.pop(context);
  }

  // Validation locale seulement : aucun compte n'est encore enregistre.
  void creerCompte() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    if (!conditionsAcceptees) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez accepter les conditions pour continuer.'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Formulaire ${estPassager ? "Passager" : "Conducteur"} valide. '
          'Enregistrement du compte a connecter plus tard.',
        ),
      ),
    );
  }

  Widget champ({
    required TextEditingController controller,
    required String indication,
    required IconData icone,
    TextInputType clavier = TextInputType.text,
    String? prefixe,
    bool masquer = false,
    Widget? suffixe,
    String? Function(String?)? validateur,
  }) {
    final contour = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide.none,
    );

    return TextFormField(
      controller: controller,
      keyboardType: clavier,
      obscureText: masquer,
      validator: validateur,
      cursorColor: jaunePrincipal,
      style: const TextStyle(color: texteBlanc, fontSize: 15),
      decoration: InputDecoration(
        hintText: indication,
        hintStyle: const TextStyle(color: texteBlanc, fontSize: 14),
        prefixIcon: prefixe == null
            ? Icon(icone, color: jaunePrincipal, size: 21)
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 14),
                  Icon(icone, color: jaunePrincipal, size: 21),
                  const SizedBox(width: 10),
                  Text(
                    prefixe,
                    style: const TextStyle(
                      color: texteBlanc,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
        suffixIcon: suffixe,
        filled: true,
        fillColor: carteNoire,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 17,
        ),
        border: contour,
        enabledBorder: contour,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: jaunePrincipal, width: 1),
        ),
        errorBorder: contour,
        focusedErrorBorder: contour,
      ),
    );
  }

  Widget boutonRole({
    required String texte,
    required bool actif,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(26),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: actif ? jaunePrincipal : Colors.transparent,
            borderRadius: BorderRadius.circular(26),
          ),
          child: Text(
            texte,
            style: TextStyle(
              color: actif ? Colors.black : texteBlanc,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
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
        child: LayoutBuilder(
          builder: (context, contraintes) {
            return SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 430,
                    minHeight: math.max(720.0, contraintes.maxHeight),
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 18,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),

                            // 1. Retour vers la connexion.
                            IconButton(
                              onPressed: retournerConnexion,
                              tooltip: 'Retour',
                              style: IconButton.styleFrom(
                                backgroundColor: carteNoire,
                              ),
                              icon: const Icon(
                                Icons.chevron_left_rounded,
                                color: texteBlanc,
                              ),
                            ),
                            const SizedBox(height: 12),

                            // 2. Titre et description.
                            const Text(
                              'Créer un compte',
                              style: TextStyle(
                                color: texteBlanc,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -1.1,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Rejoignez FiftyFifty en quelques secondes.',
                              style: TextStyle(color: texteGris, fontSize: 14),
                            ),
                            const SizedBox(height: 16),

                            // 3. Choix du role.
                            Container(
                              height: 48,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: carteNoire,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                children: [
                                  boutonRole(
                                    texte: 'Passager',
                                    actif: estPassager,
                                    onTap: () =>
                                        setState(() => estPassager = true),
                                  ),
                                  boutonRole(
                                    texte: 'Conducteur',
                                    actif: !estPassager,
                                    onTap: () =>
                                        setState(() => estPassager = false),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 14),

                            // 4. Nom complet.
                            champ(
                              controller: nomController,
                              indication: 'Nom complet',
                              icone: Icons.person_outline_rounded,
                              validateur: (valeur) {
                                if (valeur == null || valeur.trim().isEmpty) {
                                  return 'Entrez votre nom complet';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),

                            // 5. Adresse e-mail.
                            champ(
                              controller: emailController,
                              indication: 'Email',
                              icone: Icons.mail_outline_rounded,
                              clavier: TextInputType.emailAddress,
                              validateur: (valeur) {
                                if (valeur == null ||
                                    !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                                        .hasMatch(valeur.trim())) {
                                  return 'Entrez un email valide';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),

                            // 6. Telephone marocain (+212).
                            champ(
                              controller: telephoneController,
                              indication: '612345678',
                              prefixe: '+212  ',
                              icone: Icons.phone_outlined,
                              clavier: TextInputType.phone,
                              validateur: (valeur) {
                                final chiffres =
                                    valeur?.replaceAll(RegExp(r'\D'), '') ?? '';
                                if (chiffres.length != 9) {
                                  return 'Entrez 9 chiffres apres +212';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),

                            // 7. Mot de passe et bouton oeil.
                            champ(
                              controller: motDePasseController,
                              indication: 'Mot de passe (6 caract. min.)',
                              icone: Icons.lock_outline_rounded,
                              masquer: motDePasseCache,
                              suffixe: IconButton(
                                tooltip: motDePasseCache
                                    ? 'Afficher le mot de passe'
                                    : 'Masquer le mot de passe',
                                onPressed: () => setState(
                                  () => motDePasseCache = !motDePasseCache,
                                ),
                                icon: Icon(
                                  motDePasseCache
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: texteGris,
                                  size: 20,
                                ),
                              ),
                              validateur: (valeur) {
                                if (valeur == null || valeur.length < 6) {
                                  return 'Minimum 6 caracteres';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),

                            // 8. Acceptation des conditions.
                            InkWell(
                              onTap: () => setState(
                                () =>
                                    conditionsAcceptees = !conditionsAcceptees,
                              ),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: conditionsAcceptees,
                                    onChanged: (valeur) => setState(
                                      () =>
                                          conditionsAcceptees = valeur ?? false,
                                    ),
                                    activeColor: jaunePrincipal,
                                    checkColor: Colors.black,
                                    side: const BorderSide(
                                      color: jaunePrincipal,
                                    ),
                                    visualDensity: VisualDensity.compact,
                                  ),
                                  const Expanded(
                                    child: Text.rich(
                                      TextSpan(
                                        style: TextStyle(
                                          color: texteGris,
                                          fontSize: 12,
                                        ),
                                        children: [
                                          TextSpan(text: "J'accepte les "),
                                          TextSpan(
                                            text: "conditions d'utilisation",
                                            style: TextStyle(
                                              color: jaunePrincipal,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(text: '\net la '),
                                          TextSpan(
                                            text:
                                                'politique de confidentialité.',
                                            style: TextStyle(
                                              color: jaunePrincipal,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),

                            // 9. Bouton d'inscription.
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: creerCompte,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: jaunePrincipal,
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: const Text(
                                  'Créer mon compte',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            const Spacer(),

                            // 10. Lien pour revenir a la connexion.
                            Center(
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  const Text(
                                    'Déjà un compte ? ',
                                    style: TextStyle(
                                      color: texteGris,
                                      fontSize: 14,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: retournerConnexion,
                                    child: const Text(
                                      'Se connecter',
                                      style: TextStyle(
                                        color: jaunePrincipal,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
