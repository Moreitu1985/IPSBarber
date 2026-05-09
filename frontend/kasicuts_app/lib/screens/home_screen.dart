import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'register_barber_screen.dart';

class HomeScreen extends StatelessWidget {
  final String fullName;
  final String role;

  const HomeScreen({
    super.key,
    required this.fullName,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KasiCuts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFFFB000),
                  Color(0xFFFF6A00),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sharp cuts.\nKasi style.',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Welcome $fullName',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Role: $role',
                  style: const TextStyle(
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Explore KasiCuts',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          _homeCard(
            icon: Icons.content_cut,
            title: 'Book a fresh cut',
            subtitle: 'Choose services and send a booking request.',
          ),

          _homeCard(
            icon: Icons.shopping_bag,
            title: 'Buy grooming products',
            subtitle: 'Browse oils, creams, brushes, and more.',
          ),

          if (role == 'Barber' || role == 'Admin')
            _homeCard(
              icon: Icons.storefront,
              title: 'Barber dashboard',
              subtitle: 'Manage requests, accept or reject bookings.',
            ),

          if (role == 'Admin')
            Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                contentPadding: const EdgeInsets.all(18),
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFFFB000),
                  child: Icon(Icons.person_add, color: Colors.black),
                ),
                title: const Text(
                  'Register Barber',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('Create a barber account'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RegisterBarberScreen(),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _homeCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(18),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFFFB000),
          child: Icon(icon, color: Colors.black),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
      ),
    );
  }
}