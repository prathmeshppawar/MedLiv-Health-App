import 'package:flutter/material.dart';
import 'package:medrec/routes/cancerInput.dart';
import 'package:medrec/routes/diabetesInput.dart';
import 'package:medrec/routes/heartInput.dart';
import 'package:medrec/routes/kidneyInput.dart';
import 'package:medrec/widgets/bottom_nav.dart';
import '../../Navbar.dart';
import '../../core/color.dart';
import '../../data/category_model.dart';
import '../../data/plant_data.dart';
import '../page/details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController controller = PageController();
  @override
  void initState() {
    controller = PageController(viewportFraction: 0.6, initialPage: 0);
    super.initState();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    void executeCommand(String cmd) {
      switch (cmd) {
        case 'Diabetes':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const DiabetesInput()));
          break;
        case 'Heart':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HeartInput()));
          break;
        case 'Kidney':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const KidneyInput()));
          break;
        case 'Breast Cancer':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CancerInput()));
          break;
      }
    }

    return Scaffold(
      key: _key,
      backgroundColor: white,
      drawer: const Navbar(),
      appBar: AppBar(
        title: const Text('MedLiv'),
        elevation: 0,
        backgroundColor: white,
        foregroundColor: black,
        automaticallyImplyLeading: false,
        leadingWidth: 40,
        leading: TextButton(
          onPressed: () {
            _key.currentState!.openDrawer();
          },
          child: Image.asset(
            'assets/icons/menu.png',
          ),
        ),
        actions: [
          Container(
            height: 40.0,
            width: 40.0,
            margin: const EdgeInsets.only(right: 20, top: 10, bottom: 5),
            decoration: BoxDecoration(
              color: green,
              boxShadow: [
                BoxShadow(
                  color: green.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 0),
                ),
              ],
              borderRadius: BorderRadius.circular(10.0),
              image: const DecorationImage(
                image: AssetImage('assets/images/pro.png'),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              child: Row(
                children: [
                  Container(
                    height: 45.0,
                    width: 300.0,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: white,
                      border: Border.all(color: green),
                      boxShadow: [
                        BoxShadow(
                          color: green.withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 0),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          height: 45,
                          width: 250,
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search',
                            ),
                          ),
                        ),
                        Image.asset(
                          'assets/icons/search.png',
                          height: 25,
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 10),
                  Container(
                    height: 45.0,
                    width: 45.0,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: green,
                      boxShadow: [
                        BoxShadow(
                          color: green.withOpacity(0.5),
                          blurRadius: 10,
                          offset: const Offset(0, 0),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.asset(
                      'assets/icons/adjust.png',
                      color: white,
                      height: 25,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 35.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (int i = 0; i < categories.length; i++)
                    GestureDetector(
                      onTap: () {
                        setState(() => selectId = categories[i].id);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            categories[i].name,
                            style: TextStyle(
                              color: selectId == i
                                  ? green
                                  : black.withOpacity(0.7),
                              fontSize: 16.0,
                            ),
                          ),
                          if (selectId == i)
                            const CircleAvatar(
                              radius: 3,
                              backgroundColor: green,
                            )
                        ],
                      ),
                    )
                ],
              ),
            ),
            SizedBox(
              height: 320.0,
              child: PageView.builder(
                itemCount: plants.length,
                controller: controller,
                physics: const BouncingScrollPhysics(),
                padEnds: false,
                pageSnapping: true,
                onPageChanged: (value) => setState(() => activePage = value),
                itemBuilder: (itemBuilder, index) {
                  bool active = index == activePage;
                  return slider(active, index);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular',
                    style: TextStyle(
                      color: black.withOpacity(0.7),
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  Image.asset(
                    'assets/icons/more.png',
                    color: green,
                    height: 30,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 130.0,
              child: ListView.builder(
                itemCount: populerPlants.length,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(left: 20.0),
                scrollDirection: Axis.horizontal,
                itemBuilder: (itemBuilder, index) {
                  return InkWell(
                    child: Container(
                      margin: const EdgeInsets.only(right: 20, bottom: 10),
                      decoration: BoxDecoration(
                        color: lightGreen,
                        boxShadow: [
                          BoxShadow(
                            color: green.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(40.0),
                                child: Image.asset(
                                  populerPlants[index].imagePath,
                                  width: 70,
                                  height: 70,
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${populerPlants[index].name} Prediction',
                                    style: TextStyle(
                                        color: black.withOpacity(0.7),
                                        fontWeight: FontWeight.w800,
                                        fontSize: 15),
                                  ),
                                ],
                              )
                            ],
                          ),
                          // Positioned(
                          //   right: 20,
                          //   bottom: 20,
                          //   child: CircleAvatar(
                          //     backgroundColor: green,
                          //     radius: 15,
                          //     child: Image.asset(
                          //       'assets/icons/add.png',
                          //       color: white,
                          //       height: 15,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    onTap: () {
                      executeCommand(populerPlants[index].name);
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  AnimatedContainer slider(active, index) {
    double margin = active ? 20 : 30;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
      margin: EdgeInsets.all(margin),
      child: mainPlantsCard(index),
    );
  }

  Widget mainPlantsCard(index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (builder) => DetailsPage(plant: plants[index]),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: white,
          boxShadow: [
            BoxShadow(
              color: black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(5, 5),
            ),
          ],
          border: Border.all(color: green, width: 2),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: lightGreen,
                boxShadow: [
                  BoxShadow(
                    color: black.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(5, 5),
                  ),
                ],
                borderRadius: BorderRadius.circular(25.0),
                image: DecorationImage(
                  image: AssetImage(plants[index].imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Positioned(
            //   right: 8,
            //   top: 8,
            //   child: CircleAvatar(
            //     backgroundColor: green,
            //     radius: 15,
            //     child: Image.asset(
            //       'assets/icons/add.png',
            //       color: white,
            //       height: 15,
            //     ),
            //   ),
            // ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  plants[index].name,
                  style: TextStyle(
                    color: black.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  int selectId = 0;
  int activePage = 0;
}
