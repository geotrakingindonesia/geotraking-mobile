// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TutorialTile extends StatefulWidget {
  final String title;
  final String? videoUrl;
  const TutorialTile({
    Key? key,
    required this.title,
    this.videoUrl,
  }) : super(key: key);

  @override
  _TutorialTileState createState() => _TutorialTileState();
}

class _TutorialTileState extends State<TutorialTile> {
  bool _isExpanded = false;
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.videoUrl != null) {
      _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl!)!,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 98, 182, 183),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.title,
              style: TextStyle(color: Colors.white),
            ),
            trailing: IconButton(
              icon:
                  Icon(_isExpanded ? Icons.arrow_upward : Icons.arrow_downward),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
          if (_isExpanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: _controller != null
                  ? YoutubePlayer(
                      controller: _controller!,
                      showVideoProgressIndicator: true,
                    )
                  : const Text(
                      'Video tidak tersedia.',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
            ),
        ],
      ),
    );
  }
}