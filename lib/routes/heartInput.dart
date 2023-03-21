import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import '../../core/color.dart';
// import 'dart:async';

// diabetesInput.dart: Defines a Stateful widget which takes numerical values of diabetes test and
// get diabetes risk result. Sends the numerical data given by user through HTTP POST request to REST API Endpoint.

class HeartInput extends StatefulWidget {
  const HeartInput({super.key});
  @override
  _HeartInputState createState() => _HeartInputState();
}

class _HeartInputState extends State<HeartInput> {
  late double ca, cp, thal, exang, thalach, oldpeak, slope, age;
  String url =
      "http://127.0.0.1:5000/predict/heart"; // This is local ip of the network on which flask server is running
  int show = -1;
  @override
  void initState() {
    age = 45;
    cp = 0;
    thalach = 120;
    exang = 0;
    oldpeak = 1.3;
    slope = 1;
    ca = 1;
    thal = 3;
  }

  void getPredictions(double ca, double cp, double thal, double exang,
      double thalach, double oldpeak, double slope, double age) async {
    List<double> parameters = [
      ca,
      cp,
      thal,
      exang,
      thalach,
      oldpeak,
      slope,
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
        title: const Text('Heart Prediction'),
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
                    labelText: "Age (In Years)",
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText:
                        "Number of Major Vessels (0-3) Colored by Flourosopy",
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
                        ca = double.parse(value);
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Chest Pain Type (0-3)",
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
                        cp = double.parse(value);
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Maximum Heart Rate Achieved",
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
                        thalach = double.parse(value);
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Exercise Induced Angina (1 = Yes, 0 = No)",
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
                        exang = double.parse(value);
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText:
                        "ST Depression Induced by Exercise Relative to Rest",
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
                        oldpeak = double.parse(value);
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "The Slope of the Peak Exercise ST Segment",
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
                        slope = double.parse(value);
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText:
                        "Thalassemia (1 = normal; 2 = fixed defect; 3 = reversable defect)",
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
                        thal = double.parse(value);
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
                        title: Text("Your Heart Risk",
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
                            title: Text("Your Heart Risk",
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
                            title: Text("Your Heart Risk",
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
          age = age;
          cp = cp;
          ca = ca;
          thal = thal;
          exang = exang;
          oldpeak = oldpeak;
          slope = slope;
          thalach = thalach;
          getPredictions(ca, cp, thal, exang, thalach, oldpeak, slope, age);
          // print(
          //     "$age, $sex, $cp, $trestbps, $chol, $fbs, $age, $restecg");
        },
      ),
    );
  }
}
