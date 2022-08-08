// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/screens/update_user_screen.dart';
import 'package:flutter/material.dart';

import '../utils/storage_methods.dart';

class ListUsersScreen extends StatefulWidget {
  const ListUsersScreen({Key? key}) : super(key: key);

  @override
  State<ListUsersScreen> createState() => _ListUsersScreenState();
}

class _ListUsersScreenState extends State<ListUsersScreen> {
  final Stream<QuerySnapshot> usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> deleteUser(id, email) async {
    await StorageMethods().removeImageFromStorage('profilePics', email);
    return users
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((e) => print('Failed to delete user: $e'));
    //print('User Deleted $id');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something Went wrong!!');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.lightBlueAccent),
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map data = document.data() as Map<String, dynamic>;
            storedocs.add(data);
            data['id'] = document.id;
          }).toList();
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Table(
              border: TableBorder.all(),
              // columnWidths: const <int, TableColumnWidth>{
              //   0: FixedColumnWidth(50),
              //   1: FixedColumnWidth(100),
              //   2: FixedColumnWidth(140),
              // },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Container(
                        color: const Color.fromARGB(255, 141, 121, 215),
                        child: const Center(
                          child: Text(
                            'Picture',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        color: const Color.fromARGB(255, 141, 121, 215),
                        child: const Center(
                          child: Text(
                            'Name',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        color: const Color.fromARGB(255, 141, 121, 215),
                        child: const Center(
                          child: Text(
                            'Email',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        color: const Color.fromARGB(255, 141, 121, 215),
                        child: const Center(
                          child: Text(
                            'Action',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                for (var i = 0; i < storedocs.length; i++) ...[
                  TableRow(
                    children: [
                      TableCell(
                        child: Center(
                          child: (storedocs[i]['photoUrl'] == null)
                              ? Container()
                              : CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      storedocs[i]['photoUrl'].toString()),
                                ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            storedocs[i]['name'],
                            style: const TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          storedocs[i]['email'],
                          style: const TextStyle(fontSize: 18.0),
                        ),
                      ),
                      TableCell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UpdateUserScreen(
                                            id: storedocs[i]['id'],
                                            photoUrl: (storedocs[i]
                                                        ['photoUrl'] !=
                                                    null)
                                                ? storedocs[i]['photoUrl']
                                                : 'https://images.unsplash.com/photo-1522252234503-e356532cafd5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=725&q=80')));
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.black87,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                deleteUser(
                                    storedocs[i]['id'], storedocs[i]['email']);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]
              ],
            ),
          );
        });
  }
}
