import 'package:bili_music_r/src/rust/api/query.dart';
import 'package:bili_music_r/src/rust/api/task_handler.dart';
import 'package:intl/intl.dart';
import 'package:bili_music_r/components/extend_card.dart';
import 'package:flutter/material.dart';

class QueryTaskView extends StatefulWidget {
  final bool isDesktopMode;
  final Function() onBackClicked;
  final Function() onAddListClicked;
  const QueryTaskView({
    super.key, 
    required this.isDesktopMode,
    required this.onBackClicked,
    required this.onAddListClicked,
  });

  @override
  State<QueryTaskView> createState() => _CreatTaskView();
}

class _CreatTaskView extends State<QueryTaskView> {
  VideoInfoFlutter? result;

  // query
  Future<void> query(String id) async {
    if (id.isEmpty) return;
    final video = await queryBiliInfo(input: id);
    setState(() {
      result = video;
    });
    // TODO: Loading animate, error check
  }

  Future<void> onAddToList() async {
    try {
      await createTempQueueFromCurrent();
    } catch(error) {
      showSnackBar("Something wrong: $error");
    }
    widget.onAddListClicked();
  }

  void showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(msg),
        // action: SnackBarAction(
        //   label: 'Action',
        //   onPressed: () {
        //     // Code to execute.
        //   },
        // ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    String formatUnixTime(int unixTime) {
      var date = DateTime.fromMillisecondsSinceEpoch(unixTime * 1000);
      return DateFormat('yy-MM-dd HH:mm').format(date);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: widget.onBackClicked, icon: Icon(Icons.arrow_back_rounded)),
        title: const Text("Create Tasks"),
        actions: [
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
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            width: 400,
            // height: 300,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Query", style: theme.textTheme.headlineLarge,),
                ),

                const SizedBox(height: 8.0,),

                // Search zone
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Column(
                    children: [
                      SearchBar(
                        hintText: 'Type your video id',
                        // textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 16)),
                        elevation: WidgetStatePropertyAll(0),
                        leading: const Icon(Icons.search),
                        onSubmitted: (value) { query(value); },
                      ),
                    ],
                  )
                ),

                // if (result != null) MiniCard(
                //   title: result!.title, 
                //   author: result!.author,
                //   videos: result!.count, 
                //   coverUrl: result!.cover
                // ),

                // const SizedBox(height: 8.0,),

                // Result card
                if (result != null) ExtendCard(
                  title: result!.title, 
                  author: result!.author, 
                  videos: result!.count,
                  coverUrl: result!.cover,
                  onAddToList: onAddToList,
                  infoList: [
                    {"Type": result!.tname}, {"PubAt": formatUnixTime(result!.pubdate)},
                    {"BVID": result!.bvid}, {"AVID": result!.aid.toString()},
                  ],
                )
              ],
            )
          ),
        ),
      ),
      // floatingActionButton: widget.isDesktopMode ? FloatingActionButton.extended(
      //   onPressed: (){},
      //   icon: Icon(Icons.play_arrow_rounded),
      //   label: const Text("Download"),
      // ) : 
      // FloatingActionButton(onPressed: (){}, child: Icon(Icons.play_arrow_rounded),)
    );
  }
}