import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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

class ReviewForm extends StatefulWidget {
  final Function(Review) onSubmit;

  const ReviewForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _ReviewFormState createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  double _rating = 1.0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adicionar Review'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Título do Filme'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descrição'),
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            RatingBar.builder(
              initialRating: 1,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemSize: 30,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_titleController.text.isNotEmpty &&
                _descriptionController.text.isNotEmpty) {
              widget.onSubmit(
                Review(
                  title: _titleController.text,
                  description: _descriptionController.text,
                  imagePath: 'assets/new_movie.jpg', 
                  rating: _rating.toInt(),
                ),
              );
              Navigator.of(context).pop();
            }
          },
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}
