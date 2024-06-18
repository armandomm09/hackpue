import 'package:flutter/material.dart';
import 'package:hackpue/components/appButton.dart';
import 'package:hackpue/components/appTextField.dart';
import 'package:hackpue/services/auth/auth_service.dart';

// ignore: must_be_immutable
class RegisterPage extends StatelessWidget {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  void register(BuildContext context) async {
    final auth = AuthService();
    
    if(passwordController.text == confirmPasswordController.text){
      try {
        await auth.signUpWithEmailAndPassword(emailController.text, passwordController.text);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text("Passwords don't match"),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 300,
                width: 300,
                child: Center()
                /*ModelViewer(
                  autoRotate: true,
                  rotationPerSecond: "20deg",
                          backgroundColor: Colors.transparent,
                          src: "assets/images/stl/5887_3D.gltf"
                          ),*/
              ),
              const SizedBox(
                height: 30,
              ),
          
          
              Text(
                "Welcome back, we've been missing you",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
              ),
          
          
              const SizedBox(
                height: 25,
              ),
          
          
              AppTextField(
               textt: "Email",
              ),
          
          
              const SizedBox(
                height: 10,
              ),
          
          
              AppTextField(
                textt: 'Password',
              ),
          
          
              const SizedBox(
                height: 10,
              ),
          
              AppTextField(
                textt: 'Confirm Password',
              ),
          
          
              const SizedBox(
                height: 30,
              ),
              AppButton(
                text: "Register",
                onPressed: () => register(context),
              ),
          
          
              const SizedBox(
                height: 25,
              ),
          
          
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: onTap,
                    child: const Text(
                      "Login now",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
          
          
            ],
          ),
        ),
      ),
    );
  }
}
