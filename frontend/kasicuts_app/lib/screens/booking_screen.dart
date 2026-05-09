import 'package:flutter/material.dart';
import '../models/barber_service.dart';
import '../services/api_service.dart';

class BookingScreen extends StatefulWidget {
  final BarberService service;

  const BookingScreen({
    super.key,
    required this.service,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  bool isHouseCall = false;
  String message = '';

  Future<void> submitBooking() async {
    final response = await ApiService.createBooking(
      customerName: nameController.text,
      customerPhone: phoneController.text,
      serviceId: widget.service.id,
      barberId: 1,
      bookingDate: DateTime.now().add(const Duration(days: 1)),
      isHouseCall: isHouseCall,
    );

    setState(() {
      if (response.containsKey('error')) {
        message = 'Booking failed';
      } else {
        message = 'Booking created successfully';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Service'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              widget.service.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text('Price: R${widget.service.price.toStringAsFixed(2)}'),

            const SizedBox(height: 20),

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Your Name',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            SwitchListTile(
              title: const Text('House Call'),
              value: isHouseCall,
              onChanged: (value) {
                setState(() {
                  isHouseCall = value;
                });
              },
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: submitBooking,
                child: const Text('Confirm Booking'),
              ),
            ),

            const SizedBox(height: 20),

            Text(message),
          ],
        ),
      ),
    );
  }
}