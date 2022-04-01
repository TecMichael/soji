import 'package:flutter/material.dart';
import 'package:roomies_app/screens/search_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD8D6D6),
      body: Padding(
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
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
