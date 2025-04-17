import 'dart:ffi';
import 'dart:io';

import 'package:crud_based/features/user_auth/presentation/pages/dashboard.dart';
import 'package:crud_based/features/user_auth/presentation/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetching and populating user data when the HomePage is created
    _fetchAndPopulateUserData();
  }

  @override
  Widget build(BuildContext context) {
    _fetchAndPopulateUserData();
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(" Your Profile"),
        actions: [
          IconButton(
            onPressed: () {
              _signOut(context);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Circle Avatar to display the picture

            Center(
              child: Text(
                "Update Your Profile!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _userNameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _updateUserData();
              },
              child: Text('Update'),
            ),
            SizedBox(height: 20),
            Text(
              'You may set up your phone number and username during the initial setup. '
              'For updating your profile info from the second time and onwards, please click the button below',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _launchEmailApp();
              },
              child: Text('Request Profile Update'),
            ),
          ],
        ),
      ),
    );
  }

  void _fetchAndPopulateUserData() async {
    try {
      // Getting the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Retrieving user data from Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .get();

        // Updating the controllers with the retrieved data
        if (userDoc.exists) {
          setState(() {
            _emailController.text = userDoc['email'];
            _passwordController.text = userDoc['password'];
            _phoneNumberController.text = userDoc['phoneNumber'];
            _userNameController.text = userDoc['userName'];
          });
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  void _updateUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String uid = user.uid;

        // Creating a map with the updated data
        Map<String, dynamic> updatedData = {
          'email': _emailController.text,
          'password': _passwordController.text,
          'phoneNumber': _phoneNumberController.text,
          'userName': _userNameController.text,
        };

        // Updating the user data in Firestore
        await FirebaseFirestore.instance
            .collection('user')
            .doc(uid)
            .update(updatedData);

        _showSnackBar('Data Updated Successfully!');

        // Redirecting back to the predecessor page
        Navigator.pop(context);
      }
    } catch (e) {
      print('Error updating user data: $e');
      _showSnackBar('Error updating user data');
    }
  }

  void _signOut(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => DashboardPage()),
      (route) => false,
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _launchEmailApp() async {
    const email = 'prabin.timilsina14@gmail.com';
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
    );

    final Uri emailLaunchUri = Uri(
      scheme: params.scheme,
      path: params.path,
    );

    if (await canLaunch(emailLaunchUri.toString())) {
      await launch(emailLaunchUri.toString());
    } else {
      _showSnackBar('Could not launch email app');
    }
  }
}
