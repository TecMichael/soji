import 'package:flutter/material.dart';
import 'package:roomies_app/screens/search_screen.dart';

import '../components/progress_content.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD8D6D6),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SearchScreen()));
                    },
                    child: Container(
                      width: 55,
                      height: 37,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xfffbfbfb),
                      ),
                      child: const Icon(
                        Icons.search,
                        color: Colors.grey,
                        size: 26,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                height: 180,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 3,
                      offset: const Offset(3, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            children: const [
                              Text(
                                'Match',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                '20 Suspicious',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'Contents',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: const [
                          Text(
                            "johndoe@yahoo.com",
                            style: TextStyle(
                              color: Color(0xffff6600),
                              fontSize: 24,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Tuesday,  18 I 07 I 2021",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          Icon(
                            Icons.share_rounded,
                            color: Color(0xffff6600),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Icon(
                            Icons.rectangle,
                            color: Color(0xffff6600),
                            size: 15,
                          ),
                          Text('e-mail'),
                          Icon(
                            Icons.rectangle,
                            color: Color.fromARGB(255, 241, 146, 82),
                            size: 15,
                          ),
                          Text('phone'),
                          Icon(
                            Icons.rectangle,
                            color: Color.fromARGB(255, 236, 178, 140),
                            size: 15,
                          ),
                          Text('link')
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Column(
                children: const [
                  ProgressContent(
                    text: "A-Z Bank",
                    icn: Icons.phone,
                  ),
                  SizedBox(height: 14),
                  ProgressContent(
                    text: "suspicious content",
                    icn: Icons.sms_rounded,
                  ),
                  SizedBox(height: 14),
                  ProgressContent(
                    text: "content not found",
                    icn: Icons.link,
                  ),
                  SizedBox(height: 14),
                  ProgressContent(
                    text: "content not found",
                    icn: Icons.mail
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
