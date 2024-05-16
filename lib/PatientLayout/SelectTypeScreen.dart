import 'package:clinic_project/Componant/Componant.dart';
import 'package:clinic_project/PatientLayout/PatientLayout.dart';
import 'package:flutter/material.dart';

class SelectTypeScreen extends StatelessWidget {
  const SelectTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/logo.jpg'),fit: BoxFit.fill)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              defaultMaterialButton(function: (){
                navigateTo(context, PatientLayout(type: 'acceptVisitsInClinic',));
              }, text: 'حجز', context: context),
              SizedBox(height: MediaQuery.of(context).size.height*0.1,),
              defaultMaterialButton(function: (){
                navigateTo(context, PatientLayout(type: 'acceptCalls',));
              }, text: 'تواصل', context: context),
              SizedBox(height: MediaQuery.of(context).size.height*0.1,),
              defaultMaterialButton(function: (){
                navigateTo(context, PatientLayout(type: 'acceptPrivateVisits',));
              }, text: 'زيارة', context: context),
              SizedBox(height: MediaQuery.of(context).size.height*0.1,),

              // defaultMaterialButton(function: (){
              //   navigateTo(context, PatientLayout(type: 'زيارة',));
              // }, text: 'زيارة', context: context),
            ],
          ),
        ),

      ),
    );
  }
}
