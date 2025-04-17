import 'package:crud_based/features/user_auth/presentation/pages/complaint.dart';
import 'package:crud_based/features/user_auth/presentation/pages/home_page.dart';
import 'package:crud_based/features/user_auth/presentation/pages/login_page.dart';
import 'package:crud_based/garages/garage.dart';
import 'package:crud_based/garages/mechanic.dart';
import 'package:crud_based/googlemaps/current_location_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _signOut(context);
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.blue,
        child: Stack(
          children: [
            // Icon Buttons Section
            Positioned(
              top: screenHeight * 0.45,
              left: screenWidth * 0.04,
              child: _buildIconWithText(
                context,
                Icons.account_circle,
                "Profile Update",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
            ),
            Positioned(
              top: screenHeight * 0.62,
              left: screenWidth * 0.06,
              child: _buildIconWithText(
                context,
                Icons.location_on,
                "Find Garages",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CurrentLocationScreen(),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              top: screenHeight * 0.45,
              left: screenWidth * 0.48,
              child: _buildIconWithText(
                context,
                Icons.calendar_today,
                "Make Appointments",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Garage(),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              top: screenHeight * 0.62,
              left: screenWidth * 0.56,
              child: _buildIconWithText(
                context,
                Icons.phone,
                "Call Mechanic",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContactsPage()),
                  );
                },
              ),
            ),
            Positioned(
              top: screenHeight * 0.74,
              left: screenWidth * 0.5 - 55,
              child: _buildIconWithText(
                context,
                Icons.book,
                "Complaint",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ComplaintPage(
                              uid: '',
                            )),
                  );
                },
              ),
            ),

            // Carousel Slider Section
            Positioned(
              top: screenHeight * 0.01,
              left: 0,
              right: 0,
              child: ContactCarousel(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconWithText(
    BuildContext context,
    IconData iconData,
    String title,
    VoidCallback onTap,
  ) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Icon(
            iconData,
            size: 50,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
    _showSnackBar(context, "Sign out successful");
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

class ContactCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('contacts').snapshots(),
      builder: (context, snapshot) {
        try {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          var documents = snapshot.data!.docs;

          return CarouselSlider(
            options: CarouselOptions(
              height: 300.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 10,
            ),
            items: documents.map((document) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: ContactCard(
                      contactNumber: document['number'],
                      contactName: document['name'],
                      contactAddress: document['address'],
                      imageStoragePath: document['image_url'],
                    ),
                  );
                },
              );
            }).toList(),
          );
        } catch (e) {
          print('Error fetching data from firestore:$e');
          return Text('Error Fetching data. Please try again');
        }
      },
    );
  }
}

class ContactCard extends StatelessWidget {
  final String contactNumber;
  final String contactName;
  final String contactAddress;
  final String imageStoragePath;

  const ContactCard({
    Key? key,
    required this.contactNumber,
    required this.contactName,
    required this.contactAddress,
    required this.imageStoragePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          _launchPhoneApp(contactNumber);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                contactName,
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 8.0),
              FutureBuilder<Uint8List?>(
                future: _downloadImage(imageStoragePath),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Icon(Icons.error);
                  } else if (!snapshot.hasData) {
                    return Container();
                  } else {
                    return Image.memory(
                      snapshot.data!,
                      height: 100.0,
                      width: 100.0,
                      fit: BoxFit.cover,
                    );
                  }
                },
              ),
              SizedBox(height: 8.0),
              Text(
                'Contact Number: $contactNumber',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text('Address: $contactAddress'),
            ],
          ),
        ),
      ),
    );
  }

  Future<Uint8List?> _downloadImage(String imageStoragePath) async {
    try {
      Reference storageReference =
          FirebaseStorage.instance.ref().child(imageStoragePath);
      final Uint8List? data = await storageReference.getData();
      return data;
    } catch (e) {
      print('Error downloading image: $e');
      return null;
    }
  }

  void _launchPhoneApp(String phoneNumber) async {
    try {
      String url = 'tel:$phoneNumber';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        print('Could not Launch $url');
      }
    } catch (e) {
      print('Error launching phone app: $e');
    }
  }
}
