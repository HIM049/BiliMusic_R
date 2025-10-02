import 'package:bili_music_r/components/navigation/bottombar.dart';
import 'package:bili_music_r/components/navigation/sidebar.dart';
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
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int screenIndex = 0;
  
  void setIndex(int index) {
    setState(() {
      screenIndex = index;
    });
  }

  // method to choose a page to build
  Widget _buildPageContent(int index) {
    switch (index) {
      case 0:
        return const Center(child: Text("Download"));
      case 1:
        return const Center(child: Text('Space'));
      case 2:
        return const Center(child: Text('Settings'));
      default:
        return const Center(child: Text('Unknown'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final desktopMode = MediaQuery.of(context).size.width >= 800;
    if (desktopMode) {
      return LeftNavbarScaffold(index: screenIndex, setIndex: setIndex, buildPageContent: _buildPageContent, );
    } else {
      return BottomNavbarScaffold(index: screenIndex, setIndex: setIndex, buildPageContent: _buildPageContent, );
    }
  }
}