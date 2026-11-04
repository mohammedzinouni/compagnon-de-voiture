import 'dart:math' as math;

import 'inscription_page.dart';

import 'package:flutter/material.dart';

// Les couleurs (fondNoir, carteNoire, jaunePrincipal, texteBlanc, texteGris)
// sont definies dans le fichier de la page Bienvenue.
// Remplacez 'main.dart' par le nom de ce fichier si besoin.
import 'main.dart';

// ==================================
// PAGE CONNEXION
// ==================================

class ConnexionPage extends StatefulWidget {
  const ConnexionPage({super.key});

  @override
  State<ConnexionPage> createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController motDePasseController = TextEditingController();

  bool motDePasseCache = true;
  bool resterConnecte = false;

  @override
  void dispose() {
    emailController.dispose();
    motDePasseController.dispose();
    super.dispose();
  }

  // Retour a la page Bienvenue.
  void retour() {
    Navigator.pop(context);
  }

  // A remplacer plus tard : verification du compte puis ouverture de l'accueil.
  void seConnecter() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Connexion : page accueil a venir')),
    );
  }

  // A remplacer plus tard : ouverture de la page Inscription.
  void creerCompte() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const InscriptionPage()),
    );
  }

  void motDePasseOublie() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Mot de passe oublie : a venir')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondNoir,

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: SizedBox(
                height: math.max(720.0, constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 18,
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // =========================
                      // 0. BOUTON RETOUR (en haut)
                      // =========================
                      Tooltip(
                        message: 'Retour',
                        child: InkWell(
                          onTap: retour,
                          customBorder: const CircleBorder(),
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: carteNoire,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: texteGris.withAlpha(50),
                                width: 1,
                              ),
                            ),
                            child: const Icon(
                              Icons.chevron_left_rounded,
                              color: texteBlanc,
                              size: 30,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // =========================
                      // 1. TITRE
                      // =========================
                      const Text(
                        'Connexion',
                        style: TextStyle(
                          color: texteBlanc,
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        'Connectez-vous pour retrouver vos trajets.',
                        style: TextStyle(
                          color: texteGris,
                          fontSize: 16,
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // =========================
                      // 2. CHAMP EMAIL
                      // =========================
                      ChampTexte(
                        icone: Icons.mail_outline_rounded,
                        texte: 'Email',
                        controller: emailController,
                        clavier: TextInputType.emailAddress,
                      ),

                      const SizedBox(height: 14),

                      // =========================
                      // 3. CHAMP MOT DE PASSE
                      // =========================
                      ChampTexte(
                        icone: Icons.lock_outline_rounded,
                        texte: 'Mot de passe',
                        controller: motDePasseController,
                        cache: motDePasseCache,
                        suffixe: IconButton(
                          tooltip: motDePasseCache
                              ? 'Afficher le mot de passe'
                              : 'Masquer le mot de passe',
                          onPressed: () {
                            setState(() {
                              motDePasseCache = !motDePasseCache;
                            });
                          },
                          icon: Icon(
                            motDePasseCache
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: texteGris,
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      // =========================
                      // 4. SE SOUVENIR + MOT DE PASSE OUBLIE
                      // =========================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                resterConnecte = !resterConnecte;
                              });
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 150),
                                  width: 22,
                                  height: 22,
                                  decoration: BoxDecoration(
                                    color: resterConnecte
                                        ? jaunePrincipal
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(
                                      color: jaunePrincipal.withAlpha(120),
                                      width: 2,
                                    ),
                                  ),
                                  child: resterConnecte
                                      ? const Icon(
                                          Icons.check_rounded,
                                          size: 16,
                                          color: Colors.black,
                                        )
                                      : null,
                                ),

                                const SizedBox(width: 10),

                                const Text(
                                  'Se souvenir de moi',
                                  style: TextStyle(
                                    color: texteGris,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          TextButton(
                            onPressed: motDePasseOublie,
                            child: const Text(
                              'Mot de passe oublié ?',
                              style: TextStyle(
                                color: jaunePrincipal,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      // =========================
                      // 5. BOUTON SE CONNECTER
                      // =========================
                      SizedBox(
                        width: double.infinity,
                        height: 58,

                        child: ElevatedButton(
                          onPressed: seConnecter,

                          style: ElevatedButton.styleFrom(
                            backgroundColor: jaunePrincipal,
                            foregroundColor: Colors.black,
                            elevation: 0,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),

                          child: const Text(
                            'Se connecter',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // =========================
                      // 6. SEPARATEUR "OU"
                      // =========================
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1,
                              color: texteGris.withAlpha(60),
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14),
                            child: Text(
                              'ou',
                              style: TextStyle(color: texteGris, fontSize: 14),
                            ),
                          ),

                          Expanded(
                            child: Container(
                              height: 1,
                              color: texteGris.withAlpha(60),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // =========================
                      // 7. BOUTONS GOOGLE ET FACEBOOK
                      // =========================
                      BoutonSocial(
                        texte: 'Continuer avec Google',
                        logo: const LogoGoogle(),
                        onTap: seConnecter,
                      ),

                      const SizedBox(height: 14),

                      BoutonSocial(
                        texte: 'Continuer avec Facebook',
                        logo: const LogoFacebook(),
                        onTap: seConnecter,
                      ),

                      const Spacer(),

                      // =========================
                      // 8. CREER UN COMPTE
                      // =========================
                      Center(
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 8,
                          children: [
                            const Text(
                              'Pas encore de compte ?',
                              style: TextStyle(color: texteGris, fontSize: 16),
                            ),

                            GestureDetector(
                              onTap: creerCompte,
                              child: const Text(
                                'Créer un compte',
                                style: TextStyle(
                                  color: jaunePrincipal,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),
                    ],
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

// ==================================
// WIDGET : CHAMP DE TEXTE
// ==================================

class ChampTexte extends StatelessWidget {
  final IconData icone;
  final String texte;
  final TextEditingController controller;
  final bool cache;
  final TextInputType? clavier;
  final Widget? suffixe;

  const ChampTexte({
    super.key,
    required this.icone,
    required this.texte,
    required this.controller,
    this.cache = false,
    this.clavier,
    this.suffixe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      padding: const EdgeInsets.only(left: 18, right: 8),

      decoration: BoxDecoration(
        color: carteNoire,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: texteGris.withAlpha(50), width: 1),
      ),

      child: Row(
        children: [
          Icon(icone, color: jaunePrincipal, size: 24),

          const SizedBox(width: 16),

          Expanded(
            child: TextField(
              controller: controller,
              obscureText: cache,
              keyboardType: clavier,
              cursorColor: jaunePrincipal,

              style: const TextStyle(color: texteBlanc, fontSize: 17),

              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: texte,
                hintStyle: const TextStyle(color: texteBlanc, fontSize: 17),
              ),
            ),
          ),

          ?suffixe,
        ],
      ),
    );
  }
}

// ==================================
// WIDGET : BOUTON GOOGLE / FACEBOOK
// ==================================

class BoutonSocial extends StatelessWidget {
  final String texte;
  final Widget logo;
  final VoidCallback onTap;

  const BoutonSocial({
    super.key,
    required this.texte,
    required this.logo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,

      child: OutlinedButton(
        onPressed: onTap,

        style: OutlinedButton.styleFrom(
          backgroundColor: carteNoire,
          side: BorderSide(color: texteGris.withAlpha(50)),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            logo,

            const SizedBox(width: 12),

            Text(
              texte,
              style: const TextStyle(
                color: texteBlanc,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================================
// LOGO GOOGLE (dessine en code)
// ==================================

class LogoGoogle extends StatelessWidget {
  const LogoGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(painter: _GooglePainter()),
    );
  }
}

class _GooglePainter extends CustomPainter {
  const _GooglePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double epaisseur = size.width * 0.22;
    final Rect cercle = Rect.fromCircle(
      center: size.center(Offset.zero),
      radius: (size.width - epaisseur) / 2,
    );

    double rad(double degres) => degres * math.pi / 180;

    void arc(Color couleur, double debut, double balayage) {
      canvas.drawArc(
        cercle,
        rad(debut),
        rad(balayage),
        false,
        Paint()
          ..color = couleur
          ..style = PaintingStyle.stroke
          ..strokeWidth = epaisseur,
      );
    }

    arc(const Color(0xFFEA4335), 215, 105); // rouge (haut)
    arc(const Color(0xFFFBBC05), 140, 75); // jaune (gauche)
    arc(const Color(0xFF34A853), 48, 94); // vert (bas)
    arc(const Color(0xFF4285F4), 0, 50); // bleu (droite)

    // Barre horizontale bleue du G
    canvas.drawRect(
      Rect.fromLTWH(
        size.width / 2,
        size.height / 2 - epaisseur / 2,
        size.width / 2 - 0.5,
        epaisseur,
      ),
      Paint()..color = const Color(0xFF4285F4),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ==================================
// LOGO FACEBOOK (dessine en code)
// ==================================

class LogoFacebook extends StatelessWidget {
  const LogoFacebook({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(painter: _FacebookPainter()),
    );
  }
}

class _FacebookPainter extends CustomPainter {
  const _FacebookPainter();

  @override
  void paint(Canvas canvas, Size size) {
    // On dessine dans une grille de 24 x 24.
    canvas.scale(size.width / 24, size.height / 24);

    canvas.drawCircle(
      const Offset(12, 12),
      12,
      Paint()..color = const Color(0xFF1877F2),
    );

    final Path f = Path()
      ..moveTo(13.2, 24)
      ..lineTo(13.2, 14.6)
      ..lineTo(15.4, 14.6)
      ..lineTo(15.9, 11.5)
      ..lineTo(13.2, 11.5)
      ..lineTo(13.2, 9.6)
      ..cubicTo(13.2, 8.7, 13.6, 8.1, 14.7, 8.1)
      ..lineTo(16, 8.1)
      ..lineTo(16, 5.5)
      ..cubicTo(15.5, 5.4, 14.7, 5.3, 13.9, 5.3)
      ..cubicTo(11.9, 5.3, 10.4, 6.6, 10.4, 9)
      ..lineTo(10.4, 11.5)
      ..lineTo(8, 11.5)
      ..lineTo(8, 14.6)
      ..lineTo(10.4, 14.6)
      ..lineTo(10.4, 24)
      ..close();

    canvas.drawPath(f, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
