import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rs_productapp_project/configs/consts/image_contants.dart';
import 'package:rs_productapp_project/configs/consts/text_constants.dart';
import 'package:rs_productapp_project/view/login/login_page.dart';
import 'package:rs_productapp_project/view/product_list/product_list_page.dart';
import 'package:rs_productapp_project/view/widgets/my_button_widget.dart';
import 'package:rs_productapp_project/view/widgets/snack_bar_widget.dart';
import 'package:rs_productapp_project/view/widgets/textfeild_widget.dart';
import 'package:rs_productapp_project/view_model/login_view_model.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Consumer<LoginViewModel>(
      builder: (context,loginVm,child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
              child: SizedBox(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height / 2.8,
                      child: SvgPicture.asset(
                        ImageConstants.signUpImg,
                        semanticsLabel: 'SignUp SVG Image',
                      ),
                    ),
                    TextFieldInput(
                        icon: Icons.person,
                        textEditingController: nameController,
                        hintText: TextConstants.enterYourName,
                        textInputType: TextInputType.text,
                        validator: (value) {
                          if(value == null || value.isEmpty){
                             return 'Please ${TextConstants.enterYourName}';
                          }
                          return null;
                        },
                    ),
                    TextFieldInput(
                        icon: Icons.email,
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
                      
                   MyButtons(
                      onTap: (){
                        if (_formKey.currentState!.validate()) {
                          loginVm.signupUser(emailController.text, passwordController.text, nameController.text).
                          then((value) {
                            if(value == "success"){
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const ProductListPage(),
                                ),
                              );
                            }else{
                              showSnackBar(context, value);
                            }
                          });
                        }
                      }, 
                    text: TextConstants.signUp
                    ),
                
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(TextConstants.alreadyHaveAcc),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          child: const Text(
                            " ${TextConstants.logIn}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
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