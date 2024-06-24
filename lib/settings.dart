import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'the_dark_mode.dart';

class SettingsPage extends StatelessWidget {
  void showAbout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('À propos'),
          content: Text('Ceci est une application qui a un objectif de suivre les actions et les contrôles SST dans l\'entreprise (Z_CONFECTION_INTERNATIONNAL)'),
          actions: <Widget>[
            TextButton(
              child: Text('Fermer'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Paramètres',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            title: const Text('Changer de thème'),
            trailing: Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.setDarkMode(value);
              },
            ),
          ),
          ListTile(
            title: const Text('À propos'),
            onTap: () {
              showAbout(context);
            },
          ),
        ],
      ),
    );
  }
}
