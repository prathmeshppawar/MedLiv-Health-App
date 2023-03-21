import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import '../../core/color.dart';
// import 'dart:async';

// diabetesInput.dart: Defines a Stateful widget which takes numerical values of diabetes test and
// get diabetes risk result. Sends the numerical data given by user through HTTP POST request to REST API Endpoint.

class CancerInput extends StatefulWidget {
  const CancerInput({super.key});
  @override
  _CancerInputState createState() => _CancerInputState();
}

class _CancerInputState extends State<CancerInput> {
  late double cm, rm, rs, tm, cps, sm, cs, sym;
  String url =
      "http://127.0.0.1:5000/predict/cancer"; // This is local ip of the network on which flask server is running
  int show = -1;
  @override
  void initState() {
    sym = 0.158;
    rm = 7.75;
    cps = 0;
    tm = 24.5;
    sm = 0.052;
    cs = 0.0046;
    cm = 0;
    rs = 0.3857;
  }

  void getPredictions(double cm, double rm, double rs, double tm, double cps,
      double sm, double cs, double sym) async {
    List<double> parameters = [cm, rm, rs, tm, cps, sm, cs, sym];
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
        title: const Text('Breast Cancer Prediction'),
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
                    labelText: "Mean of Symmetry",
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
                        sym = double.parse(value);
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Mean of Concavity",
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
                        cm = double.parse(value);
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Radius of Lobes (Radius Mean)",
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
                        rm = double.parse(value);
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "SE of Concave Points",
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
                        cps = double.parse(value);
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Mean of Surface Texture",
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
                        tm = double.parse(value);
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Mean of Smoothness Levels",
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
                        sm = double.parse(value);
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "SE of Compactness",
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
                        cs = double.parse(value);
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "SE of Radius",
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
                        rs = double.parse(value);
                      });
                    }
                  },
                ),
              ),
              show == 1
                  ? const Card(
                      child: ListTile(
                        subtitle: Text("Malignant Tumor is Found",
                            style: TextStyle(
                                fontSize: 22.5,
                                fontWeight: FontWeight.w500,
                                color: Colors.red)),
                        title: Text("Cancer Tumor type",
                            style: TextStyle(
                              fontSize: 17.5,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                    )
                  : show == 0
                      ? const Card(
                          child: ListTile(
                            subtitle: Text("Benign Tumor is Found",
                                style: TextStyle(
                                    fontSize: 22.5,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green)),
                            title: Text("Cancer Tumor type",
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
                            title: Text("Cancer Tumour type",
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
          sym = sym;
          rm = rm;
          cm = cm;
          rs = rs;
          tm = tm;
          sm = sm;
          cs = cs;
          cps = cps;
          getPredictions(cm, rm, rs, tm, cps, sm, cs, sym);
        },
      ),
    );
  }
}
