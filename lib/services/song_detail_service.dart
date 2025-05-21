import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_flutter/models/song_detail_model.dart';

class SongService {
  static Future<SongDetail> fetchSongDetail(String songId) async {
    final url = 'https://learn.smktelkom-mlg.sch.id/ukl2/playlists/song/$songId';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        return SongDetail.fromJson(data['data']);
      }
    }
    throw Exception('Failed to load song details');
  }
}