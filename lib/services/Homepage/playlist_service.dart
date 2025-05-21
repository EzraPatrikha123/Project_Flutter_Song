import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_flutter/services/url.dart';

class Playlist {
  final String uuid;
  final String? namaplaylist;
  final int? nomerlagu;

  Playlist({
    required this.uuid,
    required this.namaplaylist,
    required this.nomerlagu,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      uuid: json['uuid'],
      namaplaylist: json['playlist_name'],
      nomerlagu: json['song_count'],
    );
  }
}

class PlaylistService {
  static String _SongUrl = 'https://learn.smktelkom-mlg.sch.id/ukl2/playlists';

  static Future<List<Playlist>> fetchPlaylists() async{
    try {
      final response = await http.get(Uri.parse(_SongUrl));
      print('API Response ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return (data['data'] as List).map((item) => Playlist(
            uuid: item['uuid'] as String? ?? '', 
            namaplaylist: item['playlist_name'] as String? ?? 'Unknown Playlist', 
            nomerlagu: item['song_count'] as int? ?? 0)).toList();
        }
      }
      throw Exception('Failed to load playlist');
    } catch (e) {
      print('Error fetching playlist: $e');
      rethrow;
    }
    }
  }