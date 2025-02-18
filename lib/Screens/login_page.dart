import 'package:flutter/material.dart';
import 'package:my_notes/Screens/home_page.dart';
import 'package:my_notes/Screens/signup_page.dart';
import 'package:my_notes/widgets/custom_text_field.dart';

import '../auth_service.dart';

class LoginPage extends StatelessWidget {

  static const routeName = '/loginPage';

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFF0F172B),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, top: 113),
          child: Column(
            children: [
              Image.asset(
                'assets/images/Logo-app.png',
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
              Column(
               children: [
                 CustomTextField(
                   hintText: 'someone@gmail.com',
                   title: 'Email',
                   controller: emailController,
                 ),
                 const SizedBox(height: 20),
                 CustomTextField(
                   hintText: 'Password',
                   title: 'Password',
                   controller: passwordController,
                 ),
               ],
             ),
              const SizedBox(
                height: 64,
              ),
              ElevatedButton(
                onPressed: () async {
                  String? error = await AuthService().signIn(
                    emailController.text,
                    passwordController.text,
                  );
                  if (error == null) {
                    Navigator.pushReplacementNamed(context, HomePage.routeName); // Redirect on success
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
                    print(error);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF54F34F), // Rose-500 equivalent
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
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, SignupPage.routeName);
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        color: Color(0xFFD4D4D8),
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFFD4D4D8),
                      ),
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
