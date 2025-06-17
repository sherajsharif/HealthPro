import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';
import 'package:ri_medicare/health_card/healthcard_overview/healthcard_overview_controller.dart';

class HealthCardOverviewView extends GetView<HeathCardOverviewController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(MediaQuery.of(context).size.width > 600 ? 32.0 : 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              AnimatedBuilder(
                animation: controller.cardAnimationController,
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..scale(controller.cardScale.value)
                      ..rotateX(controller.cardRotateX.value + controller.cardHoverY.value * 0.1)
                      ..rotateY(controller.cardRotateY.value + controller.cardHoverX.value * 0.1),
                    alignment: FractionalOffset.center,
                    child: _buildHealthCard(context),
                  );
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              AnimatedBuilder(
                animation: controller.balanceAnimationController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, 50 * (1 - controller.balanceAnimationController.value)),
                    child: Opacity(
                      opacity: controller.balanceAnimationController.value,
                      child: _buildBalanceSection(context),
                    ),
                  );
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.035),
              _buildCreditUtilization(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              AnimatedBuilder(
                animation: controller.actionsAnimationController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, 30 * (1 - controller.actionsAnimationController.value)),
                    child: Opacity(
                      opacity: controller.actionsAnimationController.value,
                      child: Column(
                        children: [
                          _buildActionButtons(context),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                          _buildQuickActions(context),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Health Card',
              style: TextStyle(
                fontSize: Get.width > 600 ? 32 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Manage your medical expenses with ease',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: Get.width > 600 ? 16 : 12,
              ),
            ),
          ],
        ),
        Icon(Icons.credit_card,
          color: Colors.deepPurple,
          size: Get.width > 600 ? 32 : 22,
        ),
      ],
    );
  }

  Widget _buildHealthCard(BuildContext context) {
    return MouseRegion(
      onHover: (event) => controller.onCardHover(event.localPosition, context.size ?? Size.zero),
      onExit: (_) => controller.onCardExit(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical : Get.width > 600 ? 32 : 16, horizontal: Get.width > 600 ? 32 : 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.deepPurple.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withOpacity(0.3),
              blurRadius: 15,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'RI Medicare',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: Get.width > 600 ? 24 : 16,
                  ),
                ),
                Text(
                  'Gold Health Card',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: Get.width > 600 ? 20 : 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.width > 600 ? 40 : 24),
            Text(
              'Card Number',
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: Get.width > 600 ? 14 : 12,
              ),
            ),
            Obx(() => Text(
              controller.cardNumber.value,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: Get.width > 600 ? 24 : 16,
                letterSpacing: 1.5,
              ),
            )),
            SizedBox(height: Get.width > 600 ? 30 : 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Expiry',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: Get.width > 600 ? 14 : 12,
                      ),
                    ),
                    Obx(() => Text(
                      controller.expiryDate.value,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: Get.width > 600 ? 20 : 14,
                      ),
                    )),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width > 600 ? 16 : 12,
                    vertical: Get.width > 600 ? 8 : 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Active',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: Get.width > 600 ? 14 : 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceSection(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    return Wrap(
      spacing: isTablet ? 16 : 10,
      runSpacing: isTablet ? 16 : 10,
      children: [
        _buildBalanceCard(
          'Available Balance',
          '₹${controller.availableBalance.value.toStringAsFixed(0)}',
          context,
        ),
        _buildBalanceCard(
          'Used Credit',
          '₹${controller.usedCredit.value.toStringAsFixed(0)}',
          context,
        ),
        _buildBalanceCard(
          'Total Credit Limit',
          '₹${controller.totalCreditLimit.value.toStringAsFixed(0)}',
          context,
        ),
      ],
    );
  }

  Widget _buildBalanceCard(String title, String amount, BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    return Container(
      width: isTablet ? Get.width * 0.25 : Get.width * 0.28,
      height: isTablet ? Get.height * 0.15 : Get.height * 0.11,
      padding: EdgeInsets.all(isTablet ? 16 : 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
              fontSize: isTablet ? 14 : 12,
            ),
          ),
          Spacer(),
          Text(
            amount,
            style: TextStyle(
              fontSize: isTablet ? 20 : 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreditUtilization() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Credit Utilization',
              style: TextStyle(
                fontSize: Get.width > 600 ? 20 : 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Obx(() => Text(
              '${controller.creditUtilization.toStringAsFixed(0)}%',
              style: TextStyle(
                fontSize: Get.width > 600 ? 20 : 14,
                fontWeight: FontWeight.bold,
              ),
            )),
          ],
        ),
        SizedBox(height: Get.width > 600 ? 16 : 10),
        Obx(() => LinearPercentIndicator(
          lineHeight: Get.width > 600 ? 12.0 : 8.0,
          percent: controller.creditUtilization / 100,
          backgroundColor: Colors.grey[300],
          progressColor: Colors.deepPurple,
          barRadius: Radius.circular(Get.width > 600 ? 6 : 4),
          animation: true,
          animationDuration: 1000,
        )),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    return Wrap(
      spacing: isTablet ? 24 : 24,
      runSpacing: isTablet ? 24 : 16,
      alignment: WrapAlignment.spaceEvenly,

      children: [
        _buildActionButton(Icons.add, 'Add Money', context),
        _buildActionButton(Icons.download, 'Download\nStatement', context),
        _buildActionButton(Icons.refresh, 'Renew Card', context),
        _buildActionButton(Icons.report_problem_outlined, 'Report Issue', context),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(isTablet ? 16 : 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: Colors.deepPurple,
            size: isTablet ? 28 : 22,
          ),
        ),
        SizedBox(height: isTablet ? 12 : 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isTablet ? 14 : 11,
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: isTablet ? 24 : 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: isTablet ? 24 : 16),
        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: isTablet ? 3 : 2,
          mainAxisSpacing: isTablet ? 16 : 10,
          crossAxisSpacing: isTablet ? 16 : 10,
          childAspectRatio: isTablet ? 3 : 2.5,
          children: [
            _buildQuickActionCard(Icons.security, 'Card Security', context),
            _buildQuickActionCard(Icons.calculate, 'EMI Calculator', context),
            _buildQuickActionCard(Icons.local_hospital, 'Find Hospital', context),
            _buildQuickActionCard(Icons.settings, 'Card Settings', context),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActionCard(IconData icon, String label, BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    return Container(
      padding: EdgeInsets.all(isTablet ? 16 : 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.deepPurple,
            size: isTablet ? 28 : 22,
          ),
          SizedBox(width: isTablet ? 12 : 8),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: isTablet ? 16 : 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}