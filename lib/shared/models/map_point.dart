class MapPoint {
  const MapPoint({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.description,
  });

  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final String? description;

  factory MapPoint.fromJson(Map<String, dynamic> json) {
    return MapPoint(
      id: json['id'].toString(),
      name: json['name']?.toString() ?? '',
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      description: json['description']?.toString(),
    );
  }
}
