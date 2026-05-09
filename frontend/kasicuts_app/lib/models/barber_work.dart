class BarberWork {
  final int id;
  final int barberId;
  final String barberName;
  final String styleName;
  final String description;
  final String imageUrl;
  final double priceFrom;

  BarberWork({
    required this.id,
    required this.barberId,
    required this.barberName,
    required this.styleName,
    required this.description,
    required this.imageUrl,
    required this.priceFrom,
  });

  factory BarberWork.fromJson(Map<String, dynamic> json) {
    return BarberWork(
      id: json['id'],
      barberId: json['barberId'],
      barberName: json['barberName'],
      styleName: json['styleName'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      priceFrom: (json['priceFrom'] as num).toDouble(),
    );
  }
}