import 'package:flutter/material.dart';

class ProgressContent extends StatelessWidget {
  const ProgressContent({
    Key? key,
    required this.text,
    required this.icn,
  }) : super(key: key);

  final String text;
  final IconData icn;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(
            height: 80,
            width: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: const Color(0xfffffefe),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 3,
                  offset: const Offset(1, 2), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 25, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        text,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 13),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RichText(
                        text: const TextSpan(
                          text: 'Tues,',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text: '18 I 07 I 2021',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                      Icon(
                        icn,
                        color: const Color(0xffff6600),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
