import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_based/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:crud_based/features/user_auth/presentation/pages/dashboard.dart';
import 'package:crud_based/features/user_auth/presentation/pages/home_page.dart';
import 'package:crud_based/features/user_auth/presentation/pages/sign_up_page.dart';
import 'package:crud_based/features/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:crud_based/future_scope/manager.dart';
import 'package:crud_based/global/common/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _userUid = ""; // Storing the UID in the LoginPage

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              FormContainerWidget(
                controller: _emailController,
                hintText: "Email",
                isPasswordField: false,
                onChanged: (password) {},
              ),
              SizedBox(height: 10),
              FormContainerWidget(
                controller: _passwordController,
                hintText: "Password",
                isPasswordField: true,
                onChanged: (password) {},
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () => _signIn(context),
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: _isSigning
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                        (route) => false,
                      );
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(""),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigating to the 'Manager' page when the button is clicked
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ManagerPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // Setting the button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Garage Owners',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signIn(BuildContext context) async {
    setState(() {
      _isSigning = true;
    });
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      print("User is successfully Signed In. UID: ${user.uid}");
      showToast(message: "User is successfully Signed In");

      //Checking if user data exists in firestore user collection
      bool isUserDataExists = await _checkUserDataExists(user.uid);

      if (!isUserDataExists) {
        // If user data doesn't exist, adding a new document to the 'user' collection
        await _addUserDataToFirestore(user.uid, email, password);
      }

      // Storing the UID in the LoginPage
      setState(() {
        _userUid = user.uid;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage()),
      );
    } else {
      showToast(message: "Some error occurred");
    }
  }

  Future<bool> _checkUserDataExists(String uid) async {
    try {
      // Checking if user data exists in Firestore 'user' collection
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('user').doc(uid).get();
      return userDoc.exists;
    } catch (e) {
      print("Error checking user data: $e");
      return false;
    }
  }

  Future<void> _addUserDataToFirestore(
      String uid, String email, String password) async {
    try {
      // Adding a new document to Firestore 'user' collection
      await FirebaseFirestore.instance.collection('user').doc(uid).set({
        'email': email,
        'password': password,
      });
    } catch (e) {
      print("Error adding user data to Firestore: $e");
    }
  }
}
