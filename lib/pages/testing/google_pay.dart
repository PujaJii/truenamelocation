import 'package:flutter/material.dart';


import '../../styles/app_colors.dart';



class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String name = "";
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();

  passToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });
      await Future.delayed(const Duration(seconds: 1));
      //await Get.to(() => const HomePage());
      setState(() {
        changeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 100.0),
                Image.asset(
                  'assets/login_logo.png',
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 50.0),
                Text(
                  'Log in $name ',
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.themeColor,
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'name cant be empty';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter your name',
                            label: Text('Name')),
                        onChanged: (value) {
                          name = value;
                          setState(() {});
                        },
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'password cant be empty';
                          } else if (value.length < 6) {
                            return 'password too short';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Password',
                          label: Text('Password'),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Material(
                        elevation: 5,
                        color: AppColors.themeColor,
                        borderRadius:
                        BorderRadius.circular(changeButton ? 45 : 6.0),
                        child: InkWell(
                          onTap: () => passToHome(context),
                          child: AnimatedContainer(
                            height: 50.0,
                            width: changeButton ? 50 : 350.0,
                            alignment: Alignment.center,
                            duration: const Duration(seconds: 1),
                            child: changeButton
                                ? const Icon(Icons.done, color: Colors.white)
                                : const Text('Log in',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                )
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Forget Password?',
                        style: TextStyle(
                          color: Colors.grey[700],
                        )
                    ),
                    const Text('Create new account',
                        style: TextStyle(
                          color: AppColors.themeColor,
                        )),
                  ],
                ),
                const SizedBox(height: 20.0),
                const Text('or',
                    style: TextStyle(
                      color: Colors.black,
                    )
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 30),
                  child: Material(
                    elevation: 5,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          //Get.to(() => const HomePage());
                          // Navigator.pushNamed(context, MyRoutes.homeRout);
                        });
                      },
                      child: AnimatedContainer(
                          height: 50.0,
                          width: 350.0,
                          alignment: Alignment.center,
                          duration: const Duration(seconds: 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/new_google.png',
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text('Log in with google',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                    )),
                              ),
                            ],
                         )
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}