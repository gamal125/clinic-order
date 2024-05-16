import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../Componant/Componant.dart';
import '../Cubit/AppCubit.dart';
import '../Models/UserModel.dart';
import 'AddDoctorScreen.dart';

class AdminLayout extends StatefulWidget {
  const AdminLayout({super.key});

  @override
  State<AdminLayout> createState() => _AdminLayoutState();
}

class _AdminLayoutState extends State<AdminLayout> {
  List<UserModel> userModels=[];
  bool tapped=false;
  List<UserModel>  Search=[];
  List<UserModel>  filesSearch=[];
  var searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
      stream:FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context,snapshot){
    if(snapshot.data!=null){
    userModels.clear();
    for (var doc in snapshot.data!.docs) {
      if(doc['userRole']=='doctor'){
    final model = UserModel(
        firstName:doc['firstName'],
        lastName:doc['lastName'],
        phone:doc['phone'],
        email:doc['email'],
        uId:doc['uId'],
        image:doc['image'],
        userRole:doc['userRole'],
        address:doc['address'],
        major:doc['major'],
        acceptVisitsInClinic:doc['acceptVisitsInClinic'],
        acceptCalls:doc['acceptCalls'],
        acceptPrivateVisits:doc['acceptPrivateVisits'],
        basePrice:doc['basePrice'],
    );
    userModels.add(model);
      }
    }
    }
        return ConditionalBuilder(
          condition:snapshot.data!=null,
          builder:(context){

            return Scaffold(
            appBar:!tapped?  AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor:Colors.deepPurpleAccent ,
              leading:IconButton(onPressed: (){AwesomeDialog(
                body:    const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Text('هل تريد حقا تسجيل الخروج'),
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
                  AppCubit.get(context).signOut(context);
                },
              ).show();}, icon: Icon(Icons.logout)),
              title: Center(child: Text('Admin page',style: TextStyle(color: Colors.white),)),
              actions: [
                IconButton(onPressed: (){
                  setState(() {
                    tapped=true;
                  });
                }, icon: Icon(Icons.search)),
              ],
            ): AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor:Colors.deepPurpleAccent ,
              leading:IconButton(onPressed: (){
                AwesomeDialog(
                body:    const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Text('هل تريد حقا تسجيل الخروج'),
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
                  AppCubit.get(context).signOut(context);
                },
              ).show();}, icon: Icon(Icons.logout)),
              title: Center(child: Text('Admin page',style: TextStyle(color: Colors.white),)),
            ),
            body: GestureDetector(
              onTap:(){
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                tapped?    Row(
                  children: [
                    IconButton(onPressed: (){
                      setState(() {
                        searchController.text='';
                        tapped=false;
                      });
                    }, icon: Icon(Icons.check)),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: TextField(
                          onChanged: (value){
                            searchPhone(value);
                            setState(() {
                              searchController.text=value;
                            });

                          },
                          textAlign:TextAlign.left,
                          controller: searchController,
                          cursorColor: Colors.black,
                          decoration:  InputDecoration(
                            labelText: "",
                            filled: true,
                            fillColor: Colors.white,
                            border:  OutlineInputBorder(
                              borderRadius:  BorderRadius.circular(30.0),
                            ),
                          ),

                          keyboardType: TextInputType.text,

                        ),
                      ),

                    ),
                  ],
                ):SizedBox(),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) =>searchController.text.isEmpty? adminDoctorCard(userModels[index],context):
                        adminDoctorCard(filesSearch[index],context),
                        itemCount: searchController.text.isEmpty?userModels.length:filesSearch.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(onPressed: (){
              navigateTo(context, AddDoctorScreen());
            },child: Icon(Icons.add,color: Colors.white,),backgroundColor: Colors.deepPurpleAccent,),
          );}, fallback: (BuildContext context) { return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor:Colors.deepPurpleAccent ,
              title: Center(child: Text('Admin page',style: TextStyle(color: Colors.white),)),
              actions: [
                IconButton(onPressed: (){}, icon: Icon(Icons.search)),
              ],
            ),
            body: Center(child:  Text('No Orders Yet!'))); },
        );
      }
    );
  }
  void searchPhone(String query) async {
    final suggest=userModels.where((service){
      final serviceTitle=service.firstName.toLowerCase()+service.lastName.toLowerCase();
      final input=query.toLowerCase();
      return serviceTitle.contains(input);
    }).toList();

    final suggest1=userModels.where((service){
      final serviceTitle=service.major.toLowerCase();
      final input=query.toLowerCase();
      return serviceTitle.contains(input);
    }).toList();

    setState(() {
      filesSearch.clear();
      Search.clear();
      Search=suggest1+suggest;

      for (var element in Search) {
        filesSearch.contains(element)?null:filesSearch.add(element);
      }

      filesSearch.toSet().toList();


    });
  }
}
