class OrderModel{
  String email='';
  String uId='';
  String firstName='';
  String lastName='';
  String phone='';
  String image='';
  String  type='';
  OrderModel({
    required this.email,
    required this.uId,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.image,
    required this.type,
});
  OrderModel.fromJson(Map<String,dynamic>json){
    firstName=json['firstName'];
    lastName=json['lastName'];
    phone=json['phone'];
    email=json['email'];
    uId=json['uId'];
    image=json['image'];
    type=json['type'];
  }
  Map<String,dynamic> toMap(){
    return{
      'firstName':firstName,
      'lastName':lastName,
      'phone':phone,
      'email':email,
      'uId':uId,
      'image':image,
      'type':type,
};
  }
  }