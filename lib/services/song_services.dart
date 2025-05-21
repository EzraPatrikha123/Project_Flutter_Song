import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_flutter/models/song_model.dart';

class SongService {
  static Future<List<Song>> fetchSongsByPlaylist(String playlistId) async {
    final url = 'https://learn.smktelkom-mlg.sch.id/ukl2/playlists/song-list/$playlistId';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        return (data['data'] as List)
            .map((song) => Song.fromJson(song))
            .toList();
      }
    }
    throw Exception('Failed to load songs');
  }
}