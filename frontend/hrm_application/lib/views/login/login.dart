import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hrm_application/Component/Iconic/icon.dart';
import 'package:hrm_application/Config/Services/Firebase/Auth/auth.dart';
import 'package:hrm_application/Views/Home/home.dart';
import 'package:hrm_application/Widgets/colors.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late TextEditingController emailController;
  late FocusNode focusNodeEmail;
  bool isEditingEmail = false;
  late TextEditingController passwordController;
  late FocusNode focusNodePassword;
  bool isEditingPassword = false;
  bool isRegistering = false;
  bool isLogin = true;
  bool isLoggingin = false;
  String? loginStatus;
  bool isProcessing = false;

  String? validateEmail(String? value) {
    value = value!.trim();
    if (emailController.text.isNotEmpty) {
      if (value.isEmpty)
        return "Email can't be empty";
      else if (!value.contains(
          RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")))
        return "Enter a correct email address";
    }
    return null;
  }

  String? validatePassword(String? value) {
    value = value!.trim();
    if (passwordController.text.isNotEmpty) {
      if (value.isEmpty) {
        return "Password can't be empty";
      } else if (value.length < 6) {
        return "Password must be at least 6 characters";
      }
    }
    return null;
  }

  void toggleForm() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  Future<void> signinwithFacebook() async {
    try {
      final facebookProvider = FacebookAuthProvider();
      await FirebaseAuth.instance.signInWithPopup(facebookProvider);
    } on FirebaseException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Failed to sign in with Facebook: ${e.message}")));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to sign in with Facebook: $e")));
      }
    }
  }

  Future<void> signinwithGithub() async {
    try {
      final githubProvider = GithubAuthProvider();
      await FirebaseAuth.instance.signInWithPopup(githubProvider);
    } on FirebaseException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Failed to sign in with GitHub: ${e.message}")));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to sign in with GitHub: $e")));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    focusNodeEmail = FocusNode();
    passwordController = TextEditingController();
    focusNodePassword = FocusNode();
    emailController.text = '';
    passwordController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              authThemeColor,
              Colors.black,
            ],
          ),
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.2),
                  spreadRadius: 15,
                  blurRadius: 20,
                ),
              ],
            ),
            width: 1100,
            height: 600,
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  left: isLogin ? 0 : 550,
                  child: Container(
                    width: 550,
                    height: 600,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomLeft: Radius.circular(25)),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.all(50),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 20,
                              blurRadius: 20),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: const Text(
                              'Administrator Login',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: authThemeColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Column(
                            children: [
                              TextField(
                                focusNode: focusNodeEmail,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                controller: emailController,
                                autofocus: false,
                                onChanged: (value) {
                                  setState(() {
                                    isEditingEmail = true;
                                  });
                                },
                                onSubmitted: (value) {
                                  focusNodeEmail.unfocus();
                                  FocusScope.of(context)
                                      .requestFocus(focusNodePassword);
                                },
                                decoration: InputDecoration(
                                    hintText: 'Email',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    fillColor: Colors.grey[200],
                                    filled: true,
                                    errorText: isEditingEmail
                                        ? validateEmail(emailController.text)
                                        : null),
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                focusNode: focusNodePassword,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                controller: passwordController,
                                autofocus: false,
                                onChanged: (value) {
                                  setState(() {
                                    isEditingPassword = true;
                                  });
                                },
                                onSubmitted: (value) {
                                  focusNodePassword.unfocus();
                                  FocusScope.of(context)
                                      .requestFocus(focusNodePassword);
                                },
                                decoration: InputDecoration(
                                  errorText: isEditingPassword
                                      ? validatePassword(
                                          passwordController.text)
                                      : null,
                                  hintText: 'Password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                ),
                                obscureText: true,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: true,
                                        onChanged: (value) {},
                                      ),
                                      const Text(
                                        'Remember me',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Forgot password?',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      isLoggingin = true;
                                      focusNodeEmail.unfocus();
                                      focusNodePassword.unfocus();
                                    });
                                    if (validateEmail(emailController.text) ==
                                            null &&
                                        validatePassword(
                                                passwordController.text) ==
                                            null) {
                                      await signInWithEmailPassword(
                                              emailController.text,
                                              passwordController.text)
                                          .then((result) {
                                        if (result != null) {
                                          print(result);
                                          setState(() {
                                            loginStatus = 'Login successful';
                                          });
                                          Future.delayed(
                                              const Duration(
                                                  milliseconds: 2000), () {
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Home(),
                                                        fullscreenDialog:
                                                            true));
                                          });
                                        }
                                      }).catchError((error) {
                                        print('Login failed: $error');
                                        setState(() {
                                          loginStatus =
                                              'Erroe occured while logging in';
                                        });
                                      });
                                    } else {
                                      setState(() {
                                        loginStatus =
                                            'Please enter email and password';
                                      });
                                    }
                                    setState(() {
                                      isLoggingin = false;
                                      emailController.text = '';
                                      passwordController.text = '';
                                      isEditingEmail = false;
                                      isEditingPassword = false;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: primaryColor,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 30),
                                    backgroundColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                          width: 1, color: Colors.white),
                                    ),
                                  ),
                                  child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Sign in',
                                          style: TextStyle(
                                            color: textColor,
                                            fontSize: 20,
                                          ),
                                        )
                                      ])),
                              SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      isRegistering = true;
                                    });
                                    await registerWithEmailPassword(
                                            emailController.text,
                                            passwordController.text)
                                        .then((result) {
                                      if (result != null) {
                                        setState(() {
                                          loginStatus =
                                              'You have registered successfully';
                                        });
                                        print(result);
                                      }
                                    }).catchError((error) {
                                      print('Registration failed: $error');
                                      setState(() {
                                        loginStatus =
                                            'Error occured while registering';
                                      });
                                    });
                                    setState(() {
                                      isRegistering = false;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: primaryColor,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 30),
                                    backgroundColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                          width: 1, color: Colors.white),
                                    ),
                                  ),
                                  child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Sign up',
                                          style: TextStyle(
                                            color: textColor,
                                            fontSize: 20,
                                          ),
                                        )
                                      ])),
                            ],
                          ),
                          const Row(
                            children: [
                              Expanded(
                                  child: Divider(
                                color: Colors.black54,
                                thickness: 1,
                              )),
                              SizedBox(width: 8),
                              Text('Or'),
                              SizedBox(width: 8),
                              Expanded(
                                  child: Divider(
                                color: Colors.black54,
                                thickness: 1,
                              ))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  setState(() {
                                    isProcessing = true;
                                  });

                                  await signInWithGoogle().then((result) {
                                    print(result);
                                    if (result != null) {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) => Home(),
                                              fullscreenDialog: true));
                                    }
                                    ;
                                  }).catchError((error) {
                                    print('Registration failed: $error');
                                    setState(() {
                                      isProcessing = false;
                                    });
                                  });
                                },
                                color: Colors.red,
                                icon: const Icon(FontAwesomeIcons.google),
                                style: IconButton.styleFrom(
                                    iconSize: 30,
                                    side: const BorderSide(
                                      color: Colors.black54,
                                    )),
                              ),
                              IconButton(
                                onPressed: signinwithFacebook,
                                color: Colors.blue[900],
                                icon: const Icon(FontAwesomeIcons.facebook),
                                style: IconButton.styleFrom(
                                    iconSize: 30,
                                    side: const BorderSide(
                                      color: Colors.black54,
                                    )),
                              ),
                              IconButton(
                                onPressed: signinwithGithub,
                                icon: const Icon(FontAwesomeIcons.github),
                                color: Colors.black,
                                style: IconButton.styleFrom(
                                    iconSize: 30,
                                    side: const BorderSide(
                                      color: Colors.black54,
                                    )),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  right: isLogin ? 0 : 550,
                  child: Container(
                    width: 550,
                    height: 600,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Employee Attendance',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            //To do QR code
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                  right: isLogin ? 0 : 0,
                  child: GestureDetector(
                    onTap: toggleForm,
                    child: Container(
                      width: 550,
                      height: 600,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              authThemeColor,
                              Colors.black,
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          )),
                      child: Center(
                          child: isLogin
                              ? Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    appIcon(),
                                    Container(
                                      child: Column(children: [
                                        const Text(
                                          'Employee Check Attendance',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 20),
                                        ElevatedButton(
                                            onPressed: toggleForm,
                                            style: ElevatedButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 50,
                                                vertical: 20,
                                              ),
                                              backgroundColor:
                                                  Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                side: const BorderSide(
                                                    width: 1,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(Icons.arrow_back,
                                                      color: Colors.white),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    'Check-in',
                                                    style: TextStyle(
                                                      color: textColor,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ]))
                                      ]),
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    appIcon(),
                                    Container(
                                      child: Column(children: [
                                        const Text(
                                          'Administrator Login',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 20),
                                        ElevatedButton(
                                            onPressed: toggleForm,
                                            style: ElevatedButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 50,
                                                vertical: 20,
                                              ),
                                              backgroundColor:
                                                  Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                side: const BorderSide(
                                                    width: 1,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(Icons.arrow_back,
                                                      color: Colors.white),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    'Sign in',
                                                    style: TextStyle(
                                                      color: textColor,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ])),
                                      ]),
                                    ),
                                  ],
                                )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
