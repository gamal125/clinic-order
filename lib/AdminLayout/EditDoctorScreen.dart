import 'package:clinic_project/AdminLayout/AdminLayout.dart';
import 'package:clinic_project/Cubit/AppCubit.dart';
import 'package:clinic_project/Cubit/AppStates.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Componant/Componant.dart';
import '../Models/UserModel.dart';

class EditDoctorScreen extends StatefulWidget {
  const EditDoctorScreen({super.key,required this.model});
  final UserModel model;
  @override
  State<EditDoctorScreen> createState() => _EditDoctorScreenState();
}

class _EditDoctorScreenState extends State<EditDoctorScreen> {
  var majorController=TextEditingController();
  var phoneController=TextEditingController();
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
      listener: (context,index){},
      builder:(context,index){
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
              navigateAndFinish(context, const AdminLayout());
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

                  Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
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
                        alignment: AlignmentDirectional.centerStart,
                        width:MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.075,
                        decoration: BoxDecoration(

                          color: Colors.black.withOpacity(0.4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(widget.model.firstName,style: TextStyle(fontWeight: FontWeight.bold,fontSize:MediaQuery.of(context).size.width*0.06,color: Colors.white ),),
                                  SizedBox(width: 5,),
                                  Text(widget.model.lastName,style: TextStyle(fontWeight: FontWeight.bold,fontSize:MediaQuery.of(context).size.width*0.06,color: Colors.white ),),

                                ],
                              ),
                            ],),
                        ),
                      )

                    ],
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
                      condition: state is ! UpdateDoctorLoadingState,
                      builder: (context) => Center(
                        child: defaultMaterialButton(

                          function: () {
                            if (formKey.currentState!.validate()) {
AppCubit.get(context).updateDoctor(
    email: widget.model.email,
    phone: phoneController.text,
    uId: widget.model.uId,
    image: widget.model.image,
    firstName: widget.model.firstName,
    lastName: widget.model.lastName,
    userRole: widget.model.userRole,
    address: addressController.text,
    major: majorController.text,
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
