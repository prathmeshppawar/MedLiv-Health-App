import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import '../core/color.dart';
// import 'dart:async';

// diabetesInput.dart: Defines a Stateful widget which takes numerical values of diabetes test and
// get diabetes risk result. Sends the numerical data given by user through HTTP POST request to REST API Endpoint.

class KidneyInput extends StatefulWidget {
  const KidneyInput({super.key});
  @override
  _KidneyInputState createState() => _KidneyInputState();
}

class _KidneyInputState extends State<KidneyInput> {
  late double sg, hemo, htn, dm, al, appet, pc, rc;
  String url =
      "http://127.0.0.1:5000/predict/kidney"; // This is local ip of the network on which flask server is running
  int show = -1;
  @override
  void initState() {
    sg = 1.025;
    hemo = 15.7;
    htn = 0;
    dm = 0;
    al = 0;
    appet = 1;
    pc = 0;
    rc = 4.9;
  }

  void getPredictions(double sg, double hemo, double htn, double dm, double al,
      double appet, double pc, double rc) async {
    List<double> parameters = [sg, hemo, htn, dm, al, appet, pc, rc];
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
        title: const Text('Kidney Prediction'),
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
                    labelText: "Specific Gravity",
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
                        sg = double.parse(value);
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Heamoglobin",
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
                        hemo = double.parse(value);
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Hypertension (1 for Yes, 0 for No)",
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
                        htn = double.parse(value);
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Diabetes Mellitus (0 for No, 1 for Yes)",
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
                        dm = double.parse(value);
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Albumin (0-5)",
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
                        al = double.parse(value);
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Appetite (1 for Good, 0 for Poor)",
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
                        appet = double.parse(value);
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Pus Cell (0 for Normal, 1 for Abnormal)",
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
                        pc = double.parse(value);
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Red Blood Cells Count",
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
                        rc = double.parse(value);
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
                        title: Text("Your Kidney Risk",
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
                            title: Text("Your Kidney Risk",
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
                            title: Text("Your Kidney Risk",
                                style: TextStyle(
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                        ),
              const SizedBox(height: 100)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const FaIcon(FontAwesomeIcons.bookMedical),
        label: const Text("Get Results"),
        onPressed: () {
          sg = sg;
          hemo = hemo;
          htn = htn;
          dm = dm;
          al = al;
          appet = appet;
          pc = pc;
          rc = rc;
          getPredictions(sg, hemo, htn, dm, al, appet, pc, rc);
          // print(
          //     "$sg, $hemo, $htn, $dm, $al, $appet, $age, $pc");
        },
      ),
    );
  }
}
