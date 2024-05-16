class UserModel{
  String email='';
  String uId='';
  String firstName='';
  String lastName='';
  String phone='';
  String image='';
  String userRole='';
  String address='';
  String major='';
  bool acceptVisitsInClinic=false;
  bool acceptCalls=false;
  bool acceptPrivateVisits=false;
  double basePrice=0;


  UserModel({
    required this.email,
    required this.uId,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.image,
    required this.userRole,
    required this.address,
    required this.major,
    required this.acceptVisitsInClinic,
    required this.acceptCalls,
    required this.acceptPrivateVisits,
    required this.basePrice,



  });

  UserModel.fromJson(Map<String,dynamic>json){
    firstName=json['firstName'];
    lastName=json['lastName'];
    phone=json['phone'];
    email=json['email'];
    uId=json['uId'];
    image=json['image'];
    userRole=json['userRole'];
    address=json['address'];
    major=json['major'];
    acceptVisitsInClinic=json['acceptVisitsInClinic'];
    acceptCalls=json['acceptCalls'];
    acceptPrivateVisits=json['acceptPrivateVisits'];
    basePrice=json['basePrice'];

  }
  Map<String,dynamic> toMap(){
    return{
      'firstName':firstName,
      'lastName':lastName,
      'phone':phone,
      'email':email,
      'uId':uId,
      'image':image,
      'address':address,
      'userRole':userRole,
      'major':major,
      'acceptVisitsInClinic':acceptVisitsInClinic,
      'acceptCalls':acceptCalls,
      'acceptPrivateVisits':acceptPrivateVisits,
      'basePrice':basePrice,

    };
  }


}