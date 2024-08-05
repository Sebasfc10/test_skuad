class Article {
  final String title;
  final String author;
  final DateTime createdAt;

  Article({required this.title, required this.author, required this.createdAt});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['story_title'] ?? 'No Title',
      author: json['author'] ?? 'No Author',
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
