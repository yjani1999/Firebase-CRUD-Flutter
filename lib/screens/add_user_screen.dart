// ignore_for_file: avoid_print

import 'dart:typed_data';

import 'package:bcrypt/bcrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/utils/storage_methods.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/utils.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();

  var name = '';
  var email = '';
  var password = '';

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Uint8List? _image;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  //Adding user
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser() async {
    String photoUrl = await StorageMethods()
        .uploadImageToStorage('profilePics', _image!, email);
    var hashedPw = BCrypt.hashpw(password, BCrypt.gensalt());
    return users
        .add({
          'name': name,
          'email': email,
          'password': hashedPw,
          'photoUrl': photoUrl
        })
        .then((value) => print('User Added'))
        .catchError((e) => print('Failed to Add user: $e'));
  }

  clearText() {
    setState(() {
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 53, 53, 53),
        title: const Text('Add New User'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: ListView(
            children: [
              Center(
                child: Stack(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : const CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1522252234503-e356532cafd5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=725&q=80'),
                          ),
                    Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                          onPressed: () async {
                            selectImage();
                          },
                          icon: const Icon(Icons.add_a_photo_rounded),
                        )),
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'Name: ',
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(fontSize: 15, color: Colors.red),
                  ),
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Name';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'Email: ',
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(fontSize: 15, color: Colors.red),
                  ),
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Email';
                    } else if (!value.contains('@')) {
                      return 'Please Enter Valid Email';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password: ',
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(fontSize: 15, color: Colors.red),
                  ),
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Password';
                    }
                    return null;
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 72, 71, 71),
                    ),
                    onPressed: () {
                      //validate returns true if the form is valid, otherwise false.
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          name = nameController.text;
                          email = emailController.text;
                          password = passwordController.text;
                          addUser();
                          clearText();
                        });
                      }
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 72, 71, 71),
                      ),
                      onPressed: () {
                        clearText();
                      },
                      child: const Text(
                        'Reset',
                        style: TextStyle(fontSize: 18.0),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
