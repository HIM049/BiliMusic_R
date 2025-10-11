import 'package:flutter/material.dart';

class MiniCard extends StatelessWidget {
  final String title;
  final String author;
  final int videos;
  final String coverUrl;
  final Function() onAddToList;

  const MiniCard({
    super.key,
    required this.title,
    required this.author,
    required this.videos,
    required this.coverUrl,
    required this.onAddToList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = constraints.maxWidth.isFinite
                  ? constraints.maxWidth
                  : MediaQuery.of(context).size.width;
              final imageSize = (maxWidth * 0.3).clamp(80.0, 160.0);

              return SizedBox(
                height: imageSize,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      child: SizedBox(
                        width: imageSize,
                        height: imageSize,
                        child: Image.network(
                          coverUrl,
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
                              title,
                              style: Theme.of(context).textTheme.titleMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              author,
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "Videos: $videos",
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 1,
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
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz_rounded)),
            // const SizedBox(width: 8),
            TextButton.icon(onPressed: onAddToList, label: Text("TO LIST"), icon: Icon(Icons.add),),
          ],
        ),
      ],
    );
  }
}