import 'package:flutter/material.dart';
import 'package:my_notes/Screens/home_page.dart';
import 'package:my_notes/Screens/signup_page.dart';
import 'package:my_notes/styles.dart';
import 'package:my_notes/widgets/custom_text_field.dart';
import '../auth_service.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/loginPage';

  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? emailError;
  String? passwordError;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool isValidEmail(String email) {
    final RegExp regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return regex.hasMatch(email);
  }

  void validateFields() {
    setState(() {
      emailError = emailController.text.isEmpty
          ? "Please enter your email"
          : (!isValidEmail(emailController.text)
              ? "Enter a valid email address"
              : null);

      passwordError =
          passwordController.text.isEmpty ? "Please enter your password" : null;
    });
  }

  Future<void> login() async {
    validateFields();

    if (emailError != null || passwordError != null) {
      return; // Stop login if there are validation errors
    }

    String? error = await AuthService().signIn(
      emailController.text.trim(),
      passwordController.text,
    );

    if (error == null) {
      Navigator.pushReplacementNamed(
          context, HomePage.routeName); // Redirect on success
    } else {
      handleLoginError(error);
    }
  }

  void handleLoginError(String error) {
    if (error.contains("invalid_grant")) {
      showErrorSnackBar("Invalid email or password.");
    } else if (error.contains("Network")) {
      showErrorSnackBar("Network error. Please check your connection.");
    } else if (error.contains("User not found")) {
      showSignUpDialog();
    } else {
      showErrorSnackBar("An unexpected error occurred. Please try again.");
    }
  }

  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void showSignUpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Account Not Found"),
        content: const Text(
            "It looks like there's no account with this email. Would you like to sign up?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pushReplacementNamed(context, SignupPage.routeName);
            },
            child: const Text("Sign Up"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = MediaQuery.of(context).size.width;
        double padding = screenWidth > 600 ? 80 : 20;
        double spacing = screenWidth > 600 ? 80 : 40;

        return Scaffold(
          backgroundColor: kScaffoldColor,
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/Logo-app.png',
                        height: 113,
                        width: 113,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Login',
                        style: kPageNameTextStyle,
                      ),
                      SizedBox(height: spacing),
                      const Text(
                        'Welcome back to your personal note taker',
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: spacing),
                      Column(
                        children: [
                          CustomTextField(
                            hintText: 'someone@gmail.com',
                            title: 'Email',
                            controller: emailController,
                            obscureText: false,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          if (emailError != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(emailError!,
                                  style: kInputWarningTextStyle),
                            ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            hintText: 'Password',
                            title: 'Password',
                            controller: passwordController,
                            obscureText: true, keyboardType: TextInputType.visiblePassword,
                          ),
                          if (passwordError != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(passwordError!,
                                  style: kInputWarningTextStyle),
                            ),
                        ],
                      ),
                      SizedBox(height: spacing),
                      ElevatedButton(
                        onPressed: login,
                        style: kLoginSignupButtonStyle,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 16),
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.login, color: Colors.black87),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
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
                              Navigator.pushNamed(
                                  context, SignupPage.routeName);
                            },
                            child: Text(
                              'Sign Up',
                              style: kLoginSignupNavigatorTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
