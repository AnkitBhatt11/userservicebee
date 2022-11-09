import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_bee/components/button.dart';
import 'package:service_bee/components/loader.dart';
import 'package:service_bee/constants.dart';
import 'package:service_bee/navigation/navigation.dart';
import 'package:service_bee/pages/createProfile/services/service_bloc.dart';
import 'package:service_bee/storage/storage.dart';

import '../../../models/service_item.dart';

class ServiceEditPage extends StatelessWidget {
  int id;

  ServiceEditPage(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocProvider<ServiceCubit>(
          create: (context) => ServiceCubit(),
          child: ServiceWidget(id),
        ));
  }
}

class ServiceWidget extends StatelessWidget {
  int id;

  ServiceWidget(this.id);

  late ServiceCubit serviceCubit;

  @override
  Widget build(BuildContext context) {
    serviceCubit = BlocProvider.of<ServiceCubit>(context);
    serviceCubit.fetchServices(id);
    return BlocBuilder<ServiceCubit, ServiceState>(
      buildWhen: (previous, current) {
        return current is! ServiceChangeIndex;
      },
      builder: (context, state) {
        if (state is ServiceLoading) {
          return const Loader();
        } else if (state is ServiceSuccess) {
          return SafeArea(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 16, top: 20, bottom: 4),
                      child: Text(
                        "Select your service category",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    (serviceCubit.services.isEmpty)
                        ? Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 150),
                      child: const Text("No services found"),
                    )
                        : Expanded(
                      child: ListView.builder(
                        itemCount: serviceCubit.services.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        itemBuilder: (context, pos) {
                          ServiceItem item = serviceCubit.services[pos];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child:
                              BlocBuilder<ServiceCubit, ServiceState>(
                                  buildWhen: (previousSt, currentSt) {
                                    return currentSt is ServiceChangeIndex;
                                  }, builder: (context, state) {
                                return GestureDetector(
                                  onTap: () {
                                    serviceCubit.changeIndex(pos);
                                  },
                                  behavior: HitTestBehavior.opaque,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    30),
                                                color:
                                                Colors.blue.shade50),
                                            padding:
                                            const EdgeInsets.all(12),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                              "${Constants.imgBaseUrl}${item.image}",
                                              height: 20,
                                              width: 20,
                                              fit: BoxFit.cover,
                                              placeholder: (context, _) =>
                                              const SizedBox(),
                                              errorWidget:
                                                  (context, err, _) =>
                                              const SizedBox(),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  item.name ?? "",
                                                  style: const TextStyle(
                                                      fontSize: 14.5,
                                                      fontWeight:
                                                      FontWeight
                                                          .w500),
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  item.desc ?? "",
                                                  style: TextStyle(
                                                      fontSize: 12.5,
                                                      color: Colors
                                                          .grey.shade600,
                                                      height: 1.6),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Container(
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Constants
                                                        .yellowColor,
                                                    width: 1.2),
                                                shape: BoxShape.circle),
                                            padding:
                                            const EdgeInsets.all(5),
                                            child: (item.isSelected)
                                                ? Container(
                                              decoration: BoxDecoration(
                                                  color: Constants
                                                      .yellowColor,
                                                  shape: BoxShape
                                                      .circle),
                                            )
                                                : const SizedBox(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                    const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                    child: (serviceCubit.services.isEmpty)
                        ? MaterialButton(
                      height: 48,
                      elevation: 0,
                      minWidth: double.infinity,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      onPressed: () {
                        Navigation.instance.goBack();
                      },
                      child: const Text(
                        "BACK",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                      color: Constants.secondaryColor,
                    )
                        : Row(
                      children: [
                        MaterialButton(
                          height: 48,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          onPressed: () {
                            Navigation.instance.goBack();
                          },
                          child: const Text(
                            "BACK",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                          color: Constants.secondaryColor,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Button(
                            onPressed: () {
                              Storage.instance.selected = []; 
                              Storage.instance.selected
                                  .addAll(getSelectedItems());
                              Navigation.instance.navigate("/cityPickEdit");
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
        } else {
          return Container();
        }
      },
    );
  }

  Iterable<ServiceItem> getSelectedItems() {
    List<ServiceItem> list = [];
    for (var i in serviceCubit.services) {
      if (i.isSelected) {
        list.add(i);
      }
    }
    print(list.length);
    return list;
  }
}
