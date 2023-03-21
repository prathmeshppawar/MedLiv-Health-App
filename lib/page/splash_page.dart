import 'package:flutter/material.dart';
import 'package:medrec/page/loginPage.dart';
import 'package:medrec/page/registratiion.dart';
import '../../core/color.dart';
import '../../widgets/bottom_nav.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(height: 25),
          const SizedBox(height: 25),
          const Text(
            'The Greatest Wealth is Health',
            style: TextStyle(
              fontSize: 22.0,
              letterSpacing: 1.8,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Bring Health Home',
            style: TextStyle(
              color: grey,
              fontSize: 16,
              letterSpacing: 1.8,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 450,
            width: 450,
            child: Image.network(
                'https://media.istockphoto.com/id/621576732/vector/medical-team-hospital-staff-vector-illustration.jpg?s=612x612&w=0&k=20&c=-ouwunIZSePve5XumMkGTB1zBRX34byPskCd-T2hQWM='),
          ),
          const SizedBox(height: 25),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => SignInPage()));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 80.0,
                vertical: 12.0,
              ),
              decoration: BoxDecoration(
                color: green,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Text(
                'Sign In',
                style: TextStyle(
                  color: white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => Registration()));
            },
            child: Text(
              'Create an account',
              style: TextStyle(
                color: black.withOpacity(0.7),
                fontSize: 16,
                letterSpacing: 1,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                color: black.withOpacity(0.4),
                letterSpacing: 1,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
