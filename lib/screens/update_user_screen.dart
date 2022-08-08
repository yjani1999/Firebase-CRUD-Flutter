// ignore_for_file: avoid_print

import 'dart:typed_data';

import 'package:bcrypt/bcrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/storage_methods.dart';
import '../utils/utils.dart';

class UpdateUserScreen extends StatefulWidget {
  final String id;
  final String photoUrl;
  const UpdateUserScreen({Key? key, required this.id, required this.photoUrl})
      : super(key: key);

  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  final _formKey = GlobalKey<FormState>();
  Uint8List? _image;

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  //Updating user
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> updateUser(id, name, email, password) async {
    String photoUrl = await StorageMethods()
        .uploadImageToStorage('profilePics', _image!, email);
    var hashedPw = BCrypt.hashpw(password, BCrypt.gensalt());
    return users
        .doc(id)
        .update({
          'name': name,
          'email': email,
          'password': hashedPw,
          'photoUrl': photoUrl
        })
        .then((value) => print('User Updated'))
        .catchError((e) => print('Failed to update user: $e'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Update User'),
      ),
      body: Form(
        key: _formKey,
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(widget.id)
              .get(),
          builder: (_, snapshot) {
            if (snapshot.hasError) {
              print('Something is wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var data = snapshot.data!.data();
            var name = data!['name'];
            var email = data['email'];
            var password = data['password'];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                            : CircleAvatar(
                                radius: 64,
                                backgroundImage: NetworkImage(widget.photoUrl),
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
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: TextFormField(
                      initialValue: name,
                      autofocus: false,
                      decoration: const InputDecoration(
                        labelText: 'Name: ',
                        labelStyle: TextStyle(fontSize: 20),
                        border: OutlineInputBorder(),
                        errorStyle: TextStyle(fontSize: 15, color: Colors.red),
                      ),
                      onChanged: (value) {
                        name = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: TextFormField(
                      autofocus: false,
                      initialValue: email,
                      decoration: const InputDecoration(
                        labelText: 'Email: ',
                        labelStyle: TextStyle(fontSize: 20),
                        border: OutlineInputBorder(),
                        errorStyle: TextStyle(fontSize: 15, color: Colors.red),
                      ),
                      onChanged: (value) {
                        email = value;
                      },
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
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: TextFormField(
                      autofocus: false,
                      obscureText: true,
                      initialValue: password,
                      decoration: const InputDecoration(
                        labelText: 'Password: ',
                        labelStyle: TextStyle(fontSize: 20),
                        border: OutlineInputBorder(),
                        errorStyle: TextStyle(fontSize: 15, color: Colors.red),
                      ),
                      onChanged: (value) {
                        password = value;
                      },
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
                        onPressed: () {
                          //validate returns true if the form is valid, otherwise false.
                          if (_formKey.currentState!.validate()) {
                            updateUser(widget.id, name, email, password);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text(
                          'Update',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            'Reset',
                            style: TextStyle(fontSize: 18.0),
                          )),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ));
  }
}
