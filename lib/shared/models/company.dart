class Company {
  final String id;
  final String? bin;
  final String? address;
  final String name;
  final DateTime createdAt;

  const Company({
    required this.id,
    required this.bin,
    required this.address,
    required this.name,
    required this.createdAt,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      bin: json['bin'],
      address: json['address'],
      name: json['name'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}