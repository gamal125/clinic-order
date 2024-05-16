// ignore_for_file: file_names


import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clinic_project/AdminLayout/EditDoctorScreen.dart';
import 'package:clinic_project/Cubit/AppCubit.dart';
import 'package:clinic_project/Models/OrderModel.dart';
import 'package:clinic_project/Models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../PatientLayout/DoctorDetailsScreen.dart';
import '../shared/local/cache_helper.dart';

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => widget,
  ),
);
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (_) => widget,
  ),
      (route) => false,
);
Widget doctorCard(UserModel model,String type,context)=>InkWell(
  onTap: (){
    AppCubit.get(context).getUser(CacheHelper.getData(key: 'uId'), context).then((value) {
      navigateTo(context, DoctorDetailsScreen(model:model ,type:type,));
    });
  },
  child: Padding(
    padding: const EdgeInsets.only(left: 1.0,right: 20,top: 10,bottom: 10),
    child: Card(
      elevation: 4,
      child: Container(
        height: MediaQuery.of(context).size.height*0.3,
        width: MediaQuery.of(context).size.width*0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.deepPurpleAccent,Colors.cyan]),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:10.0),
              child: Container(
                height: MediaQuery.of(context).size.height*0.2,
                width: MediaQuery.of(context).size.width*0.26,

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    image:model.image==''? DecorationImage(image: AssetImage('assets/images/doctor.png'),fit: BoxFit.fill):
                    DecorationImage(image: NetworkImage(model.image),fit: BoxFit.fill)
                ),
              ),
            ),
            Column(
              mainAxisAlignment:MainAxisAlignment.spaceEvenly,

              children: [
                Text('Name: ',style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.045,fontWeight: FontWeight.bold),),
                Text('Phone: ',style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.045,fontWeight: FontWeight.bold),),
                Text('Major: ',style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.045,fontWeight: FontWeight.bold),),
                Text('Address: ',style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.045,fontWeight: FontWeight.bold),),

              ],),
            Expanded(
              child: Column(
                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(model.firstName,style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.04),overflow: TextOverflow.ellipsis,maxLines: 1,),
                      SizedBox(width: 5,),
                      Text(model.lastName,style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.04),overflow: TextOverflow.ellipsis,maxLines: 1,),
                    ],
                  ),
                  Text(model.phone,style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.04),overflow: TextOverflow.ellipsis,maxLines: 1,),
                  Text(model.major,style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.04),overflow: TextOverflow.ellipsis,maxLines: 1,)
                  , Text(model.address,style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.04),overflow: TextOverflow.ellipsis,maxLines: 1,)

                ],),
            )

          ],
        ),
      ),
    ),
  ),
);
Widget orderCard(OrderModel model,context)=>InkWell(
  onTap: (){
   // navigateTo(context, DoctorDetailsScreen(model:model ,type:type,));
  },
  child: Padding(
    padding: const EdgeInsets.only(left: 1.0,right: 20,top: 10,bottom: 10),
    child: Card(
      elevation: 4,
      child: Container(
        height: MediaQuery.of(context).size.height*0.3,
        width: MediaQuery.of(context).size.width*0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.deepPurpleAccent,Colors.cyan]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.14,
                    width: MediaQuery.of(context).size.width*0.26,

                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        image:model.image==''? DecorationImage(image: AssetImage('assets/images/doctor.png'),fit: BoxFit.fill):
                        DecorationImage(image: NetworkImage(model.image),fit: BoxFit.fill)
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,

                  children: [
                    Text('Name: ',style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.045,fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                    Text('Phone: ',style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.045,fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                    Text('email: ',style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.045,fontWeight: FontWeight.bold),),

                  ],),
                Expanded(
                  child: Column(
                    mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(model.firstName,style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.04),overflow: TextOverflow.ellipsis,maxLines: 1,),
                          SizedBox(width: 5,),
                          Text(model.lastName,style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.04),overflow: TextOverflow.ellipsis,maxLines: 1,),

                        ],
                      ),
                      SizedBox(height: 5,),
                      Text(model.phone,style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.04),overflow: TextOverflow.ellipsis,maxLines: 1,),
                      SizedBox(height: 5,),
                      Text(model.email,style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.04),overflow: TextOverflow.ellipsis,maxLines: 1,)

                    ],),
                )

              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: defaultMaterialButton2(function: (){
                String myId=CacheHelper.getData(key: 'uId');
                AwesomeDialog(
                  body:    const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        Text('هل تريد حقا رفض الطلب؟'),
                        SizedBox(height: 20,),

                      ],
                    ),
                  ),
                  context: context,
                  dialogType: DialogType.warning,
                  animType: AnimType.rightSlide,

                  btnCancelOnPress: () {},
                  btnCancelText: 'لا',
                  btnOkText: 'نعم',
                  btnOkOnPress: () {
FirebaseFirestore.instance.collection('users').doc(myId).collection('orders').doc(model.uId).delete();
                  },
                ).show();
              }, text: 'Decline', context: context),
            )
          ],
        ),
      ),
    ),
  ),
);

