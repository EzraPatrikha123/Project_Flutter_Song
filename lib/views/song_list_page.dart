import 'package:flutter/material.dart';
import 'package:project_flutter/models/song_model.dart';
import 'package:project_flutter/services/song_services.dart';
import 'package:project_flutter/views/song_detail_page.dart';

class SongListPage extends StatefulWidget {
  final String playlistId;
  final String playlistName;

  const SongListPage({
    super.key,
    required this.playlistId,
    required this.playlistName,
  });

  @override
  State<SongListPage> createState() => _SongListPageState();
}

class _SongListPageState extends State<SongListPage> {
  late Future<List<Song>> futureSongs;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    futureSongs = SongService.fetchSongsByPlaylist(widget.playlistId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.playlistName),
      ),
      body: FutureBuilder<List<Song>>(
        future: futureSongs,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final songs = snapshot.data!;

          return ListView.builder(
            itemCount: songs.length,
            itemBuilder: (context, index) {
              final song = songs[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: Image.network(
                    song.thumbnail,
                    width: 50,
                    height: 50,
                    errorBuilder: (_, __, ___) => const Icon(Icons.music_note),
                  ),
                  title: Text(song.title),
                  subtitle: Text(song.artist),
                  trailing: Text('${song.likes} likes'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (_) => SongDetailPage(songId: song.uuid)
                    ));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}