import 'package:flutter/material.dart';
import 'package:simple_flutter_app/database_helper.dart';
import 'package:simple_flutter_app/display_screen.dart';
import 'package:simple_flutter_app/main.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
  String? _name;
  String? _email;
  String? _address;
  String? _phoneNumber;
  final TextEditingController _delidController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      controller: _nameController,
      decoration: const InputDecoration(
        labelText: 'Name',
        border: OutlineInputBorder(),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Name is Required';
        }

        return null;
      },
      onSaved: (String? value) {
        _name = value!;
        setState(() {
          _nameController.clear();
        });
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Email is Required';
        }

        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email Address';
        }

        return null;
      },
      onSaved: (String? value) {
        _email = value!;
        setState(() {
          _emailController.clear();
        });
      },
    );
  }

  Widget _buildAdd() {
    return TextFormField(
      controller: _addressController,
      decoration: const InputDecoration(
        labelText: 'Address',
        border: OutlineInputBorder(),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Address is Required';
        }

        return null;
      },
      onSaved: (String? value) {
        _address = value!;
        setState(() {
          _addressController.clear();
        });
      },
    );
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
      controller: _phoneController,
      decoration: const InputDecoration(
        labelText: 'Phone number',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.phone,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Phone number is Required';
        }
        if (value.length != 10) {
          return 'Mobile Number must be of 10 digit';
        }

        return null;
      },
      onSaved: (String? value) {
        _phoneNumber = value!;
        setState(() {
          _phoneController.clear();
        });
      },
    );
  }

  Widget _buildDeleteRecord() {
    return TextFormField(
      controller: _delidController,
      decoration: const InputDecoration(
        labelText: 'Row ID',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData mode = Theme.of(context);
    var whichMode = mode.brightness;
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("User Form"),
        actions: [
          IconButton(
              onPressed: () {
                FirstApp.themeNotifier.value =
                    whichMode == Brightness.light
                        ? ThemeMode.dark
                        : ThemeMode.light;
              },
              icon: Icon(whichMode == Brightness.light
                  ? Icons.dark_mode
                  : Icons.light_mode))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildName(),
                    const SizedBox(height: 10),
                    _buildEmail(),
                    const SizedBox(height: 10),
                    _buildAdd(),
                    const SizedBox(height: 10),
                    _buildPhoneNumber(),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }

                        _formKey.currentState!.save();

                        int? i = await DatabaseHelper.instance.insert({
                          DatabaseHelper.columnName: _name,
                          DatabaseHelper.columnEmail: _email,
                          DatabaseHelper.columnAddress: _address,
                          DatabaseHelper.columnPhone: _phoneNumber,
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 1),
                  _buildDeleteRecord(),
                  const SizedBox(height: 1),
                  ElevatedButton(
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onPressed: () async {
                      int? _delid = int?.parse(_delidController.text);
                      int? i = await DatabaseHelper.instance.delete(_delid);
                      _delidController.clear();
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    child: const Text(
                      'Display',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onPressed: () async {
                      List<Map<String, dynamic>> queryRows =
                          await DatabaseHelper.instance.queryAll();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DisplayScreen(queryRows: queryRows)),
                      );
                    },
                  ),
                  // ElevatedButton(
                  //     child: const Text(
                  //       'Delete DB',
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 16
                  //       ),
                  //     ),
                  //     onPressed: () async {
                  //       bool value = await DatabaseHelper.instance.deleteDb();
                  //     },
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
