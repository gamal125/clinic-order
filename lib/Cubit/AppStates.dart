
abstract class AppStates {}

class AppInitialState extends AppStates {}
class CreateUserInitialState extends AppStates {}
class RegisterSuccessState extends AppStates {}
class RegisterErrorState extends AppStates {
  final String error;
  RegisterErrorState(this.error);
}
class CreateUserSuccessState extends AppStates {
  final String uId;
  CreateUserSuccessState(this.uId);
}
class CreateDoctorSuccessState extends AppStates {
  final String uId;
  CreateDoctorSuccessState(this.uId);
}
class CreateUserErrorState extends AppStates {
  final String error;
  CreateUserErrorState(this.error);
}
class UpdateDoctorLoadingState extends AppStates {}
class UpdateDoctorSuccessState extends AppStates {}
class UpdatePatientLoadingState extends AppStates {}
class UpdatePatientSuccessState extends AppStates {}
class LoginLoadingState extends AppStates {}
class LogoutLoadingState extends AppStates {}
class LogoutSuccessState extends AppStates {}
class LoginSuccessState extends AppStates {
  final String uId;
  final String type;
  LoginSuccessState(this.uId,this.type);

}
class GetUserSuccessState extends AppStates {
  final String uId;
  final String type;
  GetUserSuccessState(this.uId,this.type);

}
class ChangePasswordState extends AppStates {}
class LoginErrorState extends AppStates {
  final String error;

  LoginErrorState(this.error);
}class UpdateDoctorImageSuccessStates extends AppStates {}
class UpdateDoctorImageErrorStates extends AppStates {
  final String error;

  UpdateDoctorImageErrorStates(this.error);
}