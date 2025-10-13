
import 'package:bili_music_r/components/mini_card.dart';
import 'package:bili_music_r/src/rust/api/task_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class QueueView extends StatefulWidget {
  final bool isDesktopMode;
  final Function() onCreatTaskClicked;
  const QueueView({super.key, required this.isDesktopMode, required this.onCreatTaskClicked});

  @override
  State<QueueView> createState() => _QueueView();
}

class _QueueView extends State<QueueView> {
  List<TempItem> taskQueue = [];

  @override
  void initState() {
    super.initState();

    getQueue();
  }

  Future<void> getQueue() async {
    print("get");
    final queue = await getTaskQueue();
    print(queue);
    setState(() {
      taskQueue = queue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Download"),
        actions: [
            
          widget.isDesktopMode ?
            FilledButton.tonalIcon(onPressed: widget.onCreatTaskClicked, label: Text("Create"), icon: Icon(Icons.add),) : 
            IconButton.filledTonal(onPressed: widget.onCreatTaskClicked, icon: Icon(Icons.add)),

          PopupMenuButton(
            icon: Icon(Icons.more_vert_rounded),
            onSelected: (value) => getQueue,
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
        child: Column(
          children: [
            if (taskQueue.isNotEmpty)
              Expanded(
                child: SlidableAutoCloseBehavior(
                  child: ListView(
                    children: List.generate(taskQueue.length, (index) => MiniCard(
                      title: taskQueue[index].title, 
                      coverUrl: taskQueue[index].coverUrl,
                      labels: [taskQueue[index].partTitle],
                    ))
                    // [
                    //   SlidableItem(
                    //     listItemBuilder: (context) => Card(
                    //       child: ListTile(
                    //         title: Text("MusicTitle"),
                    //         subtitle: Text("by KAFU"),
                    //         isThreeLine: true,
                    //         trailing: IconButton(
                    //           icon: Icon(Icons.more_horiz_rounded), 
                    //           onPressed: (){ Slidable.of(context)?.openStartActionPane(); },
                    //         ),
                    //       ),
                    //     ),
                    //     deleteClicked: (context){},
                    //   )
                    // ]
                  ),
                ),
              )
            else
              Text("nothing")
          ],
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