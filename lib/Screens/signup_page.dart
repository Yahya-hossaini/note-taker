import 'package:flutter/material.dart';
import 'package:supabase_project/Screens/home_page.dart';
import 'package:supabase_project/Screens/login_page.dart';
import 'package:supabase_project/widgets/custom_text_field.dart';

import '../auth_service.dart';

class SignupPage extends StatelessWidget {
  static const routeName = 'signupPage';

  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();


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
                'Sign Up',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 42,
              ),
              const Text(
                'Sign up for free',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 42,
              ),
              Column(
                children: [
                  CustomTextField(
                    hintText: 'Enter your name.',
                    title: 'Name',
                    controller: nameController,
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    hintText: 'someone@gmail.com',
                    title: 'Email',
                    controller: emailController,
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    hintText: 'Password',
                    title: 'Password',
                    controller: passwordController,
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    hintText: 'Password',
                    title: 'Confirm Password',
                    controller: confirmPasswordController,
                  ),
                ],
              ),
              const SizedBox(
                height: 42,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (passwordController.text != confirmPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Passwords do not match')),
                    );
                    return;
                  }

                  String? error = await AuthService().signUp(
                    nameController.text,
                    emailController.text,
                    passwordController.text,
                  );

                  if (error == null) {
                    // Navigate to Login Page after successful signup
                    Navigator.pushReplacementNamed(context, HomePage.routeName);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Account created! Please log in.')),
                    );
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
                        'Sign up',
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
                      const CircularProgressIndicator();
                      Navigator.pushReplacementNamed(context, LoginPage.routeName);
                    },
                    child: const Text(
                      'Login',
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
