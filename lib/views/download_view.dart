
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DownloadView extends StatefulWidget {
  const DownloadView({super.key});

  @override
  State<DownloadView> createState() => _DownloadView();
}

class _DownloadView extends State<DownloadView> {

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_rounded)),
        title: const Text("Download"),
        actions: [
          IconButton.filledTonal(onPressed: () {}, icon: Icon(Icons.add)),
          FilledButton.tonalIcon(onPressed: () {}, label: Text("Create"), icon: Icon(Icons.add),),
          PopupMenuButton(itemBuilder: (context) => [
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
          ],)
        ],
      ),
      body: Center(
        child: ListView(
          children: [
            Slidable(
              startActionPane: ActionPane(
                motion: BehindMotion(), 
                children: [
                  SlidableAction(
                    onPressed: (context) { },
                    backgroundColor: Colors.redAccent,
                    icon: Icons.delete,
                    label: "Delete",
                  ),
                  SlidableAction(
                    onPressed: (context) { },
                    backgroundColor: colorScheme.secondary,
                    icon: Icons.edit,
                    label: "Edit",
                  )
                ]
                ),
              child: ListTile(title: Text("List item1"),)
            )
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){},
        icon: Icon(Icons.play_arrow_rounded),
        label: const Text("Download"),
      ),
    );
  }
}