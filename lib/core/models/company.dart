enum CompanyEnum { name, id }

class Company {
  final String name;
  final String id;

  Company({
    required this.name,
    required this.id,
  });

  // Factory method to create a Company from JSON
  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json[CompanyEnum.name.name],
      id: json[CompanyEnum.id.name],
    );
  }

  static List<Company> fromList(list) {
    if (list is! List || list.isEmpty) return [];

    return list.map((json) => Company.fromJson(json)).toList();
  }

  // Method to convert a Company to JSON
  Map<String, dynamic> toJson() {
    return {
      CompanyEnum.name.name: name,
      CompanyEnum.id.name: id,
    };
  }
}
