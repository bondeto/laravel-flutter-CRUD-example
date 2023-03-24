import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mob2/main.dart';

// ignore: camel_case_types
class createProduk extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  TextEditingController _hargaController = TextEditingController();

  createProduk({super.key});

  Future SaveProduk() async {
    final response =
        await http.post(Uri.parse('http://10.0.2.2:8000/api/produk'), body: {
      'name': _nameController.text,
      'deskripsi': _deskripsiController.text,
      'harga': _hargaController.text,
      'image_url':
          'https://fastly.picsum.photos/id/280/200/300.jpg?hmac=M5LGtIQZPTGPTTmFXFcgUUV0zXG6sy-bGJ6zDZHedA0',
    });
    // ignore: avoid_print
    print(response.body);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Nama"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama harus diisi";
                  }
                },
              ),
              TextFormField(
                controller: _deskripsiController,
                decoration: InputDecoration(labelText: "Deskripsi"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Deskripsi harus diisi";
                  }
                },
              ),
              TextFormField(
                  controller: _hargaController,
                  decoration: InputDecoration(labelText: "Harga"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Harga harus diisi";
                    }
                  }),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      SaveProduk().then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyApp(),
                            ));
                      });
                    }
                    print(_nameController.text);
                  },
                  child: Text('Save'))
            ],
          ),
        ),
      ),
    );
  }
}
