import 'package:crud_based/features/user_auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class ManagerPage extends StatelessWidget {
  const ManagerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manager Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Upcoming Requests',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),

              // Carousel Slider Section for Requests
              RequestCarousel(),
              SizedBox(height: 20),
              Text(
                'Available Mechanics',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Carousel Slider Section
              ContactCarousel(),
            ],
          ),
        ),
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
                  return ContactCard(
                    contactNumber: document['number'],
                    contactName: document['name'],
                    contactAddress: document['address'],
                    imageStoragePath: document['image_url'],
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
                    return Container(); //
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
}

class RequestCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('requests').snapshots(),
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
                  return RequestCard(
                    name: document['name'],
                    number: document['number'],
                    serviceType: document['service_type'],
                    date: document['date'],
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

class RequestCard extends StatelessWidget {
  final String name;
  final String number;
  final String serviceType;
  final String date;

  const RequestCard({
    Key? key,
    required this.name,
    required this.number,
    required this.serviceType,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Request Details',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 8.0),
            Text(
              'Name: $name',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Number: $number'),
            SizedBox(height: 8.0),
            Text('Service Type: $serviceType'),
            SizedBox(height: 8.0),
            Text('Date: $date'),
          ],
        ),
      ),
    );
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
