import 'package:flutter/material.dart';
import 'package:starlitfilms/components/review_form.dart';
import 'package:starlitfilms/components/slide.dart';
import 'package:starlitfilms/components/styles.dart';
import 'package:starlitfilms/screens/perfil.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  List<Review> userReviews = [];

  void _showReviewForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ReviewForm(
          onSubmit: (review) {
            setState(() {
              userReviews.add(review);
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 61, 25, 66),
        toolbarHeight: 90.0,
        elevation: 50,
        shadowColor: const Color(0xFF0000),
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.20),
                      blurRadius: 12,
                      spreadRadius: 1,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/logoSmall.png',
                  height: 50.0,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Colors.deepPurple, size: 45),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'type to search',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/homeFundo.png'),
            fit: BoxFit.cover,
          ),
        ),
            child: Column(
              children: [
                const Slide(),
                const Divider(), 
                Container(
                  child: Text(
                      "DESTAQUES",
                      style: txtSans(20, Colors.white),
                )),
                Expanded(
                  child: ListView.builder(
                    itemCount: userReviews.length,
                    itemBuilder: (context, index) {
                      return _buildCard(userReviews[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
          Scaffold(
            backgroundColor: Colors.deepPurple[800],
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/homeFundo.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: userReviews.length,
                        itemBuilder: (context, index) {
                          return _buildCard(userReviews[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _showReviewForm,
              backgroundColor: const Color.fromARGB(255, 61, 25, 66),
              child: const Icon(Icons.add, size: 40, color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
            ),
          ),
          const Perfil(), 
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 143, 44, 59),
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: selectedIndex,
        iconSize: 80,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30, color: Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu, size: 30, color: Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30, color: Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat, size: 30, color: Colors.white),
            label: '',
          ),
        ],
        selectedIconTheme: const IconThemeData(size: 60),
        unselectedIconTheme: const IconThemeData(size: 50),
      ),
    );
  }

  Widget _buildCard(Review review) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10,10,10,0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  review.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    index < review.rating ? Icons.star : Icons.star_border,
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            review.description,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.visibility, color: Colors.white),
              const SizedBox(width: 10),
              CircleAvatar(backgroundImage: AssetImage(review.imagePath)),
              const SizedBox(width: 10),
              CircleAvatar(backgroundImage: AssetImage(review.imagePath)),
              const SizedBox(width: 10),
              CircleAvatar(backgroundImage: AssetImage(review.imagePath)),
            ],
          ),
        ],
      ),
    );
  }
}
