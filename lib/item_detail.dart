import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'the_dark_mode.dart';

class ItemDetailPage extends StatefulWidget {
  final String item;

  const ItemDetailPage({Key? key, required this.item}) : super(key: key);

  @override
  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  int rapportCount = 0;

  void _ajouterRapport() {
    setState(() {
      rapportCount++;
    });
    _afficherAlerte('Rapport ajouté');
  }

  void _supprimerRapport() {
    setState(() {
      if (rapportCount > 0) {
        rapportCount--;
      }
    });
    _afficherAlerte('Rapport supprimé');
  }

  void _afficherAlerte(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final textColor = themeProvider.isDarkMode ? Colors.white : Colors.black;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Détail de Suivi : ${widget.item}',
              style: TextStyle(
                color: textColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _ajouterRapport,
                          icon: Icon(Icons.add),
                          label: Text('Ajouter Rapport'),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed: _supprimerRapport,
                          icon: Icon(Icons.remove),
                          label: Text('Supprimer Rapport'),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
              Expanded(
                child: Container(), // Espace pour le contenu principal
              ),
            ],
          ),
        );
      },
    );
  }
}
