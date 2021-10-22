
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:http/http.dart" as http;


class PatientLogin extends StatefulWidget{

  const PatientLogin({Key ? key}) : super (key : key);

  _PatientLogin createState() =>  _PatientLogin();

}




class _PatientLogin extends State<PatientLogin>{



  late String _patientId, _patientName;
  var patientIdInput = TextEditingController();
  var patientPasswordInput = TextEditingController();

  @override
  void initState(){

    _patientId = "";
    _patientName = "";
    super.initState();

  }

  makeLogin() async {

    String URL = "http://localhost:8888/webApi/index.php?option=loginPatient";

    var response = await http.post

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
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nº Historial Clínic',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.alternate_email_sharp),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Número Telèfon',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone),
                  ),
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
                    onPressed: () => print("Succesful Login"),
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