import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rest_api_conduit_app/blocs/login/bloc/login_bloc.dart';
import 'package:rest_api_conduit_app/models/authmodel.dart';
import 'package:rest_api_conduit_app/models/loginmodel.dart';
import 'package:rest_api_conduit_app/ui/errorpage.dart';
import 'package:rest_api_conduit_app/ui/registrationpage.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'bottomnavigationar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  bool isLoading2 = true;
  bool switchValue = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailCTR =
      TextEditingController(text: "atal@mailinator.com");
  TextEditingController passwordCTR = TextEditingController(text: "Test@123");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  toggleObscureText() {
    setState(() {
      _obsecuretext = !_obsecuretext;
    });
  }

  bool _obsecuretext = true;
  var log = "islogin";
  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('login', log);
  }

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
        body: BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
          if (state is LoginLoadingState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(duration: Duration(seconds: 2),content: Text('data is in process')));
          }
          if (state is LoginLoadedState) {
            isLoggedIn();
            print("state is LoginLoadedState ");
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return BottomNavigation(
                index: 0,
              );
            }));
          }
          if (state is LoginErrorState) {
            final geterror = state as LoginErrorState;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(duration: Duration(seconds: 2),content: Text('${geterror.error}')));
            setState(() {
              isLoading = false;
            });
          }
          if (state is LoginNoInternetState) {
            final internet = state as LoginNoInternetState;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(duration: Duration(seconds: 2),content: Text('${internet.net}')));
            setState(() {
              isLoading = false;
            });
          }
          if (state is LoginLoadedState) {
            final success = state as LoginLoadedState;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('${success.msg}')));
          }
        }, builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    SvgPicture.asset("assets/images/Vector 2.svg"),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 101.0, left: 44),
                        child: Row(
                          children: [
                            Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.w700),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
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
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 38,
                              ),
                              SizedBox(
                                height: 9,
                              ),
                              SizedBox(
                                height: 27,
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
                                          // Check if this field is empty
                                          if (value == null || value.isEmpty) {
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
                                                    BorderRadius.circular(50))),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        obscureText: _obsecuretext,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(16),
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
                                                    BorderRadius.circular(50))),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: 220,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              final FocusScopeNode
                                                  currentFocus =
                                                  FocusScope.of(context);
                                              if (!currentFocus
                                                  .hasPrimaryFocus) {
                                                currentFocus.unfocus();
                                              }
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                context.read<LoginBloc>()
                                                  ..add(
                                                    LoginsubmitEvent(
                                                      requestModel: AuthModel(
                                                        email: emailCTR.text,
                                                        password:
                                                            passwordCTR.text,
                                                      ),
                                                    ),
                                                  );
                                              }
                                            },
                                            child: Text(
                                              "Login",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromRGBO(
                                                      186, 104, 200, 0.9)),
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
                                        height: 29,
                                      ),
                                      Text(
                                        "Don't Have an Account",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: Color.fromRGBO(0, 0, 0, 1)),
                                      ),
                                      SizedBox(
                                        height: 9,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return RegistrationPage();
                                          }));
                                        },
                                        child: Text(
                                          "Creat Account",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromRGBO(
                                                  179, 0, 239, 0.91)),
                                        ),
                                      )
                                    ],
                                  )),
                              SizedBox(
                                height: 37,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        final SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.setString('key', 'hello');
                                        print(prefs.getString('key'));
                                      },
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/images/facebook-f.png"),
                                      ),
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
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
