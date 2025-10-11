import 'package:flutter/material.dart';

class ExtendCard extends StatelessWidget {
  final String title;
  final String author;
  final String coverUrl;
  final int videos;
  final Function() onAddToList;

  final List<Map<String, String>> infoList;

  const ExtendCard({
    super.key,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.videos,
    required this.onAddToList,
    this.infoList = const [],
  });

  @override
  Widget build(BuildContext context) {
    // details builder
    List<Widget> infoRows = [];
    for (int i = 0; i < infoList.length; i += 2) {
      infoRows.add(
        Row(
          children: [
            Expanded(
              child: Text(
                '${infoList[i].keys.first}: ${infoList[i].values.first}',
              ),
            ),
            if (i + 1 < infoList.length)
              Expanded(
                child: Text(
                  '${infoList[i + 1].keys.first}: ${infoList[i + 1].values.first}',
                ),
              ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // cover and labels
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // video cover
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        coverUrl,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    // labels
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: Theme.of(context).textTheme.titleMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 4),
                          Text(author, maxLines: 1, overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 4),
                          Text('Videos: $videos', maxLines: 1, overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                  ],
                ),
                if (infoList.isNotEmpty) const SizedBox(height: 12),
                // details
                ...infoRows,
              ],
            ),
          ),
        ),
        // action button
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz_rounded)),
            // const SizedBox(width: 8),
            TextButton.icon(
              onPressed: onAddToList, 
              label: Text("TO LIST"), 
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}