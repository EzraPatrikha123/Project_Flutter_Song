import 'package:flutter/material.dart';
import 'package:project_flutter/views/song_list_page.dart';

class PlaylistCard extends StatelessWidget {
  final String? name;
  final int? songCount;
  final String playlistId;
  final VoidCallback? onTap;

  PlaylistCard({
    super.key,
    required this.name,
    required this.songCount,
    required this.playlistId,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap ?? () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => SongListPage(
            playlistId: playlistId, 
            playlistName: name ?? 'Unknown Playlist'),
              ),
            );
        },
        borderRadius: BorderRadius.circular(4),
        child: Padding(padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name ?? 'Unknown Playlist',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold
          ),
          ),
          SizedBox(height: 8),
          Text('Song Count: $songCount',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600]
          ),
          ),
        ],
      ),
      ),
      )
    );
  }
}