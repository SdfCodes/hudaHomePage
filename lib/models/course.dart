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
      title: json['title'] ?? '',
      instructor: json['instructor'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      reviewCount: json['reviews_count'] ?? 0,
      tags: List<String>.from(json['tags'] ?? []),
      imageURL: json['image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'instructor': instructor,
      'description': description,
      'price': price,
      'rating': rating,
      'reviews_count': reviewCount,
      'tags': tags,
      'image_url': imageURL,
    };
  }

  static const List<String> categories = [
    "Culinary",
    "Language",
    "Science",
    "Art",
    "Technology",
    "History",
    "Maths",
    "Coding",
  ];


  static List<Course> demoCourses = [
    Course(
      instructor: "Alice Waters",
      title: "Art of Home cooking",
      description: "Learn home cooking step by step",
      price: 29.99,
      rating: 4.8,
      reviewCount: 120,
      tags: ["Culinary"],
      imageURL: "https://picsum.photos/201/300",
    ),
    Course(
      instructor: "Wolfgang Puck",
      title: "Mastering Kitchen Fundamentals",
      description: "Become professional in kitchen basics",
      price: 39.99,
      rating: 4.6,
      reviewCount: 95,
      tags: ["Culinary"],
      imageURL: "https://picsum.photos/202/300",
    ),
    Course(
      instructor: "Tech Expert",
      title: "Tech & Coding Masterclass",
      description: "Learn Flutter and coding",
      price: 59.99,
      rating: 4.9,
      reviewCount: 210,
      tags: ["Technology", "Coding"],
      imageURL: "https://picsum.photos/203/300",
    ),
    Course(
      instructor: "Gordon Ramsay",
      title: "Teaches cooking I",
      description: "Cooking is not easy",
      price: 49.99,
      rating: 4.8,
      reviewCount: 120,
      tags: ["Art", "Culinary", "Science"],
      imageURL: "https://picsum.photos/200/300",
    ),
  ];
  static final List<Map<String, dynamic>> profileData = [
    {
      "key": "phone",
      "title": "Phone Number",
      "value": "+84 960238026",
      "isPassword": false,
    },
    {
      "key": "email",
      "title": "Email",
      "value": "danielkeller.123@gmail.com",
      "isPassword": false,
    },
    {
      "key": "password",
      "title": "Password",
      "value": "123456",
      "isPassword": true,
    },
  ];
}