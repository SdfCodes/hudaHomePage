class Course {
  final String title;
  final String instructor;
  final String description;
  final double price;
  final double rating;
  final int reviewCount;
  final List<String> tags;
  final String imageURL;

  Course({
    required this.title,
    required this.instructor,
    required this.description,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.tags,
    required this.imageURL,
  });
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      title: json['title'],
      instructor: json['instructor'],
      description: json['description'],
      price: json['price'].toDouble(),
      rating: json['rating'].toDouble(),
      reviewCount: json['reviews_count'],
      tags: List<String>.from(json['tags']),
      imageURL: json['image_url'],
    );
  }
}
