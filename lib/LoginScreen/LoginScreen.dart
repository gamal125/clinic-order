
import 'package:clinic_project/AdminLayout/AdminLayout.dart';
import 'package:clinic_project/Cubit/AppCubit.dart';
import 'package:clinic_project/DoctorLayout/DoctorLayout.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Componant/Componant.dart';
import '../Cubit/AppStates.dart';
import '../PatientLayout/SelectTypeScreen.dart';
import '../SignUpScreen/SignUpScreen.dart';
import '../shared/local/cache_helper.dart';


class LoginScreen extends StatelessWidget {
  final  formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          CacheHelper.saveData(key: 'uId', value: state.uId);
          AppCubit.get(context).getUser(state.uId,context);
        }
        if (state is GetUserSuccessState) {
      if(state.type=='admin'){
        navigateAndFinish(context, const AdminLayout());
      }
      else if(state.type=='doctor'){
        navigateAndFinish(context, const DoctorLayout());
      }
      else{
                navigateAndFinish(context, const SelectTypeScreen());
      }
        }

        },
      builder: (context, state) {
        return Scaffold(

appBar: AppBar(),

          body: SafeArea(
            child: GestureDetector(
              onTap: (){
                FocusManager.instance.primaryFocus?.unfocus();
              },

              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          defaultTextFormField(
                            onTap: (){
                            },
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            prefix: Icons.email,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter email';
                              }
                              return null;
                            },
                            label: 'Email',
                            hint: 'Enter your email',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultTextFormField(
                            onTap: (){
                              // LoginCubit.get(context).emit(LoginInitialState());
                            },
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            prefix: Icons.key,
                            suffix: AppCubit.get(context).suffix,
                            isPassword: AppCubit.get(context).isPassword,
                            suffixPressed: () {
                              AppCubit.get(context).changePassword();
                            },
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                            label: 'Password',
                            hint: 'Enter your password',
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context) => Center(
                              child: defaultMaterialButton(

                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    AppCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                text: 'Login',
                                radius: 20, context: context,
                              ),
                            ),
                            fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Don\'t have an account?',
                            style:
                            TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          defaultTextButton(
                            function: () {
                              navigateTo(context, RegisterScreen());
                            },
                            text: 'Register Now!',
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

        );
      },
    );
  }
}
