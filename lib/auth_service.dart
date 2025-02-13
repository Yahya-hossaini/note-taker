import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  // Sign Up Function
  Future<String?> signUp(String name, String email, String password) async {
    try {
      final AuthResponse res = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      final user = res.user;

      if (user != null) {
        // Store additional user details in 'profiles' table
        await supabase.from('profiles').insert({
          'id': user.id,
          'name': name,
          'email': email,
        });
      }
      return null; // Success
    } catch (error) {
      return error.toString(); // Return error message
    }
  }

  // Sign In Function
  Future<String?> signIn(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(email: email, password: password);
      return null; // Success
    } catch (error) {
      return error.toString();
    }
  }

  // Sign Out Function
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }
}
