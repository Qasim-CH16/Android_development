class Subject {
  final int? id;
  final String name;
  final String teacher;
  final int credits;

  Subject({this.id, required this.name, required this.teacher, required this.credits});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'teacher': teacher,
      'credits': credits,
    };
  }

  factory Subject.fromMap(Map<String, dynamic> map) {
    return Subject(
      id: map['id'],
      name: map['name'],
      teacher: map['teacher'],
      credits: map['credits'],
    );
  }
}