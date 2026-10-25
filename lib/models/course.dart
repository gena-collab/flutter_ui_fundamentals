// Nama: Gena Anggarani
// NIM: 2415051038

class Course {
  final int id;
  final String code;
  final String title;
  final int credits;
  final String status;
  final String? createdAt;

  Course({
    required this.id,
    required this.code,
    required this.title,
    required this.credits,
    required this.status,
    this.createdAt,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as int,
      code: json['code'] as String,
      title: json['title'] as String,
      credits: json['credits'] as int,
      status: json['status'] as String,
      createdAt: json['created_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'title': title,
      'credits': credits,
      'status': status,
      'created_at': createdAt,
    };
  }
}