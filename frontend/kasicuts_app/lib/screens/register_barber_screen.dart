import 'package:flutter/material.dart';
import '../services/api_service.dart';

class RegisterBarberScreen extends StatefulWidget {
  const RegisterBarberScreen({super.key});

  @override
  State<RegisterBarberScreen> createState() => _RegisterBarberScreenState();
}

class _RegisterBarberScreenState extends State<RegisterBarberScreen> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String message = '';

  Future<void> registerBarber() async {
    final response = await ApiService.registerBarber(
      fullName: fullNameController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    setState(() {
      if (response['success'] == true) {
        message = 'Barber registered successfully';
        fullNameController.clear();
        emailController.clear();
        passwordController.clear();
      } else {
        message = response['message'].toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Barber'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Add New Barber',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFB000),
            ),
          ),

          const SizedBox(height: 20),

          TextField(
            controller: fullNameController,
            decoration: const InputDecoration(
              labelText: 'Barber Full Name',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 15),

          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Barber Email',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 15),

          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 25),

          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: registerBarber,
              child: const Text('Register Barber'),
            ),
          ),

          const SizedBox(height: 20),

          Text(message),
        ],
      ),
    );
  }
}