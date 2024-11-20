import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hrm_application/core/utils/theme/colors.dart';
import 'package:hrm_application/presentation/controllers/auth/auth_controller.dart';
import 'package:hrm_application/presentation/widgets/iconic/icon.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
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
          child: Obx(
            () => Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  left: authController.isLogin.value ? 0 : 550,
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
                                  focusNode: authController.emailFocusNode,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  controller: authController.emailController,
                                  autofocus: false,
                                  onChanged: (value) {
                                    authController.isEditingEmail.value = true;
                                  },
                                  onSubmitted: (value) {
                                    authController.emailFocusNode.unfocus();
                                    FocusScope.of(context).requestFocus(
                                        authController.passwordFocusNode);
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    fillColor: Colors.grey[200],
                                    filled: true,
                                    errorText: authController.isEditingEmail.value
                                        ? authController.validateEmail(
                                            authController.emailController.text)
                                        : null,
                                  )),
                              const SizedBox(height: 20),
                              TextField(
                                focusNode: authController.passwordFocusNode,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                controller: authController.passwordController,
                                autofocus: false,
                                onChanged: (value) {
                                  authController.isEditingPassword.value = true;
                                },
                                onSubmitted: (value) {
                                  authController.passwordFocusNode.unfocus();
                                },
                                decoration: InputDecoration(
                                  errorText: authController.isEditingPassword.value
                                      ? authController.validatePassword(
                                          authController.passwordController.text)
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
                                  onPressed: authController.signInWithEmail,
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
                                  onPressed: authController.registerWithEmail,
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
                                onPressed: () {
                                  authController.signInWithGoogle();
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
                                onPressed: () {},
                                color: Colors.blue[900],
                                icon: const Icon(FontAwesomeIcons.facebook),
                                style: IconButton.styleFrom(
                                    iconSize: 30,
                                    side: const BorderSide(
                                      color: Colors.black54,
                                    )),
                              ),
                              IconButton(
                                onPressed: () {},
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
                  right: authController.isLogin.value ? 0 : 550,
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
                  right: authController.isLogin.value ? 0 : 0,
                  child: GestureDetector(
                    onTap: authController.toggleForm,
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
                          child: authController.isLogin.value
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
                                            onPressed: authController.toggleForm,
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
                                            onPressed: authController.toggleForm,
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
    ));
  }
}
