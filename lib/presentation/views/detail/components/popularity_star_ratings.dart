import 'package:flutter/material.dart';

class PopularityStarRating extends StatelessWidget {
  final double popularity;

  const PopularityStarRating({super.key, required this.popularity});

  @override
  Widget build(BuildContext context) {
    // Map the popularity score to a star rating scale
    double rating = popularity / 500; // Adjust the scale as needed

    // Ensure rating is between 0 and 5
    rating = rating.clamp(0.0, 5.0);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return const Icon(Icons.star, color: Colors.yellow);
        } else if (index == rating.floor() && rating - rating.floor() > 0.5) {
          return const Icon(Icons.star_half, color: Colors.yellow);
        } else {
          return const Icon(Icons.star_border, color: Colors.yellow);
        }
      }),
    );
  }
}
