import 'package:flutter/material.dart';
import 'package:my_notes/Screens/login_page.dart';
import 'package:my_notes/widgets/custom_text_field.dart';
import '../auth_service.dart';

class SignupPage extends StatefulWidget {
  static const routeName = '/signupPage';

  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String? nameError;
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  bool isValidEmail(String email) {
    final RegExp regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return regex.hasMatch(email);
  }

  void validateFields() {
    setState(() {
      nameError = nameController.text.isEmpty ? "Please enter your name" : null;
      emailError = emailController.text.isEmpty
          ? "Please enter your email"
          : (!isValidEmail(emailController.text) ? "Enter a valid email address" : null);
      passwordError = passwordController.text.isEmpty
          ? "Please enter a password"
          : (passwordController.text.length < 6 ? "Password must be at least 6 characters" : null);
      confirmPasswordError = confirmPasswordController.text.isEmpty
          ? "Please confirm your password"
          : (confirmPasswordController.text != passwordController.text ? "Passwords do not match" : null);
    });
  }

  Future<void> signUp() async {
    validateFields();

    if (nameError != null ||
        emailError != null ||
        passwordError != null ||
        confirmPasswordError != null) {
      return; // Prevent signup if any error exists
    }

    String? error = await AuthService().signUp(
      nameController.text.trim(),
      emailController.text.trim(),
      passwordController.text,
    );

    if (error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created! Please log in.')),
      );
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172B),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double height = constraints.maxHeight;
          double width = constraints.maxWidth;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: height * 0.12),
                  Image.asset(
                    'assets/images/Logo-app.png',
                    height: height * 0.12,
                    width: height * 0.12,
                  ),
                  SizedBox(height: height * 0.02),
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: height * 0.04),
                  const Text(
                    'Sign up for free.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: height * 0.04),
                  Column(
                    children: [
                      CustomTextField(
                        hintText: 'Enter your name',
                        title: 'Name',
                        controller: nameController,
                        obscureText: false,
                      ),
                      if (nameError != null)
                        Text(nameError!, style: TextStyle(color: Colors.red, fontSize: 14)),
                      SizedBox(height: height * 0.02),
                      CustomTextField(
                        hintText: 'someone@gmail.com',
                        title: 'Email',
                        controller: emailController,
                        obscureText: false,
                      ),
                      if (emailError != null)
                        Text(emailError!, style: TextStyle(color: Colors.red, fontSize: 14)),
                      SizedBox(height: height * 0.02),
                      CustomTextField(
                        hintText: 'Password',
                        title: 'Password',
                        controller: passwordController,
                        obscureText: true,
                      ),
                      if (passwordError != null)
                        Text(passwordError!, style: TextStyle(color: Colors.red, fontSize: 14)),
                      SizedBox(height: height * 0.02),
                      CustomTextField(
                        hintText: 'Confirm Password',
                        title: 'Confirm Password',
                        controller: confirmPasswordController,
                        obscureText: true,
                      ),
                      if (confirmPasswordError != null)
                        Text(confirmPasswordError!, style: TextStyle(color: Colors.red, fontSize: 14)),
                    ],
                  ),
                  SizedBox(height: height * 0.05),
                  ElevatedButton(
                    onPressed: signUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF54F34F),
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
                  SizedBox(height: height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: Color(0xFFD4D4D8),
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, LoginPage.routeName);
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
                  SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
