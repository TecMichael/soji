import 'package:flutter/material.dart';
import 'package:roomies_app/components/register_form.dart';
import 'package:roomies_app/screens/pop_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool ischecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD8D6D6),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Sojiare",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w700,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 35),
            child: TextFormField(
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 90.0, horizontal: 25.0),
                fillColor: Colors.white,
                filled: true,
                hintText:
                    'Paste your content, email,phone number and links here to run a search',
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                    borderSide: BorderSide(color: Colors.grey)),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Column(
            children: const [
              RegisterForm(txt: 'Number'),
              SizedBox(height: 2),
              RegisterForm(txt: 'Email'),
              SizedBox(height: 2),
              RegisterForm(txt: 'Amount')
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              children: [
                Checkbox(
                  value: ischecked,
                  onChanged: (value) {
                    setState(() => ischecked = value!);
                  },
                  activeColor: Colors.black,
                  checkColor: Colors.white,
                ),
                const Text(
                  "Report",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: MaterialButton(
              elevation: 10,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)=>const PopScreen()));
              },
              child: const Text(
                "Verify",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xfffffbfb),
                  fontSize: 18,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w700,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: const Color(0xffFF6600),
              minWidth: double.infinity,
              height: 56,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
