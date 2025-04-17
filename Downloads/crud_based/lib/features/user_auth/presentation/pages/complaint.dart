import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class ComplaintPage extends StatefulWidget {
  final String uid; // Passing the UID from the login page

  ComplaintPage({required this.uid});

  @override
  _ComplaintPageState createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  File? _image;
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File a Complaint"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: _isSubmitting ? null : () => _pickImage(),
                // Disabling the button if submitting is in progress
                child: _isSubmitting
                    ? CircularProgressIndicator()
                    : Text("Upload a Picture"),
              ),
              SizedBox(height: 16.0),
              _image != null
                  ? Image.file(
                      _image!,
                      height: 100.0,
                    )
                  : Container(),
              SizedBox(height: 16.0),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Garage/Mechanic Name'),
              ),
              SizedBox(height: 16.0),
              Text(
                'Date: ${DateFormat('yyyy-MM-dd').format(DateTime.now().toLocal())}',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: descriptionController,
                maxLines: 4,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed:
                    _isSubmitting ? null : () => _submitComplaint(context),
                // Disabling the button if submitting is in progress
                child: _isSubmitting
                    ? CircularProgressIndicator()
                    : Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  void _submitComplaint(BuildContext context) async {
    // Set _isSubmitting to true when starting the submission
    setState(() {
      _isSubmitting = true;
    });
    String name = nameController.text;
    String description = descriptionController.text;
    String currentDate =
        DateFormat('yyyy-MM-dd').format(DateTime.now().toLocal());

    if (_image != null) {
      // Uploading the image to Firebase Storage
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
          FirebaseStorage.instance.ref().child('complaint_images/$fileName');
      UploadTask uploadTask = storageReference.putFile(_image!);
      await uploadTask.whenComplete(() async {
        String imageUrl = await storageReference.getDownloadURL();

        // Save data to Firestore
        await FirebaseFirestore.instance.collection('complaint').add({
          'uid': widget.uid,
          'name': name,
          'date': currentDate,
          'description': description,
          'image_url': imageUrl,
        });

        // using imageUrl as the URL to the uploaded image
        print('Image URL: $imageUrl');
      });
    }

    print('Garage/Mechanic Name: $name');
    print('Date: $currentDate');
    print('Description: $description');

    // Set _isSubmitting back to false once submission is complete
    setState(() {
      _isSubmitting = false;
    });
    Navigator.pop(context);
  }
}
