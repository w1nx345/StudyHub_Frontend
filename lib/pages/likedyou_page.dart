import 'package:flutter/material.dart';
import 'package:learn_hub/pages/filter_page.dart';
import 'package:learn_hub/pages/profile_page.dart';
import 'package:learn_hub/pages/chatlist_page.dart';
import 'package:learn_hub/pages/search_page.dart';
import 'package:learn_hub/pages/settings_page.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class LikedYouPage extends StatefulWidget {
  const LikedYouPage({super.key});

  @override
  State<LikedYouPage> createState() => _LikedYouPageState();
}

class _LikedYouPageState extends State<LikedYouPage> {
  List<Map<String, dynamic>> allUsers = []; // buat menampung semua data user yang diambil dari database
  List<Map<String, dynamic>> filteredUsers = []; // menampung data user yang sudah di filter berdasarkan preferensi kita
  List<Map<String, dynamic>> viewedUsers = []; // nampung user yang sudah di view / dipilih
  bool isLoading = true;
  final storage = const FlutterSecureStorage();
  String? userId; // nampung id si user

  @override
  void initState() {
    super.initState();
    fetchAllUser();
  }

  Future<void> fetchAllUser() async { // function buat http post request buat ngambil semua data user
    userId = await storage.read(key: 'id');
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/liked/liked-you/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'id': userId,
      }),
    );
    if (response.statusCode == 200){
      print(jsonDecode(response.body)); // buat cek apakah udh berhasil, jangan lupa diapus
      List<dynamic> data = jsonDecode(response.body);
      setState(() {
        allUsers = data.map((user) => user as Map<String, dynamic>).toList();
        isLoading = false;
      });
    } else if(response.statusCode == 404){
      isLoading = false;
      print("No one likes you");
    }
  }


  Future<void> MatchUser(String likedId, String pilihan) async{
    final likerId = await storage.read(key: "id");
    final response = await http.post(Uri.parse('http://10.0.2.2:8000/match/decision/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'match': pilihan,
        'from_user': likerId,
        'to_user': likedId
      }),
    );
    if (response.statusCode == 201){
      throw Exception('Liked the user!');
    }else{
      throw Exception('Not like the user :(');
    }
  }

  int _selectedIndex = 1; // Initial index of the BottomNavigationBar
  final CardSwiperController controller = CardSwiperController(); // controller buat swipe card

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ChatListPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SettingsPage()),
      );
    } else if (index == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SearchPage())
      );
    }

    setState(() {
      _selectedIndex = index;
    });
  }
  int indexCurrent = 0;
  void _handleSwipe(CardSwiperDirection direction, String likedId) {
    setState(() {
      if (filteredUsers.isNotEmpty) {
        final user = filteredUsers.removeAt(0);
        viewedUsers.add(user);
        allUsers.removeWhere((u) => u['id'] == user['id']);
      } else if (allUsers.isNotEmpty) {
        final user = allUsers.removeAt(indexCurrent);
        viewedUsers.add(user);
      }
      if (indexCurrent >= allUsers.length) {
        indexCurrent = allUsers.length - 1;
      }
    });
    if (direction == CardSwiperDirection.right) {
      const pilihan = 'Match';
      MatchUser(likedId.toString(), pilihan);
    }
    if (direction == CardSwiperDirection.left){
      const pilihan = 'Not Match';
      MatchUser(likedId.toString(), pilihan);
    }
  }

  ImageProvider _imageFromFilePath(String? filePath) { // buat nentuin apakah si user ini punya path untuk profile picture atau tidak
    if (filePath == null) { //user ga punya profile picture, jadi pake default
      return const NetworkImage('https://cdn.pixabay.com/photo/2023/08/24/19/58/saitama-8211499_1280.png');
    } else {
      return NetworkImage('http://10.0.2.2:8000/$filePath'); // ngambil profile picture si user
    }
  }
  // widget nya
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          :(allUsers.isEmpty && filteredUsers.isEmpty)? const Center(child: Text('Sorry that is all :)'))
          : Stack(
        children: [
          CardSwiper( // card nya
            controller: controller,
            isDisabled: true,
            cardsCount: filteredUsers.isEmpty ? allUsers.length : filteredUsers.length, // card berdasarkan banyaknya alluser atau filtered user
            numberOfCardsDisplayed: 1,
            cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
              final user = filteredUsers.isEmpty ? allUsers[index] : filteredUsers[index]; // ini cek filteredUser empty atau ngga
              // kalo empty jadi tampilin allUser kalo ngga tampilin filteredUser
              final profilePicturePath = user['profilePicture']; // ngambil path profile picture yang diambil dari backend/database
              final image = _imageFromFilePath(profilePicturePath); // jalanin fungsi _imageFromFilePath
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: image,
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack( // stack cardnya
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF00796B),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(
                              user['first_name'] ?? '',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                            ),
                            subtitle: Text(
                              'Gender: ${user['gender'] ?? ''} \nLocation: ${user['location'] ?? ''} '
                                  '\nRole: ${user['role'] ?? ''} \nBio: ${user['bio'] ?? ''} \nLearning Type: ${user['learningType'] ?? ''} '
                                  '\nStudy Place: ${user['studyPlace'] ?? ''} \nAcademic Level: ${user['academicLevel'] ?? ''}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: 220,
            right: 20,
            child: FloatingActionButton( // button like
              onPressed: () {
                if (filteredUsers.isNotEmpty) { // kalo ga empty, berarti yg dilike yg di filteredUsers
                  _handleSwipe(CardSwiperDirection.right, filteredUsers[0]['id'].toString());
                } else if (allUsers.isNotEmpty) { // yang dilike yang di allUsers
                  _handleSwipe(CardSwiperDirection.right, allUsers[indexCurrent]['id'].toString());
                }
              },
              backgroundColor: Colors.green,
              child: const Icon(Icons.thumb_up, color: Colors.white),
            ),
          ),
          Positioned(
            bottom: 220,
            left: 20,
            child: FloatingActionButton( // button dislike
              onPressed: () {
                if (filteredUsers.isNotEmpty) { // ga ngaruh tapi harus begini biar ga error
                  _handleSwipe(CardSwiperDirection.left, filteredUsers[0]['id'].toString());
                } else if (allUsers.isNotEmpty) { // ga ngaruh apa-apa tapi harus beigni biar ga error
                  _handleSwipe(CardSwiperDirection.left, allUsers[indexCurrent]['id'].toString());
                }
              },
              backgroundColor: Colors.red,
              child: const Icon(Icons.thumb_down_rounded, color: Colors.white),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text(
          "Liked You",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.w800,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context, MaterialPageRoute(builder: (context) => const ProfilePageContent()),
              );
            },
            child: const CircleAvatar(
              backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2023/08/24/19/58/saitama-8211499_1280.png'),
              radius: 30,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.filter_alt_rounded, color: Colors.white),
            onPressed: (){
              Navigator.push(
                context, MaterialPageRoute(builder: (context) => const FilterPage()),
              );
            },
          ),
        ],
        backgroundColor: const Color(0xFF00796B),
      ),
      backgroundColor: const Color(0xFF009688),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF00796B),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat, color: Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Colors.white),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}