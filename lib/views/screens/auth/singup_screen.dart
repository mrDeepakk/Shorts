import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glitcheffect/glitcheffect.dart';
import 'package:shorts/constants.dart';
import 'package:shorts/controllers/auth_controller.dart';
import 'package:shorts/views/screens/auth/login_screen.dart';
import 'package:shorts/views/widgets/textinput_field.dart';

class SingupScreen extends StatelessWidget {
  static AuthController instance = Get.find();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            height: size.height,
            width: size.width,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GlitchEffect(
                  child: Text(
                    "Tiktok clone",
                    style: TextStyle(
                        fontSize: 25,
                        color: buttonColor,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Register",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 15,
                ),
                Stack(
                  children: [
                    const CircleAvatar(
                      backgroundColor: backgroundColor,
                      radius: 64,
                      backgroundImage: NetworkImage(
                          "https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png"),
                    ),
                    Positioned(
                      left: 80,
                      bottom: -10,
                      child: IconButton(
                          onPressed: () {
                            authController.picImage();
                          },
                          icon: const Icon(Icons.add_a_photo_rounded)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                    controller: _usernamecontroller,
                    labeltext: "UserName",
                    icon: Icons.person,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                    controller: _emailcontroller,
                    labeltext: "Email",
                    icon: Icons.email,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                    controller: _passwordcontroller,
                    labeltext: "Password",
                    icon: Icons.lock,
                    isObscure: true,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () async {
                    authController.registerUser(
                        _usernamecontroller.text,
                        _emailcontroller.text,
                        _passwordcontroller.text,
                        authController.profilePic);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 50,
                    color: buttonColor,
                    child: const Center(
                      child: Text(
                        "Singup",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Alread have an Account ? ",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(LoginScreen());
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: buttonColor,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
