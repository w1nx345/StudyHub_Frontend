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
  class SearchPage extends StatefulWidget {
    @override
    State<SearchPage> createState() => _SearchPageState();
  }

  class _SearchPageState extends State<SearchPage> {
    List<Map<String, dynamic>> allUsers = []; // buat menampung semua data user yang diambil dari database
    List<Map<String, dynamic>> filteredUsers = []; // menampung data user yang sudah di filter berdasarkan preferensi kita
    bool isLoading = true;

    @override
    void initState() {
      super.initState();
      fetchAllUser();
    }

    Future<void> fetchAllUser() async { // function buat http get request buat ngambil semua data user
      final response = await http.get(Uri.parse('http://10.0.2.2:8000/search/'));
      if (response.statusCode == 200){
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

    Future<void> filterUsers() async{
      SharedPreferences prefs = await SharedPreferences.getInstance(); // ngambil data preferensi si user dari local storage terus dimasukin ke setiap variable
      String preferredGender = prefs.getString('gender') ?? '';
      String preferredLocation = prefs.getString('location') ?? '';
      String preferredMatkul = prefs.getString('matkul') ?? '';
      String preferredRole = prefs.getString('role') ?? '';
      String preferredAcademicLevel = prefs.getString('academicLevel') ?? '';
      String preferredStudyPlace = prefs.getString('studyPlace') ?? '';
      String preferredLearningType = prefs.getString('learningType') ?? '';

      setState(() {
        filteredUsers = allUsers.where((user) {
          bool matchesGender = preferredGender.isEmpty || user['gender'] == preferredGender;
          bool matchesLocation = preferredLocation.isEmpty || user['location'] == preferredLocation;
          bool matchesRole = preferredRole.isEmpty || user['role'] == preferredRole;
          bool matchesAcademicLevel = preferredAcademicLevel.isEmpty || user['academicLevel'] == preferredAcademicLevel;
          bool matchesStudyPlace = preferredStudyPlace.isEmpty || user['studyPlace'] == preferredStudyPlace;
          bool matchesLearningType = preferredLearningType.isEmpty || user['learningType'] == preferredLearningType;
          bool matchesMatkul = preferredMatkul.isEmpty || user['matkul'] == preferredMatkul;

          return matchesGender && matchesLocation && matchesRole && matchesAcademicLevel && matchesStudyPlace && matchesLearningType && matchesMatkul;
        }).toList();
        if (filteredUsers.isEmpty){
          filteredUsers = allUsers;
        }
        setState(() {
          filteredUsers = filteredUsers;
        });
      });

    }

    int _selectedIndex = 1; // Initial index of the BottomNavigationBar
    bool _showLikeIcon = false;
    bool _showDislikeIcon = false;
    final CardSwiperController controller = CardSwiperController();

    void _onItemTapped(int index) {
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatListPage()),
        );
      } else if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsPage()),
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

    void _showPopupIcon(bool isLike) {
      setState(() {
        if (isLike) {
          _showLikeIcon = true;
          _showDislikeIcon = false;
        } else {
          _showLikeIcon = false;
          _showDislikeIcon = true;
        }
      });

      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _showLikeIcon = false;
          _showDislikeIcon = false;
        });
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : filteredUsers.isEmpty
            ? Center(child: Text("No users found matching your preferences."))
            : Stack(
          children: [
            CardSwiper( // card nya
              controller: controller,
              cardsCount: filteredUsers.length,
              cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                final user = filteredUsers[index];
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: NetworkImage(user['imageUrl']),
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
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(
                                user['first_name'],
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                              ),
                              subtitle: Text(
                                'Gender: ${user['gender']} \nLocation: ${user['location']} \nRole: ${user['role']} \nBio: ${user['bio']} \nLearning Type: ${user['learningType']} \nStudy Place: ${user['studyPlace']} \nAcademic Level: ${user['academicLevel']}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              onSwipe: (index, direction, _) async {
                if (direction == CardSwiperDirection.right) {
                  _showPopupIcon(true);
                } else if (direction == CardSwiperDirection.left) {
                  _showPopupIcon(false);
                }
                return true;
              },
            ),
            if (_showLikeIcon)
              Center(
                child: Icon(
                  Icons.thumb_up,
                  color: Colors.green,
                  size: 100,
                ),
              ),
            if (_showDislikeIcon)
              Center(
                child: Icon(
                  Icons.thumb_down,
                  color: Colors.red,
                  size: 100,
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
                  context, MaterialPageRoute(builder: (context) => ProfilePageContent()),
                );
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2023/08/24/19/58/saitama-8211499_1280.png'),
                radius: 30,
              ),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.filter_alt_rounded, color: Colors.white),
              onPressed: (){
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => FilterPage()),
                );
              },
            ),
          ],
          backgroundColor: Color(0xFF00796B),
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
