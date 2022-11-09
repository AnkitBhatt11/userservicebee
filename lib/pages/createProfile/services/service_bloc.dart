import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_bee/network/api_provider.dart';

import '../../../models/service_item.dart';

abstract class ServiceState{}

class ServiceInitial extends ServiceState{}
class ServiceChangeIndex extends ServiceState{}
class ServiceLoading extends ServiceState{}
class ServiceSuccess extends ServiceState{}
class ServiceFailure extends ServiceState{
  String error;
  ServiceFailure(this.error);
}

class ServiceCubit extends Cubit<ServiceState> {
  ServiceCubit() : super(ServiceInitial());
  List<ServiceItem> services = [];

  void changeIndex(int index){
    services[index].isSelected = !services[index].isSelected;
    emit(ServiceChangeIndex());
  }


  Future<void> fetchServices(int id) async{
    emit(ServiceLoading());
    final response = await ApiProvider.instance.fetchServices(id);
    if(response.status ?? false){
      services = response.services ?? [];
      emit(ServiceSuccess());
    }else{
      emit(ServiceFailure(response.message ?? "Something went wrong"));
    }
  }

}