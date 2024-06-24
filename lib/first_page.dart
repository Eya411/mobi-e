import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings.dart';
import 'item_detail.dart';
import 'the_dark_mode.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int currentIndex = 0;

  final List<String> items = [
    'Vérification lampe de secours',
    'Vérification des Détecteurs de fumé',
    'Vérification de systéme alarme',
    'Interventions sur le compresseur',
    'Fiche de contrôle interne des extincteurs',
    'Monte de charge',
    'Elevateur',
    'Tubnion',
    'RIA'
  ];

  int rapportCount = 0;

  void ajouterRapport() {
    if (rapportCount < 20) {
      setState(() {
        rapportCount++;
      });
      _afficherSnackbar('Suivi ajouté');
    } else {
      _afficherSnackbar('Limite de 20 suivis atteinte');
    }
  }

  void supprimerRapport() {
    setState(() {
      if (rapportCount > 0) {
        rapportCount--;
      }
    });
    _afficherSnackbar('Suivi supprimé');
  }

  void _afficherSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final textColor = themeProvider.isDarkMode ? Colors.white : Colors.black;
    final borderColor = themeProvider.isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          ' "Z_CONFECTION_INTERNATIONNAL": Liste de Suivi SST ',
          style: TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
          ),
        ),
        actions: [
          IconButton(
            onPressed: ajouterRapport,
            icon: Icon(Icons.add, color: textColor),
            tooltip: 'Ajouter Suivi',
          ),
          IconButton(
            onPressed: supprimerRapport,
            icon: Icon(Icons.remove, color: textColor),
            tooltip: 'Supprimer Suivi',
          ),
        ],
      ),
      body: Center(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 15,
            mainAxisSpacing: 5,
            crossAxisSpacing: 7,
          ),
          padding: const EdgeInsets.all(20),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ItemDetailPage(
                      item: items[index],
                    ),
                  ),
                );
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: borderColor, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    items[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(color: textColor, fontSize: 16),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: 'Accueil',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Paramètres',
            icon: Icon(Icons.settings),
          ),
        ],
        currentIndex: currentIndex,
        onTap: (int index) {
          if (index == 1) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SettingsPage(),
              ),
            );
          } else {
            setState(() {
              currentIndex = index;
            });
          }
        },
      ),
    );
  }
}
