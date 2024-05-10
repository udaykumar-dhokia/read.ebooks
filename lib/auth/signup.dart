import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:read/constants/colors.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/back.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Scaffold(
        backgroundColor: Colors.white.withOpacity(0.5),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                "Already a reader? ",
                style: GoogleFonts.poppins(),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 80, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "read",
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 50, fontWeight: FontWeight.bold)),
                ),
                Text(
                  "SignUp",
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(fontSize: 15)),
                ),
                const SizedBox(
                  height: 100,
                ),
                _textFormFIeld("Name", _name, showPassword, TextInputType.name),
                const SizedBox(
                  height: 15,
                ),
                _textFormFIeld(
                    "Email", _email, showPassword, TextInputType.emailAddress),
                const SizedBox(
                  height: 15,
                ),
                _textFormFIeld(
                    "Mobile", _mobile, showPassword, TextInputType.phone),
                const SizedBox(
                  height: 15,
                ),
                _textFormFIeld(
                    "Password", _password, showPassword, TextInputType.text),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: primaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 15, bottom: 15),
                      child: Text(
                        "SignUp",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  TextFormField _textFormFIeld(String label, TextEditingController controller,
      bool showPassword, TextInputType textInputType) {
    return TextFormField(
      keyboardType: textInputType,
      obscureText: label == "Password" ? showPassword : false,
      decoration: InputDecoration(
        suffixIcon: label == "Password"
            ? IconButton(
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
                icon: showPassword == true
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
              )
            : null,
        label: Text(label),
        labelStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: primaryColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
