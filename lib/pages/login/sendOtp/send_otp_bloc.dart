import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/alert.dart';
import '../../../constants.dart';
import '../../../helpers.dart';
import '../../../navigation/navigation.dart';
import '../../../network/api_provider.dart';

abstract class SendOtpState{}

class SendOtpInitial extends SendOtpState{}

class SendOtpCubit extends Cubit<SendOtpState>{
  SendOtpCubit() : super(SendOtpInitial());
  TextEditingController mobileController = TextEditingController();

  Future<void> sendOtp() async{
    var isNetworkConnection = await Helpers.isNetwork();
    if(mobileController.text.length == 10){
      if(isNetworkConnection){
        Navigation.instance.navigate("/loadingDialog");
        final response = await ApiProvider.instance.sendOtp(mobileController.text);
        Navigation.instance.goBack();
        if(response.status ?? false){
          Navigation.instance.navigate("/verifyOtp",args: mobileController.text);
        }else{
          showError(response.message ?? "Something went wrong");
        }
      }else{
        showError(Constants.noInternet);
      }
    }else{
      showError("Invalid mobile number");
    }
  }

  void showError(String msg){
    AlertX.instance.showAlert(
        title: "Error",
        msg: msg,
        positiveButtonText: "Done",
        positiveButtonPressed: (){
          Navigation.instance.goBack();
        }
    );
  }

}