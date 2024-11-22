import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Review {
  final String title;
  final String description;
  final int rating;
  final String imagePath;
  bool isPublic;

  Review({
    required this.title,
    required this.description,
    required this.rating,
    required this.imagePath,
    this.isPublic = true,
  });
}

class ReviewForm extends StatefulWidget {
  final Function(Review) onSubmit;
  final Review? existingReview;

  const ReviewForm({
    Key? key,
    required this.onSubmit,
    this.existingReview,
  }) : super(key: key);

  @override
  _ReviewFormState createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  double _rating = 1.0;

  @override
  void initState() {
    super.initState();

    if (widget.existingReview != null) {
      _titleController.text = widget.existingReview!.title;
      _descriptionController.text = widget.existingReview!.description;
      _rating = widget.existingReview!.rating.toDouble();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black.withOpacity(0.6),
      title: Text(
        widget.existingReview == null ? 'Adicionar Review' : 'Editar Review',
        style: const TextStyle(color: Colors.white),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Título do Filme',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 121, 42, 84)),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descrição',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 121, 42, 84)),
                ),
              ),
              style: const TextStyle(color: Colors.white),
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemSize: 30,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.redAccent,
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
          child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
        ),
        ElevatedButton(
          onPressed: () {
            if (_titleController.text.isNotEmpty &&
                _descriptionController.text.isNotEmpty) {
              final review = Review(
                title: _titleController.text,
                description: _descriptionController.text,
                imagePath: widget.existingReview?.imagePath ??
                    'assets/new_movie.jpg',
                rating: _rating.toInt(),
                isPublic: widget.existingReview?.isPublic ?? true,
              );

              widget.onSubmit(review);
              Navigator.of(context).pop();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 121, 42, 84),
          ),
          child: Text(
            widget.existingReview == null ? "Salvar" : "Atualizar",
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
