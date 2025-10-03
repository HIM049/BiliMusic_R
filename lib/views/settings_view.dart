
import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsView();
}

class _SettingsView extends State<SettingsView> {
  @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_rounded)),
        title: const Text("Settings"),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.settings_backup_restore_rounded))
        ],
      ),
      body: Center(
        child: Text("Settings")
      ),
    );
  }
}