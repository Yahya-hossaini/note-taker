import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static const routename = 'loginPage';

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172B),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, top: 113),
          child: Column(
            children: [
              Image.asset(
                'assets/images/Logo.png',
                height: 113,
                width: 113,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Login',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 64,
              ),
              const Text(
                'Welcome back to your personal note taker',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 64,
              ),
              TextField(
                style: TextStyle(color: Colors.white70),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFF2C2C2C), // Zinc-800 equivalent
                  hintText: 'someone@gmail.com',
                  hintStyle: TextStyle(
                      color: Color(0xFFD4D4D8)), // Zinc-400 equivalent
                  labelText: 'Email',
                  labelStyle: TextStyle(
                      color: Color(0xFF7C7C7C)), // Zinc-400 equivalent
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                obscureText: true,
                style: TextStyle(color: Colors.white70),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFF2C2C2C), // Zinc-800 equivalent
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    color: Color(0xFF7C7C7C),
                  ), // Zinc-400 equivalent
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Color(0xFF7C7C7C),
                  ), // Zinc-400 equivalent
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(
                height: 64,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF54F34F), // Rose-500 equivalent
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(color: Colors.black87, fontSize: 16),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.login, color: Colors.black87),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Create Account?',
                    style: TextStyle(
                      color: Color(0xFFD4D4D8),
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                          color: Color(0xFFD4D4D8),
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xFFD4D4D8)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
