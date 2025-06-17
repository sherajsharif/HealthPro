import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:ri_medicare/health_card/health_card_tab/health_card_tab_controller.dart';
import 'package:ri_medicare/health_card/healthcard_overview/healthcard_overview_view.dart';
import 'package:ri_medicare/health_card/payment/payment_view.dart';
import 'package:ri_medicare/health_card/transactions/transaction_view.dart';
import 'package:ri_medicare/health_card/transactions/transaction_controller.dart';

class HealthCardTabView extends GetView<HealthCardTabController>{
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 14, right: 14, top: 20),
              padding: const EdgeInsets.all(5),
              height: 48,
              decoration: BoxDecoration(
                color: Colors.deepPurple[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                controller: controller.tabController,
                labelColor: Colors.black,
                unselectedLabelStyle: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
                unselectedLabelColor:  Colors.black,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerHeight: 0,
                labelStyle: TextStyle(color: Colors.deepPurple[200], fontSize: 14, fontWeight: FontWeight.bold),
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                tabs: const [
                  Tab(text: 'Health Card',),
                  Tab(text: 'Transactions'),
                  Tab(text: 'Payments'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                  children: [
                    HealthCardOverviewView(),
                    TransactionView(),
                    PaymentView()
                  ]
              ),
            ),
          ],
        ),
    );
  }

}