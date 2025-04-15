class Task {
  int? id;
  String title;
  String description;
  String colorHex;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.colorHex,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'colorHex': colorHex,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      colorHex: map['colorHex'],
    );
  }
}