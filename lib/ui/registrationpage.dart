import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rest_api_conduit_app/blocs/signup/bloc/sign_up_bloc.dart';
import 'package:rest_api_conduit_app/models/authmodel.dart';
import 'package:rest_api_conduit_app/ui/loginpage.dart';

import '../intl/appcolor.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController emailCTR = TextEditingController();
  TextEditingController usernameCTR = TextEditingController();
  TextEditingController passwordCTR = TextEditingController();
  TextEditingController bioCTR = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  bool ischecked = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpLoading) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('data is in process')));
              setState(() {
                isLoading = true;
              });
            }
            if (state is SignUpErrorState) {
              final geterror = state as SignUpErrorState;
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('${geterror.error}')));
              setState(() {
                isLoading = false;
              });
            }
            if (state is SignUpLoaded) {
              final success = state as SignUpLoaded;
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('${success.masg}')));

              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoginPage();
              }));
            }
            if (state is SignUponNoInternet) {
              final nointernet = state as SignUponNoInternet;
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('${nointernet.net}')));
              setState(() {
                isLoading = false;
              });
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        height: 200,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 260.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, -5),
                                    blurRadius: 4,
                                    color: Colors.white.withOpacity(0.6))
                              ],
                              color: Color.fromRGBO(186, 104, 200, 0.95),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25))),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 38,
                                ),
                                Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          inputFormatters: [
                                            FilteringTextInputFormatter.deny(RegExp(
                                                r'\s')), // Deny whitespace (spaces)
                                          ],
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Enter username";
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: usernameCTR,
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: 20,
                                              ),
                                              hintText: "username",
                                              hintStyle: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.40)),
                                              prefixIcon: Icon(
                                                Icons.person,
                                                color: Color.fromARGB(
                                                    255, 101, 5, 139),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50))),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          inputFormatters: [
                                            FilteringTextInputFormatter.deny(RegExp(
                                                r'\s')), // Deny whitespace (spaces)
                                          ],
                                          validator: (value) {
                                            // Check if this field is empty
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Enter email';
                                            }

                                            // using regular expression
                                            if (!RegExp(
                                                    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                                                .hasMatch(value)) {
                                              return "Please enter a valid email address";
                                            }

                                            // the email is valid
                                            return null;
                                          },
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          controller: emailCTR,
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: 20,
                                              ),
                                              hintText: "Email",
                                              hintStyle: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.40)),
                                              prefixIcon: Icon(
                                                Icons.email,
                                                color: Color.fromARGB(
                                                    255, 101, 5, 139),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50))),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(
                                                16),
                                            FilteringTextInputFormatter.deny(RegExp(
                                                r'\s')), // Deny whitespace (spaces)
                                          ],
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Enter password";
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: passwordCTR,
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: 20,
                                              ),
                                              hintText: "Password",
                                              hintStyle: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.40)),
                                              prefixIcon: Icon(
                                                Icons.lock,
                                                color: Color.fromARGB(
                                                    255, 101, 5, 139),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50))),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: AppColor.lightgray2,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: TextFormField(
                                            keyboardType: TextInputType.name,
                                            controller: bioCTR,
                                            maxLines: 4,
                                            decoration:
                                                InputDecoration.collapsed(
                                                    hintStyle: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 0.40)),
                                                    hintText: 'Enter text...'),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        ListTile(
                                          leading: Transform.scale(
                                            scale: 1.5,
                                            child: Checkbox(
                                                value: ischecked,
                                                onChanged: (value) {
                                                  setState(() {
                                                    ischecked = value!;
                                                  });
                                                }),
                                          ),
                                          title: Text(
                                            "I Agree to the Terms nad Conditions, Privacy Policy & Medical Disclaimer",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        SizedBox(
                                          width: 220,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                FocusScopeNode currentFocus =
                                                    FocusScope.of(context);
                                                if (!currentFocus
                                                    .hasPrimaryFocus) {
                                                  currentFocus.unfocus();
                                                }
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  context.read<SignUpBloc>()
                                                    ..add(
                                                      SignUPSubmitEvent(
                                                        signup: AuthModel(
                                                            email:
                                                                emailCTR.text,
                                                            username:
                                                                usernameCTR
                                                                    .text,
                                                            password:
                                                                passwordCTR
                                                                    .text,
                                                            bio: bioCTR.text),
                                                      ),
                                                    );
                                                }
                                              },
                                              child: Text(
                                                "SignUp",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromRGBO(
                                                        131, 49, 145, 0.9)),
                                              )),
                                        ),
                                        SizedBox(
                                          height: 21,
                                        ),
                                        Container(
                                          width: 267,
                                          height: 1,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 21,
                                        ),
                                        Text(
                                          "OR",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                      ],
                                    )),
                                SizedBox(
                                  height: 29,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/images/facebook-f.png"),
                                      ),
                                      CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/images/google (1).png"),
                                      ),
                                      CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/images/twitter.png"),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SvgPicture.asset("assets/images/Vector 2.svg"),
                      Padding(
                        padding: const EdgeInsets.only(top: 60.0, right: 20),
                        child: Row(
                          children: [
                            Spacer(),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(186, 104, 200, 0.95)),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 101.0, left: 44),
                        child: Row(
                          children: [
                            Text(
                              "SignUp",
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.w700),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
