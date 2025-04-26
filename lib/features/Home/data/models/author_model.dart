import '../../domain/entities/book_entity.dart';

class AuthorModel extends AuthorEntity {
  const AuthorModel({
    required super.name,
    super.birthYear,
    super.deathYear,
  });

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      name: json['name'] ?? '',
      birthYear: json['birth_year'],
      deathYear: json['death_year'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'birth_year': birthYear,
      'death_year': deathYear,
    };
  }
}
