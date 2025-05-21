import 'package:flutter/material.dart';
import 'package:project_flutter/models/user_login.dart';
import 'package:project_flutter/services/Homepage/playlist_service.dart';
import 'package:project_flutter/services/Homepage/userdata.dart';
import 'package:project_flutter/widgets/bottombar.dart';
import 'package:project_flutter/widgets/homepage/playlist_card.dart';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserLogin userLogin = UserLogin();
  String? username;
  String? email;
  bool isLoading = false;
  String errorMessage = '';
  List<Playlist> playlist = [];
  
  @override
  void initState() {
    super.initState();
    _loadUserData();
    _fetchPlaylist();
  }

  Future<void> _loadUserData() async{
    final user = await AuthService.loadUserFromPrefs();
    setState(() {
      isLoading = false;
      if (user != null) {
        userLogin = user;
        username = user.username;
        email = user.email;
      }
    });
  }

  Future<void> _fetchPlaylist() async{
    
    setState(() => isLoading = true);
    try {
      final fetchedPlaylist = await PlaylistService.fetchPlaylists();
      setState(() => playlist = fetchedPlaylist);
    } catch (e) {
      setState(() => errorMessage = e.toString());
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(),),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Song Playlist'),
        backgroundColor: Colors.blue[300],
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 5),
                child: Column(
                  children: [
                    Text('Username: $username'),
                    Text("Email: $email")
                  ],
                ), //Column untuk nama dan email dahulu
              ), //Container untuk nama dan email
              if(errorMessage.isNotEmpty)
              Padding(padding: EdgeInsets.all(16),
              child: Text('Error: $errorMessage', style: TextStyle(color: Colors.red))), //Padding untuk teks error

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: playlist.map((item) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: PlaylistCard(
                    name:item.namaplaylist ?? 'Unknown Playlist', 
                    songCount: item.nomerlagu ?? 0,
                    playlistId: item.uuid,
                    ),
                    )
                    ).toList(),
                ),
              )
            ],
          ), //Column badan
        ), //Container badan
      ),
      bottomNavigationBar: BottomNav(0),
    );
  }
}

