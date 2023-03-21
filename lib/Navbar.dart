// ignore_for_file: avoid_returning_null_for_void
import 'dart:io' show Platform, exit;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medrec/Pages/patient_home_page.dart';
import 'package:medrec/Utils/connector.dart';
import 'package:medrec/Utils/routes.dart';
import 'package:medrec/page/symptoms_input.dart';
import 'package:medrec/routes/cancerInput.dart';
import 'package:medrec/routes/chat_screen.dart';
import './routes/kidneyInput.dart';
import './routes/heartInput.dart';
import './routes/diabetesInput.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          // ignore: prefer_const_constructors
          UserAccountsDrawerHeader(
            accountName: const Text(
              '',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            accountEmail: const Text(''),
            decoration: const BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/sidebar.jpg')),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.library_books_outlined),
            title: const Text('Patient Records'),
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PatientHomePage()))
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.smart_toy_outlined),
            title: const Text('Chat Bot'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ChatScreen()))
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.online_prediction_outlined),
            title: const Text('Symptoms Input'),
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SymptomsInput()))
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.vaccines_outlined),
            title: const Text('Diabetes Prediction'),
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DiabetesInput()))
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.monitor_heart),
            title: const Text('Heart Prediction'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HeartInput()))
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.coronavirus_outlined),
            title: const Text('Kidney Prediction'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const KidneyInput()))
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.bookmark_border_outlined),
            title: const Text('Breast Cancer Prediction'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CancerInput()))
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Policies'),
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: const Text('Logout'),
            onTap: () {
              Connector.key = "";
              Navigator.popAndPushNamed(context, MyRoutes.loginPage);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Exit'),
            leading: const Icon(Icons.exit_to_app),
            onTap: () {
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else if (Platform.isIOS) {
                exit(0);
              }
            },
          ),
        ],
      ),
    );
  }
}
