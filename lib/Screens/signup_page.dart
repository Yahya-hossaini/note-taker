import 'package:flutter/material.dart';
import 'package:my_notes/Screens/login_page.dart';
import 'package:my_notes/styles.dart';
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

  //----------------------------------------------------------------------------
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
  //----------------------------------------------------------------------------
  //validating the email
  bool isValidEmail(String email) {
    final RegExp regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return regex.hasMatch(email);
  }
  //----------------------------------------------------------------------------
  //validating the inputs, making sure they won't be empty
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
  //----------------------------------------------------------------------------
  //Sign up function
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
        const SnackBar(content: Text('Account created! Please confirm your email and log in.')),
      );
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    }
  }
  //----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor,
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
                  Text(
                    'Sign Up',
                    style: kPageNameTextStyle,
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
                    //Input fields
                    children: [
                      CustomTextField(
                        hintText: 'Enter your name',
                        title: 'Name',
                        controller: nameController,
                        obscureText: false,
                        keyboardType: TextInputType.name,
                      ),
                      if (nameError != null)
                        Text(nameError!, style: kInputWarningTextStyle),
                      SizedBox(height: height * 0.02),
                      CustomTextField(
                        hintText: 'someone@gmail.com',
                        title: 'Email',
                        controller: emailController,
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      if (emailError != null)
                        Text(emailError!, style: kInputWarningTextStyle),
                      SizedBox(height: height * 0.02),
                      CustomTextField(
                        hintText: 'Password',
                        title: 'Password',
                        controller: passwordController,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      if (passwordError != null)
                        Text(passwordError!, style: kInputWarningTextStyle),
                      SizedBox(height: height * 0.02),
                      CustomTextField(
                        hintText: 'Confirm Password',
                        title: 'Confirm Password',
                        controller: confirmPasswordController,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      if (confirmPasswordError != null)
                        Text(confirmPasswordError!, style: kInputWarningTextStyle),
                    ],
                  ),
                  SizedBox(height: height * 0.05),
                  //Sign up button here
                  ElevatedButton(
                    onPressed: signUp,
                    style: kLoginSignupButtonStyle,
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
                        child: Text(
                          'Login',
                          style: kLoginSignupNavigatorTextStyle,
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
