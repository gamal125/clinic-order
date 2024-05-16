
import 'dart:io';

import 'package:clinic_project/LoginScreen/LoginScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import '../Componant/Componant.dart';
import '../Models/UserModel.dart';
import '../shared/local/cache_helper.dart';
import 'AppStates.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  //////////logout///////////////////////
  void signOut(BuildContext context)  {
    emit(LogoutLoadingState());


    FirebaseAuth.instance.signOut().then((value) async {

      CacheHelper.removeData(key: 'uId');
      CacheHelper.removeData(key: 'type');
      navigateAndFinish(context, LoginScreen());
      emit(LogoutSuccessState());
    });
  }
  //////////// userRegister  ////////////
  final ImagePicker picker2 = ImagePicker();
  File? PickedFile2;
  void userRegister({
    required String email,
    required String password,
    required String phone,

    required String image,
    required String firstName,
    required String lastName,
    required String userRole,
    required String address,
    required String major,
    required bool acceptVisitsInClinic,
    required bool acceptCalls,
    required bool acceptPrivateVisits,
    required double basePrice,
  }) {
    emit(CreateUserInitialState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {
      createUser(
          image: '',
          email: email,
          phone: phone,
          uId: value.user!.uid,
          firstName: firstName,
          lastName: lastName,
          userRole: userRole,
          address: address,
          major: major,
          acceptVisitsInClinic: acceptVisitsInClinic,
          acceptCalls: acceptCalls,
          acceptPrivateVisits: acceptPrivateVisits,
          basePrice: basePrice
      );
      emit(RegisterSuccessState());
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }
////////////////// doctor register/////////
  void doctorRegister({
    required String email,
    required String password,
    required String phone,
    required String firstName,
    required String lastName,
    required String address,
    required String major,
    required bool acceptVisitsInClinic,
    required bool acceptCalls,
    required bool acceptPrivateVisits,
    required double basePrice,
  }) {
    emit(CreateUserInitialState());

if(PickedFile2!=null){
  firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri
      .file(PickedFile2!.path)
      .pathSegments
      .last}').putFile(PickedFile2!).
  then((value) {
    value.ref.getDownloadURL().then((value){
      var imageUrl=value;
      FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {
        createUser(
            image:imageUrl,
            email: email,
            phone: phone,
            uId: value.user!.uid,
            firstName: firstName,
            lastName: lastName,
            userRole: 'doctor',
            address: address,
            major: major,
            acceptVisitsInClinic: acceptVisitsInClinic,
            acceptCalls: acceptCalls,
            acceptPrivateVisits: acceptPrivateVisits,
            basePrice: basePrice
        );
        PickedFile2 = null;

      }).catchError((error) {
        emit(RegisterErrorState(error.toString()));

      });
    });
  });
}else{
  FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {
    createUser(
        image:'',
        email: email,
        phone: phone,
        uId: value.user!.uid,
        firstName: firstName,
        lastName: lastName,
        userRole: 'doctor',
        address: address,
        major: major,
        acceptVisitsInClinic: acceptVisitsInClinic,
        acceptCalls: acceptCalls,
        acceptPrivateVisits: acceptPrivateVisits,
        basePrice: basePrice
    );
    emit(RegisterSuccessState());
  }).catchError((error) {
    emit(RegisterErrorState(error.toString()));
  });
  }
  }
  ////////////////createUser///////////////
  void createUser({
    required String email,
    required String phone,
    required String uId,
    required String image,
    required String firstName,
    required String lastName,
    required String userRole,
    required String address,
    required String major,
    required bool acceptVisitsInClinic,
    required bool acceptCalls,
    required bool acceptPrivateVisits,
    required double basePrice,
  }) {
    UserModel model=UserModel(
        email: email,
        phone: phone,
        uId: uId,
        image: image,
      firstName: firstName,
        lastName: lastName,
        userRole: userRole,
        address: address,
        major: major,
        acceptVisitsInClinic: acceptVisitsInClinic,
        acceptCalls: acceptCalls,
        acceptPrivateVisits: acceptPrivateVisits,
        basePrice: basePrice
    );

    FirebaseFirestore.instance.collection("users").doc(uId).set(model.toMap()).then((value) {

    //  userRole!='doctor'?   emit(CreateUserSuccessState(uId)):emit(CreateDoctorSuccessState(uId));
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
    });
  }
  //////////////update doctor ///////////
  void updateDoctor({
    required String email,
    required String phone,
    required String uId,
    required String image,
    required String firstName,
    required String lastName,
    required String userRole,
    required String address,
    required String major,
    required bool acceptVisitsInClinic,
    required bool acceptCalls,
    required bool acceptPrivateVisits,
    required double basePrice,
  }) {

emit(UpdateDoctorLoadingState());
if(PickedFile2==null) {
  UserModel model=UserModel(
      email: email,
      phone: phone,
      uId: uId,
      image: image,
      firstName: firstName,
      lastName: lastName,
      userRole: userRole,
      address: address,
      major: major,
      acceptVisitsInClinic: acceptVisitsInClinic,
      acceptCalls: acceptCalls,
      acceptPrivateVisits: acceptPrivateVisits,
      basePrice: basePrice
  );
  FirebaseFirestore.instance.collection("users").doc(uId)
      .update(model.toMap())
      .then((value) {
    emit(UpdateDoctorSuccessState());
  }).catchError((error) {
    emit(CreateUserErrorState(error.toString()));
  });
}else{
  firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri
      .file(PickedFile2!.path)
      .pathSegments
      .last}').putFile(PickedFile2!).
  then((value) {
    value.ref.getDownloadURL().then((value){
      UserModel model=UserModel(
          email: email,
          phone: phone,
          uId: uId,
          image: value,
          firstName: firstName,
          lastName: lastName,
          userRole: userRole,
          address: address,
          major: major,
          acceptVisitsInClinic: acceptVisitsInClinic,
          acceptCalls: acceptCalls,
          acceptPrivateVisits: acceptPrivateVisits,
          basePrice: basePrice
      );
      FirebaseFirestore.instance.collection("users").doc(uId)
          .update(model.toMap())
          .then((value) {
        emit(UpdateDoctorSuccessState());
      }).catchError((error) {
        emit(CreateUserErrorState(error.toString()));
      });
    });
  });
}

  }
  void updatePatient({
    required String email,
    required String phone,
    required String uId,
    required String image,
    required String firstName,
    required String lastName,
    required String userRole,
    required String address,
    required String major,
    required bool acceptVisitsInClinic,
    required bool acceptCalls,
    required bool acceptPrivateVisits,
    required double basePrice,
  }) {

    emit(UpdatePatientLoadingState());
    if(PickedFile2==null) {
      UserModel model=UserModel(
          email: email,
          phone: phone,
          uId: uId,
          image: image,
          firstName: firstName,
          lastName: lastName,
          userRole: userRole,
          address: address,
          major: major,
          acceptVisitsInClinic: acceptVisitsInClinic,
          acceptCalls: acceptCalls,
          acceptPrivateVisits: acceptPrivateVisits,
          basePrice: basePrice
      );
      FirebaseFirestore.instance.collection("users").doc(uId)
          .update(model.toMap())
          .then((value) {
        emit(UpdatePatientSuccessState());
      }).catchError((error) {
        emit(CreateUserErrorState(error.toString()));
      });
    }else{
      firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri
          .file(PickedFile2!.path)
          .pathSegments
          .last}').putFile(PickedFile2!).
      then((value) {
        value.ref.getDownloadURL().then((value){
          UserModel model=UserModel(
              email: email,
              phone: phone,
              uId: uId,
              image: value,
              firstName: firstName,
              lastName: lastName,
              userRole: userRole,
              address: address,
              major: major,
              acceptVisitsInClinic: acceptVisitsInClinic,
              acceptCalls: acceptCalls,
              acceptPrivateVisits: acceptPrivateVisits,
              basePrice: basePrice
          );
          PickedFile2=null;
          FirebaseFirestore.instance.collection("users").doc(uId)
              .update(model.toMap())
              .then((value) {
            emit(UpdatePatientSuccessState());
          }).catchError((error) {
            emit(CreateUserErrorState(error.toString()));
          });
        });
      });
    }

  }
//////////// getUser Model ////////////
  UserModel user=UserModel(email: 'email', uId: 'uId', firstName: 'firstName', lastName: 'lastName', phone: 'phone', image: '', userRole: 'userRole', address: 'address', major: 'major', acceptVisitsInClinic: false, acceptCalls: false, acceptPrivateVisits: false, basePrice: 0.0);

  ///////////////////////////////////////////////////////////
  Future<UserModel> getUser(String uid,context) async {
    print(uid);
    uid!=''? await FirebaseFirestore.instance.collection('users').doc(uid.toString())
        .get()
        .then((value) {
          print(value.data().toString());
      user = UserModel.fromJson(value.data()!);
      CacheHelper.saveData(key: 'type', value: user.userRole);
          emit(GetUserSuccessState(value.id,user.userRole));
      return user;

    }):user= UserModel(email: 'email', uId: 'uId', firstName: 'firstName', lastName: 'lastName', phone: 'phone', image: '', userRole: 'userRole', address: 'address', major: 'major', acceptVisitsInClinic: false, acceptCalls: false, acceptPrivateVisits: false, basePrice: 0.0);
return user;
  }
  //////////// userLogin  ////////////
  Future<void> userLogin({required String email, required String password}) async {

    emit(LoginLoadingState());

    await  FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password) .then((value) {

        CacheHelper.saveData(key: 'uId', value: value.user!.uid);

        emit(LoginSuccessState(value.user!.uid,'patient'));

    }).catchError((error) {
      showToast(text: error.toString(), state: ToastStates.error);
      emit(LoginErrorState(error.toString()));
    });
  }
////////////  ChangePassword ////////////
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;


  void changePassword() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordState());
  }
  ////////upload doctor image ///////////////

  Future<void> getImage2() async {
    final imageFile = await picker2.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      PickedFile2 = File(imageFile.path);
      emit(UpdateDoctorImageSuccessStates());
    }
    else {
      var error = 'no Image selected';
      emit(UpdateDoctorImageErrorStates(error.toString()));
    }
  }


}