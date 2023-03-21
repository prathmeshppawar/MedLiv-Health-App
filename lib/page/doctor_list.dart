import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:medrec/data/doctor_data.dart';
import 'package:medrec/page/details_page.dart';
import 'package:medrec/page/doctor_page.dart';

import '../core/color.dart';

class DoctorList extends StatefulWidget {
  const DoctorList({super.key});

  @override
  State<DoctorList> createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Our Doctors'),
          elevation: 0,
          backgroundColor: white,
          foregroundColor: black,
          leadingWidth: 40,
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1.0),
                child: ListView.builder(
                    itemCount: doctors.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (itemBuilder, index) {
                      return InkWell(
                        child: Container(
                            child: Card(
                                child: ListTile(
                          leading: Text(
                            '${doctors[index].rating.toString()}★',
                            style: const TextStyle(fontSize: 25),
                          ),
                          title: Text(doctors[index].name),
                          subtitle:
                              Text('Speciality: ${doctors[index].speciality}'),
                        ))),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CookieDetail(doctor: doctors[index])));
                          // );
                        },
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}
