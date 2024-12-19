import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:text_to_speech/config/supbase_service.dart';

class AuthService {
  final SupabaseClient _client;

  AuthService(this._client);

  Future<bool> login(String email, String password) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      // if (response.error != null) {
      //   throw Exception('Login failed: ${response.error?.message}');
      // }
      return response.user != null;
    } catch (e) {
      // Throw a custom error with a detailed message
      throw Exception('Login error: $e');
    }
  }

  Future<AuthResponse> register(String email, String password) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
      );
      // if (response.error != null) {
      //   throw Exception('Registration failed: ${response.error?.message}');
      // }
      return response;
    } catch (e) {
      throw Exception('Registration error: $e');
    }
  }
}
