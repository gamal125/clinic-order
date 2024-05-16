import 'package:clinic_project/PatientLayout/PatientLayout.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Componant/Componant.dart';
import '../Cubit/AppCubit.dart';
import '../Cubit/AppStates.dart';
import '../Models/UserModel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key,required this.model,required this.type});
  final UserModel model;
  final String type;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var majorController=TextEditingController();
  var phoneController=TextEditingController();
  var fNameController=TextEditingController();
  var lNameController=TextEditingController();
  var priceController=TextEditingController();
  var addressController=TextEditingController();
  final imageController = TextEditingController();
  bool acceptCalls=false;
  bool acceptPrivateVisits=false;
  bool acceptVisitsInClinic=false;
  final  formKey = GlobalKey<FormState>();
  @override
  void initState(){

    super.initState();
    imageController.text=widget.model.image;
    majorController.text=widget.model.major;
    fNameController.text=widget.model.firstName;
    lNameController.text=widget.model.lastName;
    phoneController.text=widget.model.phone;
    addressController.text=widget.model.address;
    priceController.text=widget.model.basePrice.toString();
    acceptCalls=widget.model.acceptCalls;
    acceptPrivateVisits=widget.model.acceptPrivateVisits;
    acceptVisitsInClinic=widget.model.acceptVisitsInClinic;

  }
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){
          if(state is UpdatePatientSuccessState ){
            navigateAndFinish(context, PatientLayout(type: widget.type));
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
            body: BlocConsumer<AppCubit,AppStates>(
                listener:  (context,state) {
                  if(state is UpdateDoctorSuccessState){
                    navigateAndFinish(context, PatientLayout(type: widget.type));
                  }
                },
                builder: (context,state) {
                  return GestureDetector(
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
                            widget.model.image==''?
                            const DecorationImage(image: NetworkImage(
                                'https://www.leedsandyorkpft.nhs.uk/advice-support/wp-content/uploads/sites/3/2021/06/pngtree-image-upload-icon-photo-upload-icon-png-image_2047546.jpg')):
                            DecorationImage(image: NetworkImage(  widget.model.image),fit: BoxFit.fill )

                            )

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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('First name',style: TextStyle(fontWeight: FontWeight.bold,fontSize:MediaQuery.of(context).size.width*0.05,color: Colors.black ),),
                                    defaultTextFormField(
                                        prefix:Icons.person ,

                                        controller: fNameController,
                                        keyboardType: TextInputType.name,
                                        validate: (String? s){
                                          if(s!.isEmpty){
                                            return 'Enter First name';
                                          }
                                          return null;
                                        },
                                        label: 'First name')


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
                                    Text('Last name',style: TextStyle(fontWeight: FontWeight.bold,fontSize:MediaQuery.of(context).size.width*0.05,color: Colors.black ),),
                                    defaultTextFormField(
                                        prefix:Icons.person ,

                                        controller: lNameController,
                                        keyboardType: TextInputType.name,
                                        validate: (String? s){
                                          if(s!.isEmpty){
                                            return 'Enter Last name';
                                          }
                                          return null;
                                        },
                                        label: 'Last name')


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
                          child: ConditionalBuilder(
                            condition: state is ! UpdatePatientLoadingState,
                            builder: (context) => Center(
                              child: defaultMaterialButton(

                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    AppCubit.get(context).updatePatient(
                                        email: widget.model.email,
                                        phone: phoneController.text,
                                        uId: widget.model.uId,
                                        image: widget.model.image,
                                        firstName: fNameController.text,
                                        lastName: lNameController.text,
                                        userRole: widget.model.userRole,
                                        address: addressController.text,
                                        major: widget.model.major,
                                        acceptVisitsInClinic: acceptVisitsInClinic,
                                        acceptCalls: acceptCalls,
                                        acceptPrivateVisits: acceptPrivateVisits,
                                        basePrice: double.parse(priceController.text));
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
                  );
                }
            ),
          );
        }
    );
  }
}
