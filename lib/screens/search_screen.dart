import 'package:another_flushbar/flushbar.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:roomies_app/bloc/post_bloc/event.dart';

import '../bloc/post_bloc/bloc.dart';
import '../bloc/post_bloc/state.dart';
import '../components/custom_dialog.dart';
import '../utility/user_store.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool? isLoading = false;
  AppBloc? appBloc;
  TextEditingController searchController = TextEditingController();
  int? isSelected = 1;
  String hint = 'Phone Number';
  int lines = 1;
  TextInputType? inputType;
  bool? hasSearchHappened;
  Country? selectedCountry;
  @override
  void initState() {
    super.initState();
    appBloc = BlocProvider.of<AppBloc>(context);
    inputType = TextInputType.number;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state is LoadingState || state is InitialState) {
          setState(() {
            isLoading = true;
          });
        } else if (state is CompanySearchedState) {
          setState(() {
            isLoading = false;
            hasSearchHappened = true;
          });

          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  result: state.companySearchResponse!.response!.data![0],
                );
              });
          if (state.companySearchResponse!.response!.data![0].dataset != null) {
            // Provider.of<UserStore>(context, listen: false)
            //     .mixpanel!
            //     .track('Search Action', properties: {
            //   'content': state
            //       .companySearchResponse!.response!.data![0].dataset!.content
            // });
          }
        } else if (state is LoadFailureState) {
          Flushbar(
            message: state.error,
            flushbarStyle: FlushbarStyle.GROUNDED,
            duration: const Duration(seconds: 3),
          ).show(context);

          setState(() {
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,

            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xffFF6600),
              ),
              onPressed: () {
                Navigator.of(context).pop(hasSearchHappened);
              },
            ),

            elevation: 0,
            title: Image.asset(
              'assets/soji_logo.png',
              height: 20,
            )),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // const Text(
              //   "Sojiare",
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     color: Colors.black,
              //     fontSize: 25,
              //     fontFamily: "Montserrat",
              //     fontWeight: FontWeight.w700,
              //   ),
              // ),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelected = 1;
                            hint = 'Search Phone number';
                            lines = 1;
                            inputType = TextInputType.number;
                          });
                        },
                        child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xffFF6600),
                                ),
                                borderRadius: BorderRadius.circular(5),
                                color: isSelected == 1
                                    ? const Color(0xffFF6600)
                                    : Colors.white),
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: isSelected == 1
                                      ? Colors.white
                                      : const Color(0xffFF6600),
                                  size: 18,
                                ),
                                Text(
                                  'Phone No',
                                  style: TextStyle(
                                      color: isSelected == 1
                                          ? Colors.white
                                          : Color(0xffFF6600)),
                                ),
                              ],
                            ))),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelected = 2;
                            hint = 'Email';
                            lines = 1;
                            inputType = TextInputType.emailAddress;
                          });
                        },
                        child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xffFF6600),
                                ),
                                borderRadius: BorderRadius.circular(10),
                                color: isSelected == 2
                                    ? const Color(0xffFF6600)
                                    : Colors.white),
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.mail,
                                  color: isSelected == 2
                                      ? Colors.white
                                      : const Color(0xffFF6600),
                                  size: 18,
                                ),
                                Text(
                                  'Email',
                                  style: TextStyle(
                                      color: isSelected == 2
                                          ? Colors.white
                                          : Color(0xffFF6600)),
                                ),
                              ],
                            ))),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelected = 0;
                            hint = 'Paste document text here';
                            lines = 7;
                            inputType = TextInputType.text;
                          });
                        },
                        child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xffFF6600),
                                ),
                                borderRadius: BorderRadius.circular(10),
                                color: isSelected == 0
                                    ? const Color(0xffFF6600)
                                    : Colors.white),
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SvgPicture.asset(
                                  'assets/document.svg',
                                  color: isSelected == 0
                                      ? Colors.white
                                      : const Color(0xffFF6600),
                                ),
                                Text(
                                  'Documents',
                                  style: TextStyle(
                                      color: isSelected == 0
                                          ? Colors.white
                                          : Color(0xffFF6600)),
                                ),
                              ],
                            ))),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  isSelected==1? Expanded(
                    flex: 3,
                    child: GestureDetector(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode: true,
                          countryListTheme: CountryListThemeData(
                            flagSize: 25,
                            backgroundColor: Colors.white,
                            textStyle: const TextStyle(
                                fontSize: 16, color: Colors.blueGrey),
                            bottomSheetHeight:
                            600, // Optional. Country list modal height
                            //Optional. Sets the border radius for the bottomsheet.
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            ),
                            //Optional. Styles the search field.
                            inputDecoration: InputDecoration(
                              labelText: 'Search',
                              hintText: 'Start typing to search',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color(0xFF8C98A8)
                                      .withOpacity(0.2),
                                ),
                              ),
                            ),
                          ),
                          onSelect: (Country country) {
                            setState(() {
                              selectedCountry = country;
                            });
                          },
                        );
                      },
                      child: Container(
                        height: 60,

                        margin:
                        const EdgeInsets.only(left: 12, right: 2),
                        decoration: BoxDecoration(
                            border:
                            Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5),
                                child: Text(
                                    selectedCountry == null
                                        ? 'Country'
                                        : '+' +
                                        selectedCountry!.phoneCode,
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500)),
                              ),
                            const SizedBox(width: 2),
                              const Icon(
                                Icons.arrow_drop_down,
                                size: 20,
                                color: Color(0xffFF6600),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ):Container(),
                  Expanded(
                    flex: 8,
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextFormField(
                        controller: searchController,
                        // keyboardType: inputType,
                        style: const TextStyle(color: Colors.black),
                        minLines: lines,
                        maxLines: lines,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 25.0),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: hint,
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                              borderSide: BorderSide(color: Colors.grey)),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade300),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          hintStyle: const TextStyle(
                              color: Colors.black45,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                child: MaterialButton(
                  elevation: 10,
                  onPressed: () {
                    if(isSelected==1 && selectedCountry==null){
                      Flushbar(message: 'Please choose a country',duration: Duration(seconds: 1),).show(context);
                    }else{

                      if(isSelected==1){
                        appBloc!.add(SearchCompanyEvent(
                            data:'+'+selectedCountry!.phoneCode.toString()+ searchController.text, type: 0));
                      }
                      else{
                    appBloc!.add(SearchCompanyEvent(
                        data: searchController.text, type: 0));
                      }
                    }
                  },
                  child: isLoading!
                      ? const SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(color: Colors.white))
                      : const Text(
                          "Verify",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xfffffbfb),
                            fontSize: 16,
                            fontFamily: "Poppins",
                          ),
                        ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: const Color(0xffFF6600),
                  minWidth: double.infinity,
                  height: 55,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
