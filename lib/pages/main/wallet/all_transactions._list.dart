import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:service_bee/models/notification.dart' as N;
import 'package:service_bee/models/transactions.dart';
import 'package:service_bee/network/api_provider.dart';
import 'package:service_bee/pages/notification/notification_detail_page.dart';

class AllTransactionsPage extends StatefulWidget {
  const AllTransactionsPage({Key? key}) : super(key: key);

  @override
  State<AllTransactionsPage> createState() => _AllTransactionsPageState();
}

class _AllTransactionsPageState extends State<AllTransactionsPage> {
  List<Transactions> transactions = [];
  int page = 1;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  void _onRefresh() async {
    // monitor network fetch
    page = 1;
    final response = await ApiProvider.instance.getTransactions(page);
    if (response.status ?? false) {
      transactions = response.transactions ?? [];
      setState(() {});
      _refreshController.refreshCompleted();
    } else {
      _refreshController.refreshFailed();
    }

    // if failed,use refreshFailed()
  }

  void _onLoading() async {
    // monitor network fetch
    ++page;
    final response = await ApiProvider.instance.getTransactions(page);
    if (response.status ?? false) {
      transactions = response.transactions ?? [];
      setState(() {});
      _refreshController.loadComplete();
    } else {
      _refreshController.loadFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "All Transactions",
          style: Theme.of(context).textTheme.caption!.copyWith(
                letterSpacing: 0.1,
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
        ),
        centerTitle: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              // color: Colors.indigo[100],
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropHeader(),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus? mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Text("");
              } else if (mode == LoadStatus.loading) {
                body = CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = Text("Load Failed!Click retry!");
              } else if (mode == LoadStatus.canLoading) {
                body = Text("");
              } else {
                body = Text("No more Data");
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (cont, count) {
                  var current = transactions[count];
                  return Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  current.description.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          letterSpacing: 0.6,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline1!
                                              .color,
                                          height: 1.2),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  current.statu.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          letterSpacing: 0.6,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: (current.statu != 'success')
                                              ? Theme.of(context)
                                                  .textTheme
                                                  .headline1!
                                                  .color
                                              : Colors.green,
                                          height: 1.2),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  "\u{20B9}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: Colors.black),
                                  // (current.statu != 'success')
                                  //     ? Colors.black
                                  //     : Colors.green),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  current.amount.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          letterSpacing: 0.6,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              current.created_at.toString().substring(0, 10),
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                      letterSpacing: 0.6,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
