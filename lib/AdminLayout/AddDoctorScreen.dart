import 'package:clinic_project/AdminLayout/AdminLayout.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Componant/Componant.dart';
import '../Cubit/AppCubit.dart';
import '../Cubit/AppStates.dart';

class AddDoctorScreen extends StatefulWidget {
  const AddDoctorScreen({super.key});

  @override
  State<AddDoctorScreen> createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends State<AddDoctorScreen> {
  var fNameController=TextEditingController();
  var lNameController=TextEditingController();
  var majorController=TextEditingController();
  var phoneController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var passwordController2=TextEditingController();
  var priceController=TextEditingController();
  var addressController=TextEditingController();
  final imageController = TextEditingController();
  bool acceptCalls=false;
  bool acceptPrivateVisits=false;
  bool acceptVisitsInClinic=false;
  final  formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){
             if(state is CreateDoctorSuccessState){
               navigateAndFinish(context, const AdminLayout());
             }
        },
        builder:(context,state){
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(onPressed: (){
                  AppCubit.get(context).getImage2();
                }, icon: const Icon( Icons.add_a_photo,color: Colors.deepPurpleAccent,))
              ],
            ),
            body: GestureDetector(
              onTap: (){
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Form(
                key:formKey,
                child: ListView(children: [


                  Container(
                      width:MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.31,
                      decoration: AppCubit.get(context).PickedFile2!=null?
                      BoxDecoration(image: DecorationImage(image: FileImage(AppCubit.get(context).PickedFile2!),fit: BoxFit.fill))
                          : BoxDecoration(image:

                      const DecorationImage(image: NetworkImage(
                          'https://www.leedsandyorkpft.nhs.uk/advice-support/wp-content/uploads/sites/3/2021/06/pngtree-image-upload-icon-photo-upload-icon-png-image_2047546.jpg'))


                      )

                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('First Name',style: TextStyle(fontWeight: FontWeight.bold,fontSize:MediaQuery.of(context).size.width*0.05,color: Colors.black ),),
                        defaultTextFormField(
                            prefix: Icons.person,

                            controller: fNameController,
                            keyboardType: TextInputType.text,
                            validate: (String? s){
                              if(s!.isEmpty){
                                return 'Enter FirstName';
                              }
                              return null;
                            },
                            label: 'FirstName')

                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    width: double.infinity,
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Last Name',style: TextStyle(fontWeight: FontWeight.bold,fontSize:MediaQuery.of(context).size.width*0.05,color: Colors.black ),),
                        defaultTextFormField(
                            prefix: Icons.person_2,

                            controller: lNameController,
                            keyboardType: TextInputType.text,
                            validate: (String? s){
                              if(s!.isEmpty){
                                return 'Enter Last Name';
                              }
                              return null;
                            },
                            label: 'Last Name')

                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    width: double.infinity,
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Major',style: TextStyle(fontWeight: FontWeight.bold,fontSize:MediaQuery.of(context).size.width*0.05,color: Colors.black ),),
                        defaultTextFormField(
                            prefix: Icons.check,

                            controller: majorController,
                            keyboardType: TextInputType.text,
                            validate: (String? s){
                              if(s!.isEmpty){
                                return 'Enter major';
                              }
                              return null;
                            },
                            label: 'major')

                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    width: double.infinity,
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Phone Number',style: TextStyle(fontWeight: FontWeight.bold,fontSize:MediaQuery.of(context).size.width*0.05,color: Colors.black ),),
                        defaultTextFormField(
                            prefix:Icons.location_on_sharp ,

                            controller: phoneController,
                            keyboardType: TextInputType.name,
                            validate: (String? s){
                              if(s!.isEmpty){
                                return 'Enter Phone';
                              }
                              return null;
                            },
                            label: 'Phone')


                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    width: double.infinity,
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Base Price',style: TextStyle(fontWeight: FontWeight.bold,fontSize:MediaQuery.of(context).size.width*0.05,color: Colors.black ),),
                        defaultTextFormField(
                            prefix: Icons.attach_money,
                            controller: priceController,
                            keyboardType: TextInputType.name,
                            validate: (String? s){
                              if(s!.isEmpty){
                                return 'Enter Price';
                              }
                              return null;
                            },
                            label: 'Price'),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    width: double.infinity,
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Address',style: TextStyle(fontWeight: FontWeight.bold,fontSize:MediaQuery.of(context).size.width*0.05,color: Colors.black ),),
                        defaultTextFormField(
                            prefix:Icons.location_on_sharp ,

                            controller: addressController,
                            keyboardType: TextInputType.name,
                            validate: (String? s){
                              if(s!.isEmpty){
                                return 'Enter Address';
                              }
                              return null;
                            },
                            label: 'Address')

                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    width: double.infinity,
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email',style: TextStyle(fontWeight: FontWeight.bold,fontSize:MediaQuery.of(context).size.width*0.05,color: Colors.black ),),
                        defaultTextFormField(
                            prefix:Icons.email ,

                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validate: (String? s){
                              if(s!.isEmpty){
                                return 'Enter Doctor Email';
                              }
                              return null;
                            },
                            label: 'Doctor Email')

                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    width: double.infinity,
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Password',style: TextStyle(fontWeight: FontWeight.bold,fontSize:MediaQuery.of(context).size.width*0.05,color: Colors.black ),),
                        defaultTextFormField(
                            prefix:Icons.lock ,

                            controller: passwordController,
                            keyboardType: TextInputType.name,
                            validate: (String? s){
                              if(s!.isEmpty){
                                return 'Enter Password';
                              }
                              return null;
                            },
                            label: 'Password')

                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    width: double.infinity,
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Confirm Password',style: TextStyle(fontWeight: FontWeight.bold,fontSize:MediaQuery.of(context).size.width*0.05,color: Colors.black ),),
                        defaultTextFormField(
                            prefix:Icons.lock ,

                            controller: passwordController2,
                            keyboardType: TextInputType.name,
                            validate: (String? s){
                              if(s!.isEmpty){
                                return 'Enter Confirm Password';
                              }
                              return null;
                            },
                            label: 'Confirm Password')

                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    width: double.infinity,
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Accept Calls ',style: TextStyle(color:acceptCalls ?Colors.black: Colors.grey,fontSize: MediaQuery.of(context).size.width*0.04,),),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {

                            setState(() {
                              acceptCalls=!acceptCalls;
                            });
                          },
                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors:[ acceptCalls
                                      ?Colors.deepPurpleAccent:Colors.transparent,acceptCalls
                                      ?Colors.cyan:Colors.transparent]),
                              shape: BoxShape.circle,
                              border:!acceptCalls
                                  ? Border.all(
                                color: Colors.grey,
                                width: 3,
                              ):null,
                            ),
                            child:acceptCalls
                                ? const Icon(
                              Icons.check,
                              color: Colors.white,
                            )
                                : null,
                          ),
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Accept Visits In Clinic ',style: TextStyle(color:acceptVisitsInClinic ?Colors.black: Colors.grey,fontSize: MediaQuery.of(context).size.width*0.04,),),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {

                            setState(() {
                              acceptVisitsInClinic=!acceptVisitsInClinic;
                            });
                          },
                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors:[ acceptVisitsInClinic
                                      ?Colors.deepPurpleAccent:Colors.transparent,acceptVisitsInClinic
                                      ?Colors.cyan:Colors.transparent]),
                              shape: BoxShape.circle,
                              border:!acceptVisitsInClinic
                                  ? Border.all(
                                color: Colors.grey,
                                width: 3,
                              ):null,
                            ),
                            child:acceptVisitsInClinic
                                ? const Icon(
                              Icons.check,
                              color: Colors.white,
                            )
                                : null,
                          ),
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Accept Private Visits',style: TextStyle(color:acceptPrivateVisits ?Colors.black: Colors.grey,fontSize: MediaQuery.of(context).size.width*0.04,),),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {

                            setState(() {
                              acceptPrivateVisits=!acceptPrivateVisits;
                            });
                          },
                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors:[ acceptPrivateVisits
                                      ?Colors.deepPurpleAccent:Colors.transparent,acceptPrivateVisits
                                      ?Colors.cyan:Colors.transparent]),
                              shape: BoxShape.circle,
                              border:!acceptPrivateVisits
                                  ? Border.all(
                                color: Colors.grey,
                                width: 3,
                              ):null,
                            ),
                            child:acceptPrivateVisits
                                ? const Icon(
                              Icons.check,
                              color: Colors.white,
                            )
                                : null,
                          ),
                        ),

                      ],
                    ),
                  ),

                  Container(
                    color: Colors.grey,
                    width: double.infinity,
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ConditionalBuilder(
                      condition: state  is! CreateUserInitialState,
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


                                  AppCubit.get(context).doctorRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    firstName: fNameController.text,
                                    lastName:lNameController.text ,
                                    phone: phoneController.text,
                                    address:addressController.text,
                                    major: majorController.text,
                                    acceptVisitsInClinic: acceptVisitsInClinic,
                                    acceptCalls: acceptCalls,
                                    acceptPrivateVisits: acceptPrivateVisits,
                                    basePrice:double.parse(priceController.text ),
                                  );
                                }

                              }
                            }
                          },
                          text: 'Save',
                          radius: 20, context: context,
                        ),
                      ),
                      fallback: (context) =>
                      const Center(child: CircularProgressIndicator()),
                    ),
                  ),


                ],),
              ),
            ),
          );
        }
    );
  }
}
