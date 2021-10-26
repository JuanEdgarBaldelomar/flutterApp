import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:http/http.dart" as http;
import 'package:fluttertoast/fluttertoast.dart';

class PatientLogin extends StatefulWidget {
  const PatientLogin({Key? key}) : super(key: key);

  _PatientLogin createState() => _PatientLogin();
}

class _PatientLogin extends State<PatientLogin> {
  static const int OK = 200;

  late String _patientName, _patientLoggedId;
  late String patientId, patientName, patientPassword;
  var patientIdInput = TextEditingController();
  var patientPasswordInput = TextEditingController();

  @override
  void initState() {
    _patientName = "";
    _patientLoggedId = "";
    patientId = "";
    patientName = "";
    super.initState();
  }

  makeLogin() async {
    String apiUrl =
        "http://localhost:8888/webApi/index.php?option=loginPatient";

    var response = await http.post(Uri.parse(apiUrl),
        body: {'patientId': patientId, 'patientPassword': patientPassword});

    if (response.statusCode == OK) {
      var jsonData = json.decode(response.body);

      if (jsonData["patientId"] != patientId) {
        Fluttertoast.showToast(
            msg: "Identificador usuari incorrecte",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0);
      } else if (jsonData["patientPassword"] == "true") {
        _patientName = jsonData["patientName"];
        _patientLoggedId = jsonData["patientId"];
        Fluttertoast.showToast(
            msg: "User logged",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.blueGrey,
            fontSize: 16.0);
      } else if (jsonData["patientPassword"] == "false") {
        Fluttertoast.showToast(
            msg: "Contrasenya Incorrecta",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0);
      }
    } else if (response.statusCode != OK) {
      Fluttertoast.showToast(
          msg: "Error en la connexió",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.red,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  'Planificació Cognitiva',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20.0,
                      color: Colors.blue),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: patientIdInput,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nº Historial Clínic',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.alternate_email_sharp),
                  ),
                  onChanged: (value) {
                    patientId = value;
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: patientPasswordInput,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: 'Número Telèfon',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone),
                  ),
                  onChanged: (value) {
                    patientPassword = value;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      makeLogin();
                    },
                    color: Colors.blue,
                    child: Text(
                      'Iniciar Sessió',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
