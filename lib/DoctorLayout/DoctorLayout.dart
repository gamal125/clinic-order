import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clinic_project/Models/OrderModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import '../Componant/Componant.dart';
import '../Cubit/AppCubit.dart';
import '../PatientLayout/ProfileScreen.dart';
import '../shared/local/cache_helper.dart';


class DoctorLayout extends StatefulWidget {
  const DoctorLayout({super.key});

  @override
  State<DoctorLayout> createState() => _DoctorLayoutState();
}

class _DoctorLayoutState extends State<DoctorLayout> {

  OrderModel? model;
  List<OrderModel> orderModels=[];
  bool tapped=false;
  List<OrderModel>  Search=[];
  List<OrderModel>  filesSearch=[];
  var searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
   var id= CacheHelper.getData(key: 'uId');
    return    StreamBuilder<QuerySnapshot>(
        stream:FirebaseFirestore.instance.collection('users').doc(id).collection('orders').snapshots(),
        builder: (context,snapshot){
          if(snapshot.data!=null){
            orderModels.clear();
            for (var doc in snapshot.data!.docs) {
           
                final model = OrderModel(
                  firstName:doc['firstName'],
                  lastName:doc['lastName'],
                  phone:doc['phone'],
                  email:doc['email'],
                  uId:doc['uId'],
                  image:doc['image'],
                  type:doc['type'],
                );
                orderModels.add(model);
            }
          }
          return ConditionalBuilder(
            condition:snapshot.data!=null,
            builder:(context){return Scaffold(
              appBar:!tapped?
              AppBar(
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

                title: Center(child: Text('Doctor page',style: TextStyle(color: Colors.white),)),
                actions: [
                  IconButton(onPressed: (){
                    setState(() {
                      tapped=true;
                    });
                  }, icon: Icon(Icons.search)),
                  IconButton(onPressed: (){
                    AppCubit.get(context).getUser(CacheHelper.getData(key: 'uId'), context).then((value) {

                      navigateTo(context, ProfileScreen(model: value, type: "acceptVisitsInClinic"));
                    });
                  }, icon: Icon(Icons.person)),
                ],
              ):
              AppBar(
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

                title: Center(child: Text('Doctor page',style: TextStyle(color: Colors.white),)),
                actions: [

                  IconButton(onPressed: (){
                    AppCubit.get(context).getUser(CacheHelper.getData(key: 'uId'), context).then((value) {

                      navigateTo(context, ProfileScreen(model: value, type: "acceptVisitsInClinic"));
                    });
                  }, icon: Icon(Icons.person)),
                ],
              )
              ,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    tapped?Row(
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
                        itemBuilder: (BuildContext context, int index) =>searchController.text.isEmpty? orderCard(orderModels[index],context):orderCard(filesSearch[index],context),
                        itemCount: searchController.text.isEmpty?orderModels.length:filesSearch.length,
                      ),
                    ),
                  ],
                ),
              ),

            );}, fallback: (BuildContext context) { return Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor:Colors.deepPurpleAccent ,
                title: Center(child: Text('Doctor page',style: TextStyle(color: Colors.white),)),
                actions: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.search)),
                  IconButton(onPressed: (){
                    AppCubit.get(context).getUser(CacheHelper.getData(key: 'uId'), context).then((value) {

                      navigateTo(context, ProfileScreen(model: value, type: ''));
                    });
                  }, icon: Icon(Icons.person)),
                ],
              ),
              body: Center(child: Text('No Orders Yet!'))); },
          );
        }
    );
  }
  void searchPhone(String query) async {
    final suggest=orderModels.where((service){
      final serviceTitle=service.firstName.toLowerCase()+service.lastName.toLowerCase();
      final input=query.toLowerCase();
      return serviceTitle.contains(input);
    }).toList();



    setState(() {
      filesSearch.clear();
      Search.clear();
      Search=suggest;

      for (var element in Search) {
        filesSearch.contains(element)?null:filesSearch.add(element);
      }

      filesSearch.toSet().toList();


    });
  }
}
