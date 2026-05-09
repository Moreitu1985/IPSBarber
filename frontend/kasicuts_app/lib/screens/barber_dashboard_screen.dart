import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'add_service_screen.dart';

class BarberDashboardScreen extends StatefulWidget {
  const BarberDashboardScreen({super.key});

  @override
  State<BarberDashboardScreen> createState() => _BarberDashboardScreenState();
}

class _BarberDashboardScreenState extends State<BarberDashboardScreen> {
  final String baseUrl = 'http://localhost:5051/api';

  List bookings = [];
  String message = '';

  @override
  void initState() {
    super.initState();
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    final response = await http.get(Uri.parse('$baseUrl/Bookings'));

    if (response.statusCode == 200) {
      setState(() {
        bookings = jsonDecode(response.body);
      });
    } else {
      setState(() {
        message = 'Failed to load bookings';
      });
    }
  }

  Future<void> updateBookingStatus(int id, String action) async {
    final response = await http.put(
      Uri.parse('$baseUrl/Bookings/$id/$action'),
    );

    if (response.statusCode == 200) {
      fetchBookings();
    } else {
      setState(() {
        message = 'Failed to update booking';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final pendingBookings =
        bookings.where((b) => b['status'] == 'Pending').toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Barber Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Pending Requests: ${pendingBookings.length}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
             const SizedBox(height: 15),

SizedBox(
  width: double.infinity,
  height: 50,
  child: ElevatedButton.icon(
    icon: const Icon(Icons.add),
    label: const Text('Add New Service'),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const AddServiceScreen(),
        ),
      );
    },
  ),
),
            const SizedBox(height: 15),

            Text(message),

            Expanded(
              child: ListView.builder(
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  final booking = bookings[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      title: Text(booking['customerName']),
                      subtitle: Text(
                        'Phone: ${booking['customerPhone']}\n'
                        'Status: ${booking['status']}\n'
                        'House Call: ${booking['isHouseCall']}',
                      ),
                      trailing: booking['status'] == 'Pending'
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.check),
                                  onPressed: () {
                                    updateBookingStatus(
                                      booking['id'],
                                      'accept',
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    updateBookingStatus(
                                      booking['id'],
                                      'reject',
                                    );
                                  },
                                ),
                              ],
                            )
                          : Text(booking['status']),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}