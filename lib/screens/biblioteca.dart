import 'package:flutter/material.dart';

class Review {
  final String title;
  final String description;
  final String imagePath;
  final int rating;

  Review({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.rating,
  });
}

class Biblioteca extends StatefulWidget {
  const Biblioteca({Key? key}) : super(key: key);

  @override
  _BibliotecaState createState() => _BibliotecaState();
}

class _BibliotecaState extends State<Biblioteca> {
  List<Review> userReviews = [];

  void addReview() {
    setState(() {
      userReviews.add(
        Review(
          title: 'Novo Filme',
          description: 'Descrição do novo filme...',
          imagePath: 'assets/new_movie.jpg',
          rating: 4,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[800],
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 64, 29, 69),
              Color.fromARGB(255, 134, 39, 54),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: addReview,
                child: const Text('Adicionar Review'),
              ),
              const SizedBox(height: 20),
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

    );
  }

  Widget _buildCard(Review review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.deepPurple[700],
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