Widget adminDoctorCard(UserModel model,context)=>InkWell(
  onTap: (){
    navigateTo(context, EditDoctorScreen(model:model ,));
  },
  child: Padding(
    padding: const EdgeInsets.only(left: 5.0,right: 25,top: 10,bottom: 10),
    child: Card(
      elevation: 4,
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.3,
            width: MediaQuery.of(context).size.width*0.93,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.deepPurpleAccent,Colors.cyan]),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.2,
                    width: MediaQuery.of(context).size.width*0.26,

                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        image:model.image==''? DecorationImage(image: AssetImage('assets/images/doctor.png'),fit: BoxFit.fill):
                        DecorationImage(image: NetworkImage(model.image),fit: BoxFit.fill)
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,

                  children: [
                    Text('Name: ',style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.045,fontWeight: FontWeight.bold),),
                    Text('Phone: ',style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.045,fontWeight: FontWeight.bold),),
                    Text('Major: ',style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.045,fontWeight: FontWeight.bold),),
                    Text('Address: ',style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.045,fontWeight: FontWeight.bold),),

                  ],),
                Expanded(
                  child: Column(
                    mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(model.firstName,style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.04),overflow: TextOverflow.ellipsis,maxLines: 1,),
                         SizedBox(width: 5,),
                          Text(model.lastName,style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.04),overflow: TextOverflow.ellipsis,maxLines: 1,),

                        ],
                      ),
                      Text(model.phone,style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.04),overflow: TextOverflow.ellipsis,maxLines: 1,),
                      Text(model.major,style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.04),overflow: TextOverflow.ellipsis,maxLines: 1,)
                      , Text(model.address,style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.04),overflow: TextOverflow.ellipsis,maxLines: 1,)

                    ],),
                )

              ],
            ),
          ),
          IconButton(onPressed: (){
            FirebaseFirestore.instance.collection('users').doc(model.uId).delete();
          }, icon: Icon(Icons.delete,color: Colors.red,),)
        ],
      ),
    ),
  ),
);

Widget defaultTextFormField({
  FocusNode? focusNode,
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String? Function(String?) validate,
  required String label,
  Color? fillColor,
  String? hint,

  onTap,
  onChanged,
  Function(String)? onFieldSubmitted,
  bool isPassword = false,
  bool isClickable = true,
  InputDecoration? decoration,
  IconData? suffix,
  IconData? prefix,
  Function? suffixPressed,
}) =>
    Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(

        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
        maxLines: 1,
        minLines: 1,
        controller: controller,
        validator: validate,
        enabled: isClickable,
        onTap: onTap,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        obscureText: isPassword,
        keyboardType: keyboardType,
        autofocus: false,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          hintTextDirection: TextDirection.ltr,

          prefixIcon: Icon(
            prefix,
            color: Colors.grey,
          ),
          suffixIcon: suffix != null ? IconButton(
            onPressed: () {suffixPressed!();},
            icon: Icon(suffix, color: Colors.grey,),
          ):null,
          filled: true,
          isCollapsed: false,
          fillColor:fillColor?? Colors.white,
          hoverColor: Colors.red.withOpacity(0.2),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color:Colors.white,
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          labelText: label,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          focusColor: const Color.fromRGBO(199, 0, 58,1),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.green,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
Widget defaultMaterialButton({
  required Function function,
  required String text,
  required var context,
  Color color=Colors.cyan,
  double radius = 5.0,
  bool isUpperCase = true,
  Function? onTap,
}) =>
    Container(
      width: MediaQuery.of(context).size.width*0.8,
      height: MediaQuery.of(context).size.width*0.12,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurpleAccent,Colors.cyan]),
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: color,
        //  color: background,
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          text,
          textAlign:TextAlign.start,


          style: const TextStyle(

            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
    );
Widget defaultMaterialButton2({
  required Function function,
  required String text,
  required var context,
  Color color=Colors.cyan,
  double radius = 5.0,
  bool isUpperCase = true,
  Function? onTap,
}) =>
    Container(
      width: MediaQuery.of(context).size.width*0.8,
      height: MediaQuery.of(context).size.width*0.12,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black,Colors.red]),
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: color,
        //  color: background,
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          text,
          textAlign:TextAlign.start,


          style: const TextStyle(

            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
    );
Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
      onPressed: () {
        function();
      },
      child: Text(text,style: TextStyle(color: Colors.cyan),),
    );
void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 10,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum  كذا اختيار من حاجة

enum ToastStates { success, error, warning }
Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;

    case ToastStates.error:
      color = Colors.red;
      break;

    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}