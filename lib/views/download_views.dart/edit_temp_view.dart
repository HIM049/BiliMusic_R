import 'package:bili_music_r/components/mini_card.dart';
import 'package:bili_music_r/src/rust/api/query.dart';
import 'package:bili_music_r/src/rust/api/task_handler.dart';
import 'package:flutter/material.dart';

class EditTempView extends StatefulWidget {
  final bool isDesktopMode;
  final Function() onBackClicked;
  final Function() onAddToDownload;
  const EditTempView({
    super.key, 
    required this.isDesktopMode,
    required this.onBackClicked,
    required this.onAddToDownload,
  });

  @override
  State<EditTempView> createState() => _CreatTaskView();
}

class _CreatTaskView extends State<EditTempView> {
  VideoInfoFlutter? result;
  bool isWithParts = true;
  List<TempItem> tempQueue = [];
  RangeValues range = RangeValues(1, 1);
  int tempLength = 2;

  Future<void> addToDownload() async {
    await creatTasksFromTemp(options: FilterOptions(
        isWithParts: isWithParts, 
        from: range.start.toInt(),
        to: range.end.toInt(),
      ));
  }

  @override
  void initState() {
    super.initState();

    initValueRange().then((_) {
      getQueue();
    });
  }

  Future<void> initValueRange() async {
    final length = await getTempQueueLength();
    setState(() {
      tempLength = length;
      range = RangeValues(1, tempLength.toDouble());
    });
  }


  Future<void> getQueue() async {
    print("${range.start.toInt()} , ${range.end.toInt()}, $isWithParts");
    final newQueue = await getTempQueue(options: FilterOptions(
        isWithParts: isWithParts, 
        from: range.start.toInt()-1,
        to: range.end.toInt()-1,
      ));
    setState(() {
      tempQueue = newQueue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final queueLength = tempQueue.isNotEmpty ? tempQueue.length : 1;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: widget.onBackClicked, icon: Icon(Icons.arrow_back_rounded)),
        title: const Text("Preview Tasks"),
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
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Preview", style: theme.textTheme.headlineMedium,),
            ),
            // Filters card
            Card.filled(
              clipBehavior: Clip.antiAlias,
              child: Theme(
                data: ThemeData().copyWith(dividerColor: Colors.transparent), 
                child: ExpansionTile(
                  leading: const Icon(Icons.filter_list),
                  title: const Text("Filters"),
                  childrenPadding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                  children: [
                    // Filter chips
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 5.0,
                        children: [
                          FilterChip(
                            label: Text("Parts"),
                            backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
                            selectedColor: Theme.of(context).colorScheme.surfaceTint.withValues(alpha: 0.25),
                            selected: isWithParts,
                            onSelected: (bool selected) {
                              setState(() { isWithParts = selected; });
                              getQueue();
                            },
                          )
                        ],
                      ),
                    ),
                    
                    Row(
                      children: [
                        const Text("Range"),
                        Expanded(
                          child: RangeSlider(
                            values: range,
                            divisions: tempLength-1,
                            min: 1,
                            max: tempLength.toDouble(),
                            onChanged: (RangeValues values) {
                              setState(() { range = values; });
                              getQueue();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            if (tempQueue.isNotEmpty) 
              Expanded(
                child: ListView(
                  children: List.generate(tempQueue.length, (index) => MiniCard(
                      title: tempQueue[index].title, 
                      labels: [tempQueue[index].partTitle],
                      coverUrl: tempQueue[index].coverUrl, 
                      onAddToList: (){}
                    )
                  ),
                ),
              )
            else
              Center(child: const Text("list is empty"))
          ],
        ),
      ),

      floatingActionButton: widget.isDesktopMode ? FloatingActionButton.extended(
        onPressed: addToDownload,
        icon: Icon(Icons.add),
        label: const Text("Create"),
      ) : 
      FloatingActionButton(onPressed: addToDownload, child: Icon(Icons.add),)
    );
  }
}