import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CustomerQueueScreen extends StatefulWidget {
  final String customerName;

  const CustomerQueueScreen({
    super.key,
    required this.customerName,
  });

  @override
  State<CustomerQueueScreen> createState() => _CustomerQueueScreenState();
}

class _CustomerQueueScreenState extends State<CustomerQueueScreen> {
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
      final allBookings = jsonDecode(response.body);

      setState(() {
        bookings = allBookings
            .where((b) =>
                b['customerName'].toString().toLowerCase() ==
                widget.customerName.toLowerCase())
            .toList();
      });
    } else {
      setState(() {
        message = 'Failed to load your queue';
      });
    }
  }

  Color getStatusColor(String status) {
    if (status == 'Accepted') return Colors.green;
    if (status == 'Rejected') return Colors.red;
    return const Color(0xFFFFB000);
  }

  @override
  Widget build(BuildContext context) {
    final pending = bookings.where((b) => b['status'] == 'Pending').toList();
    final accepted = bookings.where((b) => b['status'] == 'Accepted').toList();
    final rejected = bookings.where((b) => b['status'] == 'Rejected').toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Booking Queue'),
      ),
      body: RefreshIndicator(
        onRefresh: fetchBookings,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _summaryCard('Pending', pending.length, const Color(0xFFFFB000)),
            _summaryCard('Approved', accepted.length, Colors.green),
            _summaryCard('Rejected', rejected.length, Colors.red),

            const SizedBox(height: 20),

            Text(message),

            const Text(
              'Your Bookings',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            if (bookings.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Text('No bookings yet'),
                ),
              ),

            ...bookings.map((booking) {
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: getStatusColor(booking['status']),
                    child: const Icon(Icons.content_cut, color: Colors.black),
                  ),
                  title: Text('Service ID: ${booking['serviceId']}'),
                  subtitle: Text(
                    'Status: ${booking['status']}\n'
                    'House Call: ${booking['isHouseCall']}\n'
                    'Date: ${booking['bookingDate']}',
                  ),
                  trailing: Text(
                    booking['status'],
                    style: TextStyle(
                      color: getStatusColor(booking['status']),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard(String title, int count, Color color) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Text(
            count.toString(),
            style: const TextStyle(color: Colors.black),
          ),
        ),
        title: Text(title),
        subtitle: Text('$count booking(s)'),
      ),
    );
  }
}