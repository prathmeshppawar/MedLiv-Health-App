import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medrec/core/color.dart';

class SymptomsInput extends StatefulWidget {
  const SymptomsInput({super.key});

  @override
  State<SymptomsInput> createState() => _SymptomsInputState();
}

class _SymptomsInputState extends State<SymptomsInput> {
  List<String> patientSymptoms = [];
  late String symptom;

  List<Widget> convertToTile(List<String> symptomStrings) {
    List<Widget> symptomTile = [];
    for (int i = 0; i < symptomStrings.length; ++i) {
      symptomTile.add(Card(
        elevation: 2.5,
        child: ListTile(
          trailing: IconButton(
            icon: const FaIcon(FontAwesomeIcons.ban, color: Color(0xFFD60000)),
            onPressed: () {
              setState(() {
                symptomStrings.remove(symptomStrings[i]);
              });
            },
          ),
          title: Text(
            symptomStrings[i],
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20.5,
            ),
          ),
        ),
      ));
      symptomTile.add(const SizedBox(
        height: 3,
      ));
    }
    symptomTile.add(TextButton(
      onPressed: () {
        
      },
      child: Container(
        width: 230,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26.0),
          color: const Color(0xff3f9bfc),
          border: Border.all(width: 1.0, color: const Color(0xff3f9bfc)),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: InkWell(
          child: Text(
            "Get Medicines",
            
            style: TextStyle(
                color: Colors.white,
                fontSize: 22.5,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          ),
        ),
      ),
    ));
    return symptomTile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Medicine'),
        elevation: 0,
        backgroundColor: white,
        foregroundColor: black,
        leadingWidth: 40,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const Text(
              "Add Symptoms",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 30,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              title: TextField(
                onChanged: (value) {
                  setState(() {
                    symptom = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: "What are you feeling",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(17.5)),
                    borderSide: BorderSide(color: Color(0xFFD60000), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFD60000), width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(17.5)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFD60000), width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(17.5)),
                  ),
                ),
              ),
              subtitle: Column(
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () {
                        if (symptom.isNotEmpty) {
                          setState(() {
                            patientSymptoms.add(symptom);
                            symptom = "";
                          });
                        } else {
                          print("No symptom added");
                        }
                      },
                      child: const Text('Add Symptom'))
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            patientSymptoms.length != 0
                ? Column(
                    children: convertToTile(patientSymptoms),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text(
                        "🎉🎉🎉",
                        style: TextStyle(fontSize: 40),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "You're all fit 🙂",
                        style: TextStyle(fontSize: 40),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
