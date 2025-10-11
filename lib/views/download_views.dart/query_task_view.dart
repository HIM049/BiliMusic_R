
import 'package:flutter/material.dart';
import 'package:bili_music_r/src/rust/api/simple.dart';

class QueryTaskView extends StatefulWidget {
  final bool isDesktopMode;
  final Function() onBackClicked;
  const QueryTaskView({
    super.key, 
    required this.isDesktopMode,
    required this.onBackClicked,
  });

  @override
  State<QueryTaskView> createState() => _CreatTaskView();
}

class _CreatTaskView extends State<QueryTaskView> {
  VideoInfoFlutter? result;

  Future<void> callRustAsync(String bvid) async {
    final video = await queryBiliInfo(input: bvid);
    setState(() {
      result = video;
    });
    // TODO: Loading animate, error check
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
            height: 300,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Query", style: theme.textTheme.headlineLarge,),
                ),

                Container(
                  child: Column(
                    children: [
                      SearchBar(
                        hintText: 'Type your video id',
                        // textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 16)),
                        elevation: WidgetStatePropertyAll(0),
                        leading: const Icon(Icons.search),
                        onSubmitted: (value) { callRustAsync(value); },
                      ),
                    ],
                  )
                ),

                if (result != null) Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  // color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final maxWidth = constraints.maxWidth.isFinite
                          ? constraints.maxWidth
                          : MediaQuery.of(context).size.width;
                      final imageSize = (maxWidth * 0.28).clamp(80.0, 160.0);

                      return SizedBox(
                        height: imageSize,
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                              ),
                              child: SizedBox(
                                width: imageSize,
                                height: imageSize,
                                child: Image.network(
                                  result!.cover,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      result!.title,
                                      style: Theme.of(context).textTheme.titleMedium,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Author: ${result!.author}",
                                      style: Theme.of(context).textTheme.bodyMedium,
                                      // maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
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