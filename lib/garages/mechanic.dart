import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts Details'),
      ),
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('contacts').snapshots(),
            builder: (context, snapshot) {
              try {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }

                var documents = snapshot.data!.docs;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (int i = 0; i < documents.length; i++)
                      ContactCard(
                        contactNumber: documents[i]['number'],
                        contactName: documents[i]['name'],
                        contactAddress: documents[i]['address'],
                        imageStoragePath: documents[i]['image_url'],
                      ),
                  ],
                );
              } catch (e) {
                print('Error fetching data from firestore:$e');
                return Text('Error Fetching data. Please try again');
              }
            },
          ),
        ),
      ),
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
