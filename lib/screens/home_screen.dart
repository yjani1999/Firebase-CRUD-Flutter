import 'package:firebase_crud/screens/add_user_screen.dart';
import 'package:firebase_crud/screens/list_users_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 72, 71, 71),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Firebase CRUD'),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 252, 128, 25),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddUserScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Add',
                  style: TextStyle(fontSize: 20.0),
                ),
              )
            ],
          ),
        ),
        body: Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: const ListUsersScreen()),
      ),
    );
  }
}
