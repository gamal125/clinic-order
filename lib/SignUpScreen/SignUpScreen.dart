import 'package:clinic_project/Cubit/AppCubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import '../Componant/Componant.dart';
import '../Cubit/AppStates.dart';
import '../LoginScreen/LoginScreen.dart';



class RegisterScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordController2 = TextEditingController();
  final phoneController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {

          navigateAndFinish(context, LoginScreen());
        }


      },
      builder: (context, state) {
        return Scaffold(
appBar: AppBar(),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [

                    const SizedBox(
                      height: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Create an account',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold,fontFamily: 'Dubai',),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5,left: 5,bottom:10),
                      child: Column(children: [

                        defaultTextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter  Email';
                            }
                            return null;
                          },
                          label: 'Email',
                          hint: 'Email',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        defaultTextFormField(
                          controller: firstNameController,
                          keyboardType: TextInputType.text,

                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter First Name';
                            }
                            return null;
                          },
                          label: 'First Name',
                          hint: 'First Name',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        defaultTextFormField(
                          controller: lastNameController,
                          keyboardType: TextInputType.text,

                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter Last Name';
                            }
                            return null;
                          },
                          label: 'Last Name',
                          hint: 'Last Name',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        defaultTextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter Phone';
                            }
                            return null;
                          },
                          label: ' Phone',
                          hint: ' Phone',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        defaultTextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.text,

                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter Password';
                            }
                            return null;
                          },
                          label: 'Password',
                          hint: 'Password',
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        defaultTextFormField(
                          controller: passwordController2,
                          keyboardType: TextInputType.text,

                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter Confirm Password';
                            }
                            return null;
                          },
                          label: 'Confirm Password',
                          hint: 'Confirm Password',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! CreateUserInitialState,
                          builder: (context) => Center(
                            child: defaultMaterialButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  if(passwordController.text!=passwordController2.text){
                                    showToast(text:'Password Not Matched' , state: ToastStates.error);
                                  }else{
                                    if(phoneController.text.length!=10){
                                      showToast(text:'phone number Invalid' , state: ToastStates.error);
                                    }else{
                                      AppCubit.get(context).userRegister(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        firstName: firstNameController.text,
                                        lastName:lastNameController.text ,
                                        phone: phoneController.text,
                                        image: '',
                                        userRole: 'patient',
                                        address: '',
                                        major: '',
                                        acceptVisitsInClinic: false,
                                        acceptCalls: false,
                                        acceptPrivateVisits: false,
                                        basePrice:0 ,
                                      );
                                    }

                                  }

                                }
                              },
                              text: 'Sign Up',
                              radius: 20, color: HexColor('#464646'), context: context,
                            ),
                          ),
                          fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                        ),

                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Do you already have an account?',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.grey),),

                            TextButton(onPressed: () { navigateTo(context, LoginScreen()); },
                              child:Text('Login',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: HexColor('#F88B94'),),),
                            ),
                          ],
                        ),


                      ]),
                    ),


                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}
