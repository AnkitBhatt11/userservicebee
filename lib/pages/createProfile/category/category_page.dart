import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_bee/components/button.dart';
import 'package:service_bee/components/loader.dart';
import 'package:service_bee/constants.dart';
import 'package:service_bee/navigation/navigation.dart';
import 'package:service_bee/pages/createProfile/category/category_bloc.dart';
import '../../../models/category_item.dart';

class CategoryPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider<CategoryCubit>(
        create: (context) => CategoryCubit(),
        child: CategoryWidget(),
      )
    );
  }
}

class CategoryWidget extends StatelessWidget {
  late CategoryCubit categoryCubit;

  @override
  Widget build(BuildContext context) {
    categoryCubit = BlocProvider.of<CategoryCubit>(context);
    categoryCubit.fetchCategories();
    return BlocBuilder<CategoryCubit, CategoryState>(
      buildWhen: (previous, current) {
        return current is! CategoryChangeIndex;
      },
      builder: (context, state){
        if(state is CategoryLoading){
          return const Loader();
        }else if(state is CategorySuccess){
          return SafeArea(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 16,top: 20,bottom: 4),
                      child: Text("Select your service category",style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),),
                    ),
                    (categoryCubit.categories.isEmpty) ? Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 50),
                      child: Text("No categories found"),
                    ) : Expanded(
                      child: ListView.builder(
                        itemCount: categoryCubit.categories.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        itemBuilder: (context, pos){
                          CategoryItem item = categoryCubit.categories[pos];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                              child: BlocBuilder<CategoryCubit, CategoryState>(
                                buildWhen: (previousSt, currentSt) {
                                  return currentSt is CategoryChangeIndex;
                                },
                                builder: (context, state) {
                                  return GestureDetector(
                                    onTap: (){
                                      categoryCubit.changeIndex(pos);
                                    },
                                    behavior: HitTestBehavior.opaque,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(30),
                                                  color: Colors.blue.shade50
                                              ),
                                              padding: const EdgeInsets.all(12),
                                              child: CachedNetworkImage(
                                                imageUrl: "${Constants.imgBaseUrl}${item.image}",
                                                height: 20,
                                                width: 20,
                                                fit: BoxFit.cover,
                                                placeholder: (context, _) => const SizedBox(),
                                                errorWidget: (context, err, _) => const SizedBox(),
                                              ),
                                            ),
                                            const SizedBox(width: 16,),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(item.name ?? "",style: const TextStyle(fontSize: 14.5,fontWeight: FontWeight.w500),),
                                                  const SizedBox(height: 4,),
                                                  Text(item.desc ?? "",style: TextStyle(fontSize: 12.5,color: Colors.grey.shade600,height: 1.6),),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 16,),
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Constants.yellowColor,width: 1.2),
                                                  shape: BoxShape.circle
                                              ),
                                              padding: const EdgeInsets.all(5),
                                              child: (categoryCubit.currentIndex == pos) ? Container(
                                                decoration: BoxDecoration(
                                                    color: Constants.yellowColor,
                                                    shape: BoxShape.circle
                                                ),
                                              ) : const SizedBox(),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 60,),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16,right: 16,bottom: 8),
                    child: Button(
                      onPressed: (){
                        Navigation.instance.navigate("/subCategory",args: categoryCubit.categories[categoryCubit.currentIndex].id ?? 0);
                      },
                      text: "Proceed",
                    ),
                  ),
                )
              ],
            ),
          );
        }else{
          return Container();
        }
      },
    );
  }
}


