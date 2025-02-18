import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:my_notes/Screens/add_note_page.dart';
import 'package:my_notes/Screens/home_page.dart';
import 'package:my_notes/Screens/login_page.dart';
import 'package:my_notes/Screens/signup_page.dart';
import 'package:my_notes/providers/notes_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://qoocexjshrajbffllgpw.supabase.co',
    anonKey:
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFvb2NleGpzaHJhamJmZmxsZ3B3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzg4Mzk0MjEsImV4cCI6MjA1NDQxNTQyMX0.WlMiclnb_mcmeOnSFkw1t8fL-Brc5zpIGp6oRlWONFs',
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NotesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFFD4D4D8),
      ),
      title: 'My Notes',
      home:  LoginPage(),
      routes: {
        LoginPage.routeName : (ctx) =>  LoginPage(),
        SignupPage.routeName: (ctx) => const SignupPage(),
        HomePage.routeName: (ctx) => const HomePage(),
        AddNotePage.routeName: (ctx) => const AddNotePage(),
      },
    );
  }
}

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;

    if(session != null){
      return const HomePage();
    }else{
      return LoginPage();
    }
  }
}


