import 'dart:convert';
import '../models/product.dart';
import '../models/barber_service.dart';
import 'package:http/http.dart' as http;
import '../models/barber_work.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:5051/api';
static Future<List<Product>> getProducts() async {
  final response = await http.get(
    Uri.parse('$baseUrl/Products'),
  );

  if (response.statusCode == 200) {
    final List data = jsonDecode(response.body);
    return data.map((item) => Product.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load products');
  }
}

static Future<Map<String, dynamic>> registerBarber({
  required String fullName,
  required String email,
  required String password,
}) async {
  return await register(
    fullName: fullName,
    email: email,
    password: password,
    role: 'Barber',
  );
}

static Future<List<BarberWork>> getBarberWorks() async {
  final response = await http.get(
    Uri.parse('$baseUrl/BarberWorks'),
  );

  if (response.statusCode == 200) {
    final List data = jsonDecode(response.body);
    return data.map((item) => BarberWork.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load barber work catalogue');
  }
}
static Future<Map<String, dynamic>> addService({
  required String name,
  required String description,
  required double price,
  required int durationMinutes,
  required String imageUrl,
}) async {
  final response = await http.post(
    Uri.parse('$baseUrl/Services'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'name': name,
      'description': description,
      'price': price,
      'durationMinutes': durationMinutes,
      'isAvailable': true,
      'imageUrl': imageUrl,
    }),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  }

  return {
    'error': response.body,
    'status': response.statusCode,
  };
}


static Future<Map<String, dynamic>> register({
  required String fullName,
  required String email,
  required String password,
  required String role,
}) async {
  final response = await http.post(
    Uri.parse('$baseUrl/Auth/register'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'fullName': fullName.trim(),
      'email': email.trim(),
      'password': password.trim(),
      'role': role,
    }),
  );

  if (response.statusCode == 200) {
    return {'success': true, 'message': response.body};
  } else {
    return {'success': false, 'message': response.body};
  }
}
static Future<Map<String, dynamic>> createBooking({
  required String customerName,
  required String customerPhone,
  required int serviceId,
  required int barberId,
  required DateTime bookingDate,
  required bool isHouseCall,
}) async {
  final response = await http.post(
    Uri.parse('$baseUrl/Bookings'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'customerName': customerName,
      'customerPhone': customerPhone,
      'serviceId': serviceId,
      'barberId': barberId,
      'bookingDate': bookingDate.toUtc().toIso8601String(),
      'isHouseCall': isHouseCall,
    }),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    return {
      'error': response.body,
      'status': response.statusCode,
    };
  }
}
static Future<List<BarberService>> getServices() async {
  final response = await http.get(
    Uri.parse('$baseUrl/Services'),
  );

  if (response.statusCode == 200) {
    final List data = jsonDecode(response.body);
    return data.map((item) => BarberService.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load services');
  }
}
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/Auth/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email.trim(),
          'password': password.trim(),
        }),
      );

      print('STATUS: ${response.statusCode}');
      print('BODY: ${response.body}');

      if (response.body.isEmpty) {
        return {
          'error': 'Empty response from server',
          'status': response.statusCode,
        };
      }

      return jsonDecode(response.body);
    } catch (e) {
      print('LOGIN ERROR: $e');
      return {
        'error': e.toString(),
      };
    }
  }
}