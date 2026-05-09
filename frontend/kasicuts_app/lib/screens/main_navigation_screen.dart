import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'products_screen.dart';
import 'services_screen.dart';
import 'barber_dashboard_screen.dart';
import 'customer_queue_screen.dart';
import 'barber_catalogue_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  final String fullName;
  final String role;

  const MainNavigationScreen({
    super.key,
    required this.fullName,
    required this.role,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isBarberOrAdmin = widget.role == 'Barber' || widget.role == 'Admin';

    final pages = [
      HomeScreen(fullName: widget.fullName, role: widget.role),
      const ProductsScreen(),
      const ServicesScreen(),
      const BarberCatalogueScreen(),
      CustomerQueueScreen(customerName: widget.fullName),
      if (isBarberOrAdmin) const BarberDashboardScreen(),
    ];

    final destinations = [
      const NavigationDestination(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      const NavigationDestination(
        icon: Icon(Icons.shopping_bag),
        label: 'Products',
      ),
      const NavigationDestination(
        icon: Icon(Icons.content_cut),
        label: 'Services',
      ),
      const NavigationDestination(
        icon: Icon(Icons.photo_library),
        label: 'Catalogue',
      ),
      const NavigationDestination(
        icon: Icon(Icons.queue),
        label: 'Queue',
      ),
      if (isBarberOrAdmin)
        const NavigationDestination(
          icon: Icon(Icons.dashboard),
          label: 'Barber',
        ),
    ];

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: pages[currentIndex],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF1A1A1A),
        indicatorColor: const Color(0xFFFFB000),
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: destinations,
      ),
    );
  }
}