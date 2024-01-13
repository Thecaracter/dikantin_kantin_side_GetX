import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModalService {
  static Future<void> showModal(BuildContext context) async {
    final TextEditingController _usernameController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    File? _image;

    Future<void> _updateProfile() async {
      final url = Uri.parse('http://10.10.0.61/api/updateprofile');
      final request = http.MultipartRequest('POST', url);
      dynamic prefs = await SharedPreferences.getInstance();
      String _idUser = prefs.getString('id_user');
      request.fields['id'] = _idUser;
      request.fields['username'] = _usernameController.text;
      if (_image != null) {
        request.files.add(http.MultipartFile(
            'foto', _image!.readAsBytes().asStream(), _image!.lengthSync(),
            filename: _image!.path.split("/").last));
      }

      try {
        final response = await request.send();
        final responseData = json.decode(await response.stream.bytesToString());

        if (response.statusCode == 200) {
          // handle success response
          print(responseData['message']);
          print(responseData['data']);
        } else {
          // handle error response
          print(responseData['errors']);
        }
      } catch (error) {
        // handle network or server errors
        print(error);
      }
    }

    Future<void> _getImageFromGallery() async {
      if (_image != null) {
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Replace photo?'),
            content: Text(
                'You have already selected a photo. Do you want to replace it?'),
            actions: [
              TextButton(
                child: Text('No'),
                onPressed: () => Navigator.pop(context, false),
              ),
              ElevatedButton(
                child: Text('Yes'),
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          ),
        );

        if (confirmed != true) {
          return;
        }
      }

      final pickedFile =
          await ImagePicker().getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    }

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Dialog(
            backgroundColor: Color.fromARGB(210, 255, 255, 255),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 16.0),
                    GestureDetector(
                      onTap: () {
                        _getImageFromGallery();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                _image == null
                                    ? 'Pilih Foto'
                                    : 'Foto telah dipilih',
                                style: TextStyle(
                                  color: Color.fromARGB(236, 81, 77, 78),
                                  fontSize: 16.0,
                                ),
                              ),
                              Icon(Icons.photo, color: Colors.grey[700]),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        fillColor: Colors.grey[750],
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Silahkan Masukan username Anda.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ElevatedButton(
                          child: Text('Batal'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[700],
                            textStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          child: Text('Ubah'),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _updateProfile();
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            textStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
