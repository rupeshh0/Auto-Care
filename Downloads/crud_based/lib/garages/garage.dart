import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class Garage extends StatefulWidget {
  const Garage({Key? key}) : super(key: key);

  @override
  State<Garage> createState() => _GarageState();
}

class _GarageState extends State<Garage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Garage Details'),
      ),
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('garage').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              var documents = snapshot.data!.docs;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (int i = 0; i < documents.length; i++)
                    ContactCard(
                      garageNumber: i + 1,
                      documentId: documents[i].id,
                      contactNumber: documents[i]['number'],
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class ContactCard extends StatefulWidget {
  final int garageNumber;
  final String documentId;
  final String contactNumber;

  const ContactCard({
    Key? key,
    required this.garageNumber,
    required this.documentId,
    required this.contactNumber,
  }) : super(key: key);

  @override
  _ContactCardState createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  TextEditingController _garageNameController = TextEditingController();
  TextEditingController _ownerNameController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _contactNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _fetchAndPopulateGarageData();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          _launchPhoneApp(widget.contactNumber);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Garage ${widget.garageNumber}',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 8.0),
              TextField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location'),
                enabled: false,
              ),
              SizedBox(height: 8.0),
              TextField(
                controller: _garageNameController,
                decoration: InputDecoration(labelText: 'Garage Name'),
                enabled: false,
              ),
              SizedBox(height: 8.0),
              TextField(
                controller: _contactNumberController,
                decoration: InputDecoration(labelText: 'Contact Number'),
                keyboardType: TextInputType.phone,
                enabled: false,
              ),
              SizedBox(height: 8.0),
              TextField(
                controller: _ownerNameController,
                decoration: InputDecoration(labelText: 'Owner Name'),
                enabled: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _fetchAndPopulateGarageData() async {
    try {
      DocumentSnapshot garageDoc = await FirebaseFirestore.instance
          .collection('garage')
          .doc(widget.documentId)
          .get();

      if (garageDoc.exists) {
        setState(() {
          _locationController.text = garageDoc['location'];
          _garageNameController.text = garageDoc['name'];
          _contactNumberController.text = garageDoc['number'];
          _ownerNameController.text = garageDoc['owner'];
        });
      }
    } catch (e) {
      print("Error fetching garage data: $e");
    }
  }

  void _launchPhoneApp(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not Launch $url');
    }
  }
}
