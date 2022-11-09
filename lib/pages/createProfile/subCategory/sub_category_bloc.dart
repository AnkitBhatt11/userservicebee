import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_bee/network/api_provider.dart';
import '../../../models/sub_category_item.dart';

abstract class SubCategoryState{}

class SubCategoryInitial extends SubCategoryState{}
class SubCategoryChangeIndex extends SubCategoryState{}
class SubCategoryLoading extends SubCategoryState{}
class SubCategorySuccess extends SubCategoryState{}
class SubCategoryFailure extends SubCategoryState{
  String error;
  SubCategoryFailure(this.error);
}

class SubCategoryCubit extends Cubit<SubCategoryState> {
  SubCategoryCubit() : super(SubCategoryInitial());
  int currentIndex = 0;
  List<SubCategoryItem> subCategories = [];

  void changeIndex(int index){
    currentIndex = index;
    emit(SubCategoryChangeIndex());
  }

  Future<void> fetchSubCategories(int id) async{
    emit(SubCategoryLoading());
    final response = await ApiProvider.instance.fetchSubCategories(id);
    if(response.status ?? false){
      subCategories = response.subCategories ?? [];
      emit(SubCategorySuccess());
    }else{
      emit(SubCategoryFailure(response.message ?? "Something went wrong"));
    }
  }

}