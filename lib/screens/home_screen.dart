//step1:Creating firestore instance//
// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_first_app/services/auth_service.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  final String title;
  HomeScreen({Key? key, required this.title}) : super(key: key);

  //step2:Creating firestore instance//
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
          actions: [
            TextButton.icon(
                onPressed: () async {
                  await AuthService().logOut(context);
                },
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: TextButton.styleFrom(primary: Colors.white)),
          ],
        ),
        body: Center(
          child: SizedBox(
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      //step3:Creating collectionReference//
                      CollectionReference users = firestore.collection('users');
                      //step4:Adding data in Map format(key:value)//
                      await users.add({
                        'name':'Radifa'
                      });

                      //to set your own docName//
                      // await users.doc('fruit').set({'name': 'Mango'});
                    },
                    child: const Text('Add Data to Firestore')),
                ElevatedButton(
                    onPressed: () async {
                      CollectionReference users = firestore.collection('users');
                      //to get the output of users(collection)//
                      // QuerySnapshot allResults = await users.get();
                      // for (var result in allResults.docs) {
                      //   print(result.data());
                      // }

                      //Read data from a specific doc of the collection of DB//
                      DocumentSnapshot result = await users.doc('fruit').get();
                      print(result.data());

                      //realtiem data changing as stream//
                      // users.doc('fruit').snapshots().listen((result) {
                      //   print(result.data());
                      // });
                    },
                    child: const Text('Read Data from DB')),

                //to update data//
                ElevatedButton(
                    onPressed: () async {
                      await firestore
                          .collection('users')
                          .doc('fruit')
                          .update({
                            'name':'Guava'
                          });
                    },
                    child: const Text('Update Data')),

                ElevatedButton(
                    onPressed: () async {
                      await firestore
                          .collection('users')
                          .doc('fruit')
                          .delete();
                    },
                    child: const Text('Delete Data')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
