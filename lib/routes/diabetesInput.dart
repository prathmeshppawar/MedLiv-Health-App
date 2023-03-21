// ignore: file_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medrec/page/doctor_list.dart';
import 'package:http/http.dart' as http;
import '../../core/color.dart';

// diabetesInput.dart: Defines a Stateful widget which takes numerical values of diabetes test and
// get diabetes risk result. Sends the numerical data given by user through HTTP POST request to REST API Endpoint.

class DiabetesInput extends StatefulWidget {
  const DiabetesInput({super.key});
  @override
  _DiabetesInputState createState() => _DiabetesInputState();
}

class _DiabetesInputState extends State<DiabetesInput> {
  late double pregnancies, glucose, bloodPressure, skinThickness, insulin, age;
  late double diabetesPedgreeFuncion, bmi;
  String url =
      "http://127.0.0.1:5000/predict/diabetes"; // This is local ip of the network on which flask server is running
  int show = -1;
  @override
  void initState() {
    pregnancies = 0;
    glucose = 121;
    bloodPressure = 69;
    skinThickness = 20;
    insulin = 0;
    bmi = 32.0;
    age = 35;
    diabetesPedgreeFuncion = 0.47;
  }

  void getPredictions(
      double pregnancies,
      double glucose,
      double bloodPressure,
      double skinThickness,
      double insulin,
      double bmi,
      double age,
      double diabetesPedgreeFuncion) async {
    List<double> parameters = [
      pregnancies,
      glucose,
      bloodPressure,
      skinThickness,
      insulin,
      bmi,
      diabetesPedgreeFuncion,
      age
    ];
    Map<String, dynamic> args = {"parameters": parameters};
    var body = jsonEncode(args);
    http.Response response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: body);
    if (response.statusCode == 200) {
      setState(() {
        show = jsonDecode(response.body)['prediction'];
      });
    } else {
      print('A network error occurred');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diabetes Prediction'),
        elevation: 0,
        backgroundColor: white,
        foregroundColor: black,
        leadingWidth: 40,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(
                  "Enter following parameters",
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Pregnancies",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (value != "") {
                      setState(() {
                        pregnancies = double.parse(value);
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Glucose",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (value != "") {
                      setState(() {
                        glucose = double.parse(value);
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Blood Pressure",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (value != "") {
                      setState(() {
                        bloodPressure = double.parse(value);
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Skin Thickness",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (value != "") {
                      setState(() {
                        skinThickness = double.parse(value);
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Insulin",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (value != "") {
                      setState(() {
                        insulin = double.parse(value);
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "BMI",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (value != "") {
                      setState(() {
                        bmi = double.parse(value);
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Diabetes Pedigree Function",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (value != "") {
                      setState(() {
                        diabetesPedgreeFuncion = double.parse(value);
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Age",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (value != "") {
                      setState(() {
                        age = double.parse(value);
                      });
                    }
                  },
                ),
              ),
              show == 1
                  ? const Card(
                      child: ListTile(
                        subtitle: Text("High Risk",
                            style: TextStyle(
                                fontSize: 22.5,
                                fontWeight: FontWeight.w500,
                                color: Colors.red)),
                        title: Text("Your Diabetes Risk",
                            style: TextStyle(
                              fontSize: 17.5,
                              fontWeight: FontWeight.w500,
                            )),
                        
                      ),
                    )
                  : show == 0
                      ? const Card(
                          child: ListTile(
                            subtitle: Text("Low Risk",
                                style: TextStyle(
                                    fontSize: 22.5,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green)),
                            title: Text("Your Diabetes Risk",
                                style: TextStyle(
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                        )
                      : const Card(
                          child: ListTile(
                            subtitle: Text("Not Tested",
                                style: TextStyle(
                                    fontSize: 22.5,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey)),
                            title: Text("Your Diabetes Risk",
                                style: TextStyle(
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                        ),
              show == 1
                  ? ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DoctorList()));
                      },
                      child: const Text('Consult Doctors'))
                  : const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const FaIcon(FontAwesomeIcons.bookMedical),
        label: const Text("Get Results"),
        backgroundColor: Colors.green,
        onPressed: () {
          pregnancies = pregnancies;
          glucose = glucose;
          bloodPressure = bloodPressure;
          skinThickness = skinThickness;
          insulin = insulin;
          bmi = bmi;
          diabetesPedgreeFuncion = diabetesPedgreeFuncion;
          age = age;
          getPredictions(pregnancies, glucose, bloodPressure, skinThickness,
              insulin, bmi, age, diabetesPedgreeFuncion);
          // print(
          //     "$pregnancies, $glucose, $bloodPressure, $skinThickness, $insulin, $bmi, $age, $diabetesPedgreeFuncion");
        },
      ),
    );
  }
}
