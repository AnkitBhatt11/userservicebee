import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_bee/components/button.dart';
import 'package:service_bee/components/loader.dart';
import 'package:service_bee/constants.dart';
import 'package:service_bee/navigation/navigation.dart';
import 'package:service_bee/pages/createProfile/subCategory/sub_category_bloc.dart';

import '../../../models/sub_category_item.dart';

class SubCategoryPage extends StatelessWidget{
  int id;
  SubCategoryPage(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider<SubCategoryCubit>(
        create: (context) => SubCategoryCubit(),
        child: SubCategoryWidget(id),
      )
    );
  }
}

class SubCategoryWidget extends StatelessWidget {
  int id;
  SubCategoryWidget(this.id);

  late SubCategoryCubit subCategoryCubit;

  @override
  Widget build(BuildContext context) {
    subCategoryCubit = BlocProvider.of<SubCategoryCubit>(context);
    subCategoryCubit.fetchSubCategories(id);
    return BlocBuilder<SubCategoryCubit, SubCategoryState>(
      buildWhen: (previous, current) {
        return current is! SubCategoryChangeIndex;
      },
      builder: (context, state){
        if(state is SubCategoryLoading){
          return const Loader();
        }else if(state is SubCategorySuccess){
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
                    (subCategoryCubit.subCategories.isEmpty) ? Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 150),
                      child: const Text("No subcategories found"),
                    ) : Expanded(
                      child: ListView.builder(
                        itemCount: subCategoryCubit.subCategories.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        itemBuilder: (context, pos){
                          SubCategoryItem item = subCategoryCubit.subCategories[pos];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                              child: BlocBuilder<SubCategoryCubit, SubCategoryState>(
                                buildWhen: (previousSt, currentSt) {
                                  return currentSt is SubCategoryChangeIndex;
                                },
                                builder: (context, state) {
                                  return GestureDetector(
                                    onTap: (){
                                      subCategoryCubit.changeIndex(pos);
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
                                              child: (subCategoryCubit.currentIndex == pos) ? Container(
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
                    child: (subCategoryCubit.subCategories.isEmpty) ?  MaterialButton(
                      height: 48,
                      elevation: 0,
                      minWidth: double.infinity,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)
                      ),
                      onPressed: (){
                        Navigation.instance.goBack();
                      },
                      child: const Text("BACK",style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600,fontSize: 14),),
                      color: Constants.secondaryColor,
                    ) : Row(
                      children: [
                        MaterialButton(
                          height: 48,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)
                          ),
                          onPressed: (){
                            Navigation.instance.goBack();
                          },
                          child: const Text("BACK",style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600,fontSize: 14),),
                          color: Constants.secondaryColor,
                        ),
                        const SizedBox(width: 16,),
                        Expanded(
                          child: Button(
                            onPressed: (){
                              Navigation.instance.navigate("/service",args: subCategoryCubit.subCategories[subCategoryCubit.currentIndex].id ?? 0);
                            },
                            text: "Proceed",
                          ),
                        ),
                      ],
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


