import 'package:flutter/material.dart';

class PopScreen extends StatelessWidget {
  const PopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD8D6D6),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 19),
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
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 19),
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Security suggestions',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 20),
                  leading: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.donut_small,
                      color: Color(0xffFF6600),
                      size: 20,
                    ),
                  ),
                  title: const Text(
                    'Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit ut\naliquam, purus sit amet',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 20),
                  leading: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.donut_small,
                      color: Color(0xffFF6600),
                      size: 20,
                    ),
                  ),
                  dense: true,
                  title: const Text(
                    'Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit ut\naliquam, purus sit amet',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
