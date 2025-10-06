
import 'package:flutter/material.dart';
import 'package:bili_music_r/src/rust/api/simple.dart';

class CreatTaskView extends StatefulWidget {
  final bool isDesktopMode;
  final Function() onBackClicked;
  const CreatTaskView({
    super.key, 
    required this.isDesktopMode,
    required this.onBackClicked,
  });

  @override
  State<CreatTaskView> createState() => _CreatTaskView();
}

class _CreatTaskView extends State<CreatTaskView> {
  String result = "";

  Future<void> callRustAsync() async {
    setState(() => result = "Calling Rust async...");
    final video = await queryBiliInfo(input: "BV1q1HnzZEVM");
    
    setState(() => result = video!.author);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: widget.onBackClicked, icon: Icon(Icons.arrow_back_rounded)),
        title: const Text("Download"),
        actions: [
            
          widget.isDesktopMode ?
            FilledButton.tonalIcon(onPressed: () {}, label: Text("Create"), icon: Icon(Icons.add),) : 
            IconButton.filledTonal(onPressed: () {}, icon: Icon(Icons.add)),

          // PopupMenuButton(
          //   icon: Icon(Icons.more_vert_rounded),
          //   itemBuilder: (context) => [
          //   const PopupMenuItem(
          //     value: 'clear',
          //     child: Row(
          //       children: [
          //         Icon(Icons.delete_forever, size: 20),
          //         SizedBox(width: 8),
          //         Text("Clear"),
          //       ],
          //     ),
          //   ),
          //   const PopupMenuItem(
          //     value: 'share',
          //     child: Row(
          //       children: [
          //         Icon(Icons.share, size: 20),
          //         SizedBox(width: 8),
          //         Text("Share"),
          //       ],
          //     ),
          //   ),
          // ])
        ],
      ),
      body: Center(
        child: Card.filled(
          margin: EdgeInsets.all(10),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.all(20),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Password'),
                  ),
                ),
                FilledButton.icon(onPressed: callRustAsync, label: Text("submit")),
                Text(result)
              ],
            ),
          )
        )
        
      ),
      floatingActionButton: widget.isDesktopMode ? FloatingActionButton.extended(
        onPressed: (){},
        icon: Icon(Icons.play_arrow_rounded),
        label: const Text("Download"),
      ) : 
      FloatingActionButton(onPressed: (){}, child: Icon(Icons.play_arrow_rounded),)
    );
  }
}