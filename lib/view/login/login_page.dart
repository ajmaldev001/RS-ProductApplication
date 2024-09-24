import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rs_productapp_project/configs/consts/image_contants.dart';
import 'package:rs_productapp_project/configs/consts/text_constants.dart';
import 'package:rs_productapp_project/view/product_list/product_list_page.dart';
import 'package:rs_productapp_project/view/sign_up/sign_up_page.dart';
import 'package:rs_productapp_project/view/widgets/forgot_password.dart';
import 'package:rs_productapp_project/view/widgets/my_button_widget.dart';
import 'package:rs_productapp_project/view/widgets/snack_bar_widget.dart';
import 'package:rs_productapp_project/view/widgets/textfeild_widget.dart';
import 'package:rs_productapp_project/view_model/login_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Consumer<LoginViewModel>(
      builder: (context,loginVM,child) {
        return Scaffold(
          // resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
              child: SizedBox(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height / 2.7,
                      child: SvgPicture.asset(
                        ImageConstants.loginImg,
                        semanticsLabel: 'Login SVG Image',
                      ),
                    ),
                    TextFieldInput(
                        icon: Icons.person,
                        textEditingController: emailController,
                        hintText: TextConstants.enterYourEmail,
                        textInputType: TextInputType.text,
                        validator: (value){
                          if (value == null || value.isEmpty) {
                            return 'Please ${TextConstants.enterYourEmail}';
                          }
                          // Basic email format validation
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return TextConstants.validEmailAddress;
                          }
                          return null;
                        },
                    ),
                    TextFieldInput(
                      icon: Icons.lock,
                      textEditingController: passwordController,
                      hintText: TextConstants.enterYourPass,
                      textInputType: TextInputType.text,
                      isPass: true,
                      validator: (value){
                        if (value == null || value.isEmpty) {
                          return 'Please ${TextConstants.enterYourPass}';
                        }
                        if (value.length < 6) {
                          return TextConstants.passwordCharacters;
                        }
                        return null;
                      },
                    ),
                    //  we call our forgot password below the login in button
                    const ForgotPassword(),
                    const SizedBox(height: 30),
                    MyButtons(
                      onTap: (){
                        if (_formKey.currentState!.validate()) {
                          loginVM.loginUser(emailController.text, passwordController.text).
                          then((value) {
                            if(value == TextConstants.success){
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const ProductListPage(),
                                ),
                              );
                            }else{
                              // show error
                              showSnackBar(context, value);
                            }
                          });
                        }
                      },
                      text: TextConstants.logIn
                    ),
                        
                    Row(
                      children: [
                        Expanded(
                          child: Container(height: 1, color: Colors.black26),
                        ),
                        const Text("  or  "),
                        Expanded(
                          child: Container(height: 1, color: Colors.black26),
                        )
                      ],
                    ),
                    // Don't have an account? got to signup screen
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(TextConstants.dontHaveAcc),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const SignupScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              TextConstants.signUp,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
        );
      }
    );
  }
}