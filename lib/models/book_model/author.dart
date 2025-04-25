class Author {
  String? name;
  int? birthYear;
  int? deathYear;

  Author({this.name, this.birthYear, this.deathYear});

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    name: json['name'] as String?,
    birthYear: json['birth_year'] as int?,
    deathYear: json['death_year'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'birth_year': birthYear,
    'death_year': deathYear,
  };
}
