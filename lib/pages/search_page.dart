  import 'package:flutter/material.dart';
  import 'package:learn_hub/pages/filter_page.dart';
  import 'package:learn_hub/pages/profile_page.dart';
  import 'package:learn_hub/pages/chatlist_page.dart';
  import 'package:learn_hub/pages/settings_page.dart';
  import 'package:flutter_card_swiper/flutter_card_swiper.dart';

  class SearchPage extends StatefulWidget {
    @override
    State<SearchPage> createState() => _SearchPageState();
  }

  class _SearchPageState extends State<SearchPage> {
    List<Widget> cards = [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage('https://upload.wikimedia.org/wikipedia/id/6/6b/Frierencharacter.png'), // Your image URL here
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5), // Black transparent background
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(8.0), // Add padding here
                  child: ListTile(
                    title: Text('Frieren', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800,)), // Adjust text color if needed
                    subtitle: Text('Gender: Female \nLocation: Ngawi  \nRole: Someone To Teach \nBio: Mencari Pahlawan Gacor \nLearning Type: Naturalistic Learner \nStudy Place: Park  \nAcademic Level: Doctorate', style: TextStyle(color: Colors.white)), // Adjust text color if needed
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage('https://static.wikia.nocookie.net/onepunchman/images/5/5b/Genos_Profile.png'), // Your image URL here
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5), // Black transparent background
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(8.0), // Add padding here
                  child: ListTile(
                    title: Text('Genos', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800,)), // Adjust text color if needed
                    subtitle: Text('Gender: Male \nLocation: Tegal  \nRole: Someone To Learn \nBio: nyari guru bertarung nih \nLearning Type: Visual Learner \nStudy Place: Cafe  \nAcademic Level: Master', style: TextStyle(color: Colors.white)), // Adjust text color if needed
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage('https://static.wikia.nocookie.net/naruto/images/8/82/Obito_Second_Transformation.png'), // Your image URL here
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5), // Black transparent background
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(8.0), // Add padding here
                  child: ListTile(
                    title: Text('Obito', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800,)), // Adjust text color if needed
                    subtitle: Text('Gender: Male \nLocation: Jakarta Barat  \nRole: A Study Mate \nBio: butuh teman belajar bang \nLearning Type: Read/Write Learner \nStudy Place: Call  \nAcademic Level: Undergraduate', style: TextStyle(color: Colors.white)), // Adjust text color if needed
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // Add more cards as needed
    ];

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
        body: Stack(
          children: [
            CardSwiper(
              controller: controller,
              cardsCount: cards.length,
              cardBuilder: (context, index, percentThresholdX, percentThresholdY) => cards[index],
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
