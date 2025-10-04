
import 'package:flutter/material.dart';

class SpaceView extends StatefulWidget {
  final bool isDesktopMode;
  const SpaceView({super.key, required this.isDesktopMode});

  @override
  State<SpaceView> createState() => _SpaceView();
}

class _SpaceView extends State<SpaceView> {
  @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_rounded)),
        title: const Text("Space"),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.settings_backup_restore_rounded))
        ],
      ),
      body: Center(
        child: FilledButton.tonal(onPressed: (){}, child: Text("Test"))
      ),
    );
  }
}