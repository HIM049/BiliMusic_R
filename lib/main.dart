import 'package:bili_music_r/components/navigation/bottombar.dart';
import 'package:bili_music_r/components/navigation/sidebar.dart';
import 'package:bili_music_r/views/download_view.dart';
import 'package:bili_music_r/views/settings_view.dart';
import 'package:bili_music_r/views/space_view.dart';
import 'package:flutter/material.dart';
import 'package:bili_music_r/src/rust/api/simple.dart';
import 'package:bili_music_r/src/rust/frb_generated.dart';

Future<void> main() async {
  await RustLib.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int screenIndex = 0;
  late bool isDesktopMode;
  
  void setIndex(int index) {
    setState(() {
      screenIndex = index;
    });
  }

  // method to choose a page to build
  Widget _buildPageContent(int index) {
    switch (index) {
      case 0:
        return DownloadView();
      case 1:
        return SpaceView();
      case 2:
        return SettingsView(); 
      default:
        return const Center(child: Text('Unknown'));
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      isDesktopMode = MediaQuery.of(context).size.width >= 600;
    }); 

    if (isDesktopMode) {
      return LeftNavbarScaffold(index: screenIndex, setIndex: setIndex, buildPageContent: _buildPageContent, );
    } else {
      return BottomNavbarScaffold(index: screenIndex, setIndex: setIndex, buildPageContent: _buildPageContent, );
    }
  }
}