class BarberService {
  final int id;
  final String name;
  final String description;
  final double price;
  final int durationMinutes;
  final bool isAvailable;
  final String imageUrl;

  BarberService({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.durationMinutes,
    required this.isAvailable,
    required this.imageUrl,
  });

  factory BarberService.fromJson(Map<String, dynamic> json) {
    return BarberService(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      durationMinutes: json['durationMinutes'],
      isAvailable: json['isAvailable'],
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}