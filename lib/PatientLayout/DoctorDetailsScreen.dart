import 'package:clinic_project/Cubit/AppCubit.dart';
import 'package:clinic_project/Models/OrderModel.dart';
import 'package:clinic_project/Models/UserModel.dart';
import 'package:clinic_project/PatientLayout/PatientLayout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import '../Componant/Componant.dart';
import '../shared/local/cache_helper.dart';

class DoctorDetailsScreen extends StatefulWidget {
  const DoctorDetailsScreen({super.key,required this.model,required this.type});
final UserModel model;
  final String type;
  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  bool upload=false;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: ListView(children: [

        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Container(
              width:MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.4,
              decoration: BoxDecoration(
                  image: widget.model.image==''? DecorationImage(image: AssetImage('assets/images/doctor.png'),fit: BoxFit.fill):
                  DecorationImage(image: NetworkImage(widget.model.image),fit: BoxFit.fill)
              ),

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
                    Text(widget.model.firstName,style: TextStyle(fontWeight: FontWeight.bold,fontSize:MediaQuery.of(context).size.width*0.06,color: Colors.white ),),
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
              Row(
                children: [
                  Icon(Icons.check,color: Colors.green,),
                  SizedBox(width: 10,),
                  Text(widget.model.major,style: TextStyle(fontWeight: FontWeight.w900,color: Colors.cyan,fontSize:MediaQuery.of(context).size.width*0.045),),
                ],
              )

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
              Row(
                children: [
                  Icon(Icons.phone,color: Colors.green,),
                  SizedBox(width: 10,),
                  Text(widget.model.phone,style: TextStyle(fontWeight: FontWeight.w900,color: Colors.cyan,fontSize:MediaQuery.of(context).size.width*0.045),),
                ],
              )

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
              Text('\$     ${widget.model.basePrice}',style: TextStyle(fontWeight: FontWeight.w900,color: Colors.cyan,fontSize:MediaQuery.of(context).size.width*0.045),)

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
              Row(
                children: [
                  Icon(Icons.location_on_sharp,color: Colors.green,),
                  SizedBox(width: 10,),
                  Text(widget.model.address,style: TextStyle(fontWeight: FontWeight.w900,color: Colors.cyan,fontSize:MediaQuery.of(context).size.width*0.045),),
                ],
              )

            ],
          ),
        ),
        Container(
          color: Colors.grey,
          width: double.infinity,
          height: 1,
        ),
        ConditionalBuilder(
          condition: !upload,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: defaultMaterialButton(function: (){
                setState(() {
                  upload=true;
                });
                OrderModel order=OrderModel(
                    email: AppCubit.get(context).user.email,
                    uId: AppCubit.get(context).user.uId,
                    firstName: AppCubit.get(context).user.firstName,
                    lastName: AppCubit.get(context).user.lastName,
                    phone: AppCubit.get(context).user.phone, image: AppCubit.get(context).user.image, type: widget.type);
                var myId=CacheHelper.getData(key: 'uId');
                FirebaseFirestore.instance.collection('users').doc(widget.model.uId).collection('orders').doc(myId).set(order.toMap()).then((value) {  setState(() {
                  upload=false;
                  navigateAndFinish(context, PatientLayout(type: widget.type));
                });}).catchError((error){
                  setState(() {
                    upload=false;
                  });
                });
              }, text: 'Order Now', context: context),
            );
          }, fallback: (BuildContext context) { return Center( child: CircularProgressIndicator()); },
        ),


      ],),
    );
  }
}
