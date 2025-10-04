
import 'package:bili_music_r/components/slidable_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DownloadView extends StatefulWidget {
  final bool isDesktopMode;
  const DownloadView({super.key, required this.isDesktopMode});

  @override
  State<DownloadView> createState() => _DownloadView();
}

class _DownloadView extends State<DownloadView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_rounded)),
        title: const Text("Download"),
        actions: [
            
          widget.isDesktopMode ?
            FilledButton.tonalIcon(onPressed: () {}, label: Text("Create"), icon: Icon(Icons.add),) : 
            IconButton.filledTonal(onPressed: () {}, icon: Icon(Icons.add)),

          PopupMenuButton(
            icon: Icon(Icons.more_vert_rounded),
            itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'clear',
              child: Row(
                children: [
                  Icon(Icons.delete_forever, size: 20),
                  SizedBox(width: 8),
                  Text("Clear"),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'share',
              child: Row(
                children: [
                  Icon(Icons.share, size: 20),
                  SizedBox(width: 8),
                  Text("Share"),
                ],
              ),
            ),
          ])
        ],
      ),
      body: Center(
        child: SlidableAutoCloseBehavior(
          child: ListView(
            children: [
              SlidableItem(
                listItemBuilder: (context) => Card(
                  child: ListTile(
                    title: Text("MusicTitle"),
                    subtitle: Text("by KAFU"),
                    isThreeLine: true,
                    trailing: IconButton(
                      icon: Icon(Icons.more_horiz_rounded), 
                      onPressed: (){ Slidable.of(context)?.openStartActionPane(); },
                    ),
                  ),
                ),
                deleteClicked: (context){},
              ),
              SlidableItem(
                listItemBuilder: (context) => Card(
                  child: ListTile(
                    title: Text("MusicTitle"),
                    subtitle: Text("by KAFU"),
                    isThreeLine: true,
                    trailing: IconButton(
                      icon: Icon(Icons.more_horiz_rounded), 
                      onPressed: (){ Slidable.of(context)?.openStartActionPane(); },
                    ),
                  ),
                ),
                deleteClicked: (context){},
              )
            ]
          ),
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