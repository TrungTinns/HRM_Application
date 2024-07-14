import 'package:flutter/material.dart';
import 'package:hrm_application/components/iconic/icon.dart';
import 'package:hrm_application/views/home/home.dart';
import 'package:hrm_application/widgets/colors.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  void toggleForm() {
    setState(() {
      isLogin = !isLogin;
    });
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
            decoration:  BoxDecoration(
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
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomLeft: Radius.circular(25)),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(50),
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
                            blurRadius: 20
                          ),
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
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                decoration: InputDecoration(
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: true,
                                        onChanged: (value) {},
                                      ),
                                      const Text('Remember me', style: TextStyle(color: Colors.black),),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text('Forgot password?', style: TextStyle(color: Colors.black),),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: primaryColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 20,
                            ),
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                BorderRadius.circular(10),
                                side: const BorderSide(width: 1, color: Colors.white),
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(width: 8),
                                Text(
                                  'Sign in',
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 20,
                                  ),
                                )
                              ]
                            )
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
                      borderRadius: BorderRadius.only(topRight:Radius.circular(25), bottomRight: Radius.circular(25),),
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
                        borderRadius: BorderRadius.only(topRight:Radius.circular(25), bottomRight: Radius.circular(25),)
                      ),
                      child: Center(
                        child: isLogin
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  appIcon(context),
                                  Container(
                                    child: Column(
                                      children: [
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
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 50,
                                            vertical: 20,
                                          ),
                                          backgroundColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: const BorderSide(width: 1, color: Colors.white),
                                          ),
                                        ),
                                        child: const Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.arrow_back, color: Colors.white),
                                            SizedBox(width: 8),
                                            Text(
                                              'Check-in',
                                              style: TextStyle(
                                                color: textColor,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ]
                                        )
                                        )
                                      ]
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  appIcon(context),
                                  Container(
                                    child: Column(
                                      children: [
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
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 50,
                                            vertical: 20,
                                          ),
                                          backgroundColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: const BorderSide(width: 1, color: Colors.white),
                                          ),
                                        ),
                                        child: const Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.arrow_back, color: Colors.white),
                                            SizedBox(width: 8),
                                            Text(
                                              'Sign in',
                                              style: TextStyle(
                                                color: textColor,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ]
                                        )
                                        )
                                      ]
                                    ),
                                  ),
                                ],
                              )
                      ),
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
