class Notes {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;

  Notes({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  factory Notes.fromJson(Map<String, dynamic> json) {
    return Notes(
      id: json['id'] ?? '', // Handle null ID safely
      title: json['title'] ?? 'Untitled', // Default title if null
      content: json['content'] ?? 'No content', // Default content if null
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }
}
