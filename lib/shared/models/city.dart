class City {
  final String name;
  final String? country;
  final String? admin1;
  final double latitude;
  final double longitude;

  City({
    required this.name,
    this.country,
    this.admin1,
    required this.latitude,
    required this.longitude,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        name: json['name'] as String,
        country: json['country'] as String?,
        admin1: json['admin1'] as String?,
        latitude: (json['latitude'] as num).toDouble(),
        longitude: (json['longitude'] as num).toDouble(),
      );

  String get displayName {
    final parts = [name, admin1, country]
        .where((e) => e != null && e.isNotEmpty)
        .toList();
    return parts.join(', ');
  }
}
