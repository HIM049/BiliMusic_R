
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableItem extends StatelessWidget {
  final Widget Function(BuildContext) listItemBuilder;
  final Function(BuildContext) deleteClicked;
  const SlidableItem({
    super.key, 
    required this.listItemBuilder,
    required this.deleteClicked,
  });

  @override
  Widget build(BuildContext context) {
    // final colorScheme = Theme.of(context).colorScheme;
    
    return Slidable(
      startActionPane: ActionPane(
        motion: BehindMotion(), 
        extentRatio: 0.25,
        children: [
          SlidableAction(
            onPressed: deleteClicked,
            backgroundColor: Colors.redAccent,
            icon: Icons.delete,
            label: "Delete",
          ),
          // SlidableAction(
          //   onPressed: editClicked,
          //   backgroundColor: colorScheme.secondary,
          //   icon: Icons.edit,
          //   label: "Edit",
          // )
        ]
        ),
      child: Builder(
        builder: (innerContext) => listItemBuilder(innerContext),
      ),
    );
  }
}