import 'package:flutter/material.dart';
import '../models/barber_service.dart';
import '../services/api_service.dart';
import 'booking_screen.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  late Future<List<BarberService>> servicesFuture;

  @override
  void initState() {
    super.initState();
    servicesFuture = ApiService.getServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Haircut Services'),
      ),
      body: FutureBuilder<List<BarberService>>(
        future: servicesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final services = snapshot.data ?? [];

          if (services.isEmpty) {
            return const Center(child: Text('No services found'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(

onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => BookingScreen(service: service),
    ),
  );
},                  leading: const Icon(Icons.content_cut),
                  title: Text(service.name),
                  subtitle: Text(
                    '${service.description}\n${service.durationMinutes} minutes',
                    
                  ),
                  trailing: Text(
                    'R${service.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}