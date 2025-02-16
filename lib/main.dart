import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_project/Screens/home_page.dart';
import 'package:supabase_project/Screens/login_page.dart';
import 'package:supabase_project/Screens/signup_page.dart';
import 'package:supabase_project/providers/notes_provider.dart';

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
      title: 'Flutter Demo',
      home:  const HomePage(),
      routes: {
        LoginPage.routeName : (ctx) =>  LoginPage(),
        SignupPage.routeName: (ctx) => const SignupPage(),
        HomePage.routeName: (ctx) => const HomePage(),
      },
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final _noteStream =
//       Supabase.instance.client.from('notes').stream(primaryKey: ['id']);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Notes'),
//       ),
//       body: StreamBuilder<List<Map<String, dynamic>>>(
//         stream: _noteStream,
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           final notes = snapshot.data!;
//
//           return ListView.builder(
//             itemCount: notes.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(notes[index]['body']),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: ((context) {
//               return SimpleDialog(
//                 title: const Text('Add a Note'),
//                 contentPadding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 children: [
//                   TextFormField(
//                     onFieldSubmitted: (value) async {
//                       await Supabase.instance.client
//                           .from('notes')
//                           .insert({'body': value});
//                     },
//                   ),
//                 ],
//               );
//             }),
//           );
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
