import 'package:flutter/material.dart';
import 'package:learn_hub/pages/filter_page.dart';
import 'package:learn_hub/pages/profile_page.dart';
import 'package:learn_hub/pages/chatlist_page.dart';
import 'package:learn_hub/pages/settings_page.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:http/http.dart' as http;
import 'package:learn_hub/users/users_model.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io';
class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<String, dynamic>> allUsers = []; // buat menampung semua data user yang diambil dari database
  List<Map<String, dynamic>> filteredUsers = []; // menampung data user yang sudah di filter berdasarkan preferensi kita
  bool isLoading = true;
  final storage = const FlutterSecureStorage();
  String? userId; // nampung id si user

  @override
  void initState() {
    super.initState();
    fetchAllUser();
  }

  Future<void> fetchAllUser() async { // function buat http get request buat ngambil semua data user
    userId = await storage.read(key: 'id');
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/search/'),
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
        filterUsers();
      });
    } else{
      throw Exception('Failed to load users');
    }
  }

  Future<void> filterUsers() async{ // fungsi filter user berdasarkan preferensi
    SharedPreferences prefs = await SharedPreferences.getInstance(); // ngambil data preferensi si user dari local storage terus dimasukin ke setiap variable
    String preferredGender = prefs.getString('gender') ?? '';
    String preferredMatkul = prefs.getString('matkul') ?? '';
    String preferredRole = prefs.getString('role') ?? '';
    String preferredAcademicLevel = prefs.getString('academicLevel') ?? '';
    String preferredStudyPlace = prefs.getString('studyPlace') ?? '';
    String preferredLearningType = prefs.getString('learningType') ?? '';
    setState(() {
      filteredUsers = allUsers.where((user) {
        bool matchesGender = user['gender'] == preferredGender || preferredGender.isEmpty || user['gender'] == null;
        bool matchesRole = user['role'] == preferredRole || preferredRole.isEmpty || user['role'] == null;
        bool matchesAcademicLevel = user['academicLevel'] == preferredAcademicLevel || preferredAcademicLevel.isEmpty || user['academicLevel'] == null;
        bool matchesStudyPlace = user['studyPlace'] == preferredStudyPlace || preferredStudyPlace.isEmpty || user['studyPlace'] == null;
        bool matchesLearningType = user['learningType'] == preferredLearningType || preferredLearningType.isEmpty || user['learningType'] == null;
        bool matchesMatkul = user['matkul'] == preferredMatkul || preferredMatkul.isEmpty || user['matkul'] == null;
        return matchesGender && matchesRole && matchesAcademicLevel && matchesStudyPlace && matchesLearningType && matchesMatkul;
      }).toList();
      print('Filtered users: $filteredUsers');
    });
  }

  Future<void> likeUser() async{
    final likerId = await storage.read(key: "id");
  }

  int _selectedIndex = 1; // Initial index of the BottomNavigationBar
  final CardSwiperController controller = CardSwiperController(); // controller buat swipe card

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChatListPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SettingsPage()),
      );
    } else if (index == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchPage())
      );
    }

    setState(() {
      _selectedIndex = index;
    });
  }
  void _handleSwipe() {
    setState(() {
      if (filteredUsers.isNotEmpty) {
        filteredUsers.removeAt(0); // remove data user yang dipilih// jika setelah user di-remove list filteredUsers kosong,// maka ganti list ke all
      } else {
        if (allUsers.isNotEmpty) {
          allUsers.removeAt(0);
        }
      }
    });
  }
  ImageProvider _imageFromFilePath(String? filePath) { // buat nentuin apakah si user ini punya path untuk profile picture atau tidak
    if (filePath == null) { //user ga punya profile picture, jadi pake default
      return NetworkImage('https://cdn.pixabay.com/photo/2023/08/24/19/58/saitama-8211499_1280.png');
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
          :allUsers.isEmpty ? const Center(child: Text('No users found'))
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
            controller.swipe(CardSwiperDirection.right);
            _handleSwipe();
          },
          child: Icon(Icons.thumb_up, color: Colors.white),
          backgroundColor: Colors.green,
        ),
      ),
      Positioned(
        bottom: 220,
        left: 20,
        child: FloatingActionButton( // button dislike
          onPressed: () {
            controller.swipe(CardSwiperDirection.left);
            _handleSwipe();
          },
          child: Icon(Icons.thumb_down_rounded, color: Colors.white),
          backgroundColor: Colors.red,
          ),
        ),
        ],
      ),
      appBar: AppBar(
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
                context, MaterialPageRoute(builder: (context) => FilterPage()),
              );
            },
          ),
        ],
        backgroundColor: const Color(0xFF00796B),
      ),
      backgroundColor: Color(0xFF009688),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF00796B),
        items: [
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