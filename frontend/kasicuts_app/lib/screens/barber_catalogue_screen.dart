import 'package:flutter/material.dart';
import '../models/barber_work.dart';
import '../services/api_service.dart';

class BarberCatalogueScreen extends StatefulWidget {
  const BarberCatalogueScreen({super.key});

  @override
  State<BarberCatalogueScreen> createState() => _BarberCatalogueScreenState();
}

class _BarberCatalogueScreenState extends State<BarberCatalogueScreen> {
  late Future<List<BarberWork>> worksFuture;

  @override
  void initState() {
    super.initState();
    worksFuture = ApiService.getBarberWorks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barber Catalogue'),
      ),
      body: FutureBuilder<List<BarberWork>>(
        future: worksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final works = snapshot.data ?? [];

          if (works.isEmpty) {
            return const Center(child: Text('No barber work yet'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: works.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 0.72,
            ),
            itemBuilder: (context, index) {
              final work = works[index];

              return Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Image.network(
                        work.imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(Icons.image_not_supported, size: 40),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            work.styleName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            work.barberName,
                            style: const TextStyle(
                              color: Color(0xFFFFB000),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'From R${work.priceFrom.toStringAsFixed(2)}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}