import 'package:flutter/material.dart';
import 'package:medrec/Pages/patient_home_page.dart';

class CookieDetail extends StatelessWidget {
  final doctor;

  CookieDetail({this.doctor});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF545D68)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('MedLiv',
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 20.0,
                color: Color(0xFF545D68))),
        actions: <Widget>[
          IconButton(
            icon:
                const Icon(Icons.notifications_none, color: Color(0xFF545D68)),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(children: [
        const SizedBox(height: 15.0),
        const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text('Details',
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 42.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF17532))),
        ),
        const SizedBox(height: 15.0),
        Hero(
            tag: doctor.profile,
            child: Image.asset(doctor.profile,
                height: 150.0, width: 100.0, fit: BoxFit.contain)),
        const SizedBox(height: 20.0),
        Center(
          child: Text('${doctor.rating}★',
              style: const TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF17532))),
        ),
        const SizedBox(height: 10.0),
        Center(
          child: Text(doctor.name,
              style: const TextStyle(
                  color: Color(0xFF575E67),
                  fontFamily: 'Varela',
                  fontSize: 24.0)),
        ),
        const SizedBox(height: 20.0),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 50.0,
            child: Text(
                "${doctor.name} a Homeopath, ${doctor.speciality} specialist having multispeciality clinics in Mira Road, Kandivali and Andheri in Mumbai and has an experience of 16 years in these fields. Dr. Rupesh Singh practices at Dr. Singh's Advanced Homeopathy Clinic in Mira Road, Mumbai, Dr. Singh's Advanced Homeopathy Clinic (Kandivali) in Kandivali East, Mumbai and Dr. Singh's Advanced Homeopathy Clinic in Andheri West, Mumbai. He completed BHMS from MUHS in 2000.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 16.0,
                    color: Color(0xFFB4B8B9))),
          ),
        ),
        const SizedBox(height: 20.0),
        Center(
            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PatientHomePage()));
                },
                child: Container(
                    width: MediaQuery.of(context).size.width - 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: const Color(0xFFF17532)),
                    child: const Center(
                        child: Text(
                      'Get Prescription',
                      style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )))))
      ]),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: Color(0xFFF17532),
      //   child: Icon(Icons.fastfood),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: BottomBar(),
    );
  }
}
