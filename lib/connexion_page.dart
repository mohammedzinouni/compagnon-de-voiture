import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'main.dart';
import 'inscription_page.dart';
import 'accueil_page.dart';

// =====================================
// PAGE 2 : CONNEXION
// =====================================

class ConnexionPage extends StatefulWidget {
  const ConnexionPage({super.key});

  @override
  State<ConnexionPage> createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool cacherMotDePasse = true;
  bool souvenir = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // CONNEXION PROVISOIRE
  void seConnecter() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const AccueilPage()),
      (route) => false,
    );
  }

  void afficherMessage(String texte) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texte)));
  }

  // CHAMP DE TEXTE
  Widget champConnexion(
    String titre,
    IconData icone,
    TextEditingController controller, {
    bool password = false,
    TextInputType clavier = TextInputType.text,
  }) {
    return Container(
      height: 57,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.only(left: 18, right: 7),
      decoration: BoxDecoration(
        color: carteNoire,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: texteGris.withAlpha(40)),
      ),
      child: Row(
        children: [
          Icon(icone, color: jaunePrincipal, size: 23),

          const SizedBox(width: 14),

          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: clavier,
              obscureText: password && cacherMotDePasse,
              cursorColor: jaunePrincipal,
              style: const TextStyle(color: texteBlanc, fontSize: 16),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: titre,
                hintStyle: const TextStyle(color: texteGris, fontSize: 15),
              ),
            ),
          ),

          if (password)
            IconButton(
              onPressed: () {
                setState(() {
                  cacherMotDePasse = !cacherMotDePasse;
                });
              },
              icon: Icon(
                cacherMotDePasse
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: texteGris,
              ),
            ),
        ],
      ),
    );
  }

  // BOUTON GOOGLE OU FACEBOOK
  Widget boutonSocial(String titre, Widget logo, VoidCallback action) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: OutlinedButton(
        onPressed: action,
        style: OutlinedButton.styleFrom(
          backgroundColor: carteNoire,
          side: BorderSide(color: texteGris.withAlpha(40)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            logo,
            const SizedBox(width: 13),
            Flexible(
              child: Text(
                titre,
                style: const TextStyle(
                  color: texteBlanc,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =====================================
  // DESIGN PRINCIPAL
  // =====================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondNoir,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // RETOUR
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    style: IconButton.styleFrom(backgroundColor: carteNoire),
                    icon: const Icon(
                      Icons.chevron_left_rounded,
                      color: texteBlanc,
                      size: 28,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // TITRE
                  const Text(
                    'Connexion',
                    style: TextStyle(
                      color: texteBlanc,
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 7),

                  const Text(
                    'Connectez-vous pour retrouver vos trajets.',
                    style: TextStyle(color: texteGris, fontSize: 15),
                  ),

                  const SizedBox(height: 30),

                  // EMAIL
                  champConnexion(
                    'Email',
                    Icons.mail_outline_rounded,
                    emailController,
                    clavier: TextInputType.emailAddress,
                  ),

                  // MOT DE PASSE
                  champConnexion(
                    'Mot de passe',
                    Icons.lock_outline_rounded,
                    passwordController,
                    password: true,
                  ),

                  // SE SOUVENIR DE MOI
                  Row(
                    children: [
                      Checkbox(
                        value: souvenir,
                        activeColor: jaunePrincipal,
                        checkColor: Colors.black,
                        side: const BorderSide(color: jaunePrincipal),
                        onChanged: (valeur) {
                          setState(() {
                            souvenir = valeur ?? false;
                          });
                        },
                      ),

                      const Expanded(
                        child: Text(
                          'Se souvenir de moi',
                          style: TextStyle(color: texteGris, fontSize: 12),
                        ),
                      ),

                      TextButton(
                        onPressed: () {
                          afficherMessage('Mot de passe oublié : à venir');
                        },
                        child: const Text(
                          'Mot de passe oublié ?',
                          style: TextStyle(color: jaunePrincipal, fontSize: 12),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // SE CONNECTER
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: seConnecter,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: jaunePrincipal,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Se connecter',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // SEPARATEUR
                  Row(
                    children: [
                      Expanded(child: Divider(color: texteGris.withAlpha(60))),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text('ou', style: TextStyle(color: texteGris)),
                      ),
                      Expanded(child: Divider(color: texteGris.withAlpha(60))),
                    ],
                  ),

                  const SizedBox(height: 22),

                  // GOOGLE
                  boutonSocial('Continuer avec Google', const LogoGoogle(), () {
                    afficherMessage('Connexion Google à venir');
                  }),

                  const SizedBox(height: 14),

                  // FACEBOOK
                  boutonSocial(
                    'Continuer avec Facebook',
                    const LogoFacebook(),
                    () {
                      afficherMessage('Connexion Facebook à venir');
                    },
                  ),

                  const SizedBox(height: 65),

                  // CREER UN COMPTE
                  Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Text(
                          'Pas encore de compte ?',
                          style: TextStyle(color: texteGris, fontSize: 14),
                        ),

                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const InscriptionPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'Créer un compte',
                            style: TextStyle(
                              color: jaunePrincipal,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// =====================================
// LOGO GOOGLE EN SVG
// =====================================

class LogoGoogle extends StatelessWidget {
  const LogoGoogle({super.key});

  static const String logo = '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
  <path fill="#4285F4" d="M21.35 11.1H12v3.8h5.35c-.23 1.2-.91 2.22-1.94 2.9v2.42h3.14c1.84-1.7 2.9-4.2 2.9-7.2 0-.64-.06-1.25-.1-1.92z"/>
  <path fill="#34A853" d="M12 22c2.7 0 4.97-.9 6.63-2.44l-3.14-2.42c-.87.58-1.98.93-3.49.93-2.68 0-4.95-1.8-5.76-4.22H2.99v2.49C4.64 19.6 8.04 22 12 22z"/>
  <path fill="#FBBC05" d="M6.24 13.85A5.94 5.94 0 0 1 5.93 12c0-.64.11-1.27.31-1.85V7.66H2.99A9.98 9.98 0 0 0 2 12c0 1.61.38 3.13.99 4.34l3.25-2.49z"/>
  <path fill="#EA4335" d="M12 5.93c1.54 0 2.92.53 4.01 1.58l3.01-3.01C17.2 2.8 14.81 2 12 2 8.04 2 4.64 4.4 2.99 7.66l3.25 2.49C7.05 7.73 9.32 5.93 12 5.93z"/>
</svg>
''';

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(logo, width: 25, height: 25);
  }
}

// =====================================
// LOGO FACEBOOK EN SVG
// =====================================

class LogoFacebook extends StatelessWidget {
  const LogoFacebook({super.key});

  static const String logo = '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
  <circle cx="12" cy="12" r="12" fill="#1877F2"/>
  <path fill="#FFFFFF" d="M14.2 21v-8h2.7l.4-3.1h-3.1v-2c0-.9.3-1.5 1.6-1.5h1.7V3.6c-.3 0-1.3-.1-2.5-.1-2.5 0-4.2 1.5-4.2 4.4v2H8V13h2.8v8z"/>
</svg>
''';

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(logo, width: 25, height: 25);
  }
}
