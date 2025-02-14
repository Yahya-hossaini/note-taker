import 'package:flutter/material.dart';
import 'package:supabase_project/widgets/custom_text_field.dart';

import '../widgets/custom_appbar.dart';

class HomePage extends StatelessWidget {
  static const routeName = 'homepage';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
  final TextEditingController searchController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFF1E2939),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            MediaQuery.of(context).orientation == Orientation.portrait
                ? 80
                : 60),
        child: const CustomAppbar(
          leftSideSelector: 'menu',
          rightSideSelector: 'image',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
        child: Center(
          child: Column(
            children: [
              // Notes reader. it read the total amount of notes in app
              Container(
                height: 135,
                width: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFF404040),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 18,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 18),
                      child: Text(
                        'Total Notes Number:',
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    const Text(
                      '63',
                      style: TextStyle(
                        fontSize: 48,
                        color: Color(0xFF54F34F),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 36,),
              CustomTextField(hintText: 'Enter the title', title: 'Search', controller: searchController),
            ],
          ),
        ),
      ),
    );
  }
}
