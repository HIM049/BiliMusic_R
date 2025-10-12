
import 'package:bili_music_r/views/download_views.dart/edit_temp_view.dart';
import 'package:bili_music_r/views/download_views.dart/query_task_view.dart';
import 'package:bili_music_r/views/download_views.dart/queue_view.dart';
import 'package:flutter/material.dart';

class DownloadView extends StatefulWidget {
  final bool isDesktopMode;
  const DownloadView({super.key, required this.isDesktopMode});

  @override
  State<DownloadView> createState() => _DownloadView();
}

class _DownloadView extends State<DownloadView> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    switch (pageIndex) {
      case 0: return QueueView(
        isDesktopMode: widget.isDesktopMode,
        onCreatTaskClicked: () => setState(() { pageIndex++; }),
      );
      case 1: return QueryTaskView(
        isDesktopMode: widget.isDesktopMode,
        onBackClicked: () => setState(() { pageIndex--; }),
        onAddListClicked: () => setState(() { pageIndex++; }),
      );
      case 2: return EditTempView(
        isDesktopMode: widget.isDesktopMode, 
        onBackClicked: () => setState(() { pageIndex--; }),
        onAddToDownload: () => setState(() { pageIndex = 0; }),
      );
      default: return Scaffold(body: Center(child: Text("error")));
    }
  }
}