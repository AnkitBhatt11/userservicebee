import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_bee/models/category_item.dart';
import 'package:service_bee/network/api_provider.dart';

abstract class CategoryState{}

class CategoryInitial extends CategoryState{}
class CategoryChangeIndex extends CategoryState{}
class CategoryLoading extends CategoryState{}
class CategorySuccess extends CategoryState{}
class CategoryFailure extends CategoryState{
  String error;
  CategoryFailure(this.error);
}

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
  int currentIndex = 0;
  List<CategoryItem> categories = [];

  void changeIndex(int index){
    currentIndex = index;
    emit(CategoryChangeIndex());
  }

  Future<void> fetchCategories() async{
    emit(CategoryLoading());
    final response = await ApiProvider.instance.fetchCategories();
    if(response.status ?? false){
      categories = response.categories ?? [];
      emit(CategorySuccess());
    }else{
      emit(CategoryFailure(response.message ?? "Something went wrong"));
    }
  }

}