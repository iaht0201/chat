import 'package:supabase_flutter/supabase_flutter.dart';

import 'service.dart';

class AuthRepository {
  final AuthService authService;
  AuthRepository({required this.authService});

  Future<bool> login(String email, String password) async {
    return await authService.login(email, password);
  }

  Future<AuthResponse> register(String email, String password) async {
    return await authService.register(email, password);
  }
}
