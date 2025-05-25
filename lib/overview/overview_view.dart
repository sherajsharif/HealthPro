import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ri_medicare/overview/overview_controller.dart';


class OverViewPage extends GetView<OverViewController> {
  const OverViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const Divider(),
            _buildOverviewCardGrid(),
            _buildOtherCards(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(right: 14.0, left: 14.0, top: 14.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome, Patient User",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const Text(
                "Health Card ID: HC-78901-23456",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.notifications_none_rounded,
                  size: 24,
                ),
                onPressed: () {},
              ),
              Positioned(
                right: 9,
                top: 5,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                  child: const Text(
                    "2",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person_2_outlined,
                size: 24,
              ))
        ],
      ),
    );
  }

  Widget _buildOverviewCardGrid() {
    final cards = [
      {'title': "Health Card", 'price': '\$25,000', 'icon': Icons.credit_card, 'overview': 'Available Credit', 'color': Colors.green, 'reminder': "Card: HC-78901-23456"},
      {'title': "Active Loan", 'price': '\$35,000', 'icon': Icons.credit_card, 'overview': 'Remaining Balance', 'color': Colors.indigoAccent, 'reminder': "Next Payment: \u{20B9}2500 on 2023-12-15"},
      {'title': "Health Activity", 'price': '4', 'icon': Icons.credit_card, 'overview': 'Recent Medical Visits', 'color': Colors.green, 'reminder': "Last Visit: Nov 20, 2023"},
      {'title': "Appointments", 'price': '2', 'icon': Icons.credit_card, 'overview': 'Upcoming Appointments', 'color': Colors.indigoAccent, 'reminder': "Next: 2023-12-10"},
    ];

    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(14),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.4,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18
        ),
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return Obx(() => Transform.translate(
            offset: Offset(0, controller.cardAnimations[index]['offset']!.value),
            child: Transform.scale(
              scale: controller.cardAnimations[index]['scale']!.value,
              child: GestureDetector(
                onTapDown: (_) => controller.onCardPressed(index),
                onTapUp: (_) => controller.onCardReleased(index),
                onTapCancel: () => controller.onCardReleased(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutQuad,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001) // perspective
                    ..rotateX(0.1 * (1 - controller.cardAnimations[index]['scale']!.value))
                    ..rotateY(0.1 * (1 - controller.cardAnimations[index]['scale']!.value)),
                  child: _buildOverviewCard(
                    cards[index]['title'] as String,
                    cards[index]['price'] as String,
                    cards[index]['icon'] as IconData,
                    cards[index]['overview'] as String,
                    cards[index]['color'] as Color,
                    cards[index]['reminder'] as String,
                  ),
                ),
              ),
            ),
          ));
        }
    );
  }

  Widget _buildOverviewCard(String title, String price, IconData icon, String overview, Color overviewColor, String reminder) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
              ),
              const Spacer(),
              Icon(
                icon,
                color: Colors.grey,
                size: 20,
              )
            ],
          ),
          Text(
            price,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          Text(
            overview,
            style: TextStyle(fontSize: 11, color: overviewColor),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            reminder,
            style: const TextStyle(
                fontWeight: FontWeight.w400, fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherCards(){
    return Column(
      children: [
        _buildContainer(
          margin: EdgeInsets.all(14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recent Transactions",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const Text(
                    "Your recent health card transactions",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.grey),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios_rounded,)
            ],
          ),
        ),

        _buildContainer(
          margin: EdgeInsets.all(14),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Upcoming Appointments",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const Text(
                      "Your scheduled medical appointments",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.grey),
                    ),
                  ],
                ),
                Icon(Icons.arrow_forward_ios_rounded,)
              ],
            )
        ),
      ],
    );
  }

  Widget _buildContainer({required Widget child, EdgeInsetsGeometry? margin}){
    return Container(
      margin: margin,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ]
      ),
      child: child,
    );
  }
}