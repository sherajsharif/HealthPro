import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ri_medicare/health_card/transactions/transaction_controller.dart';
import 'package:ri_medicare/overview/widgets/loan_summary_widget.dart';
import 'package:ri_medicare/overview/overview_controller.dart';
import 'package:ri_medicare/health_card/healthcard_overview/healthcard_overview_controller.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:ri_medicare/my_loans/my_loans_controller.dart';
import 'widgets/transaction_card.dart';
import 'package:ri_medicare/models/loan_model.dart';

class OverViewPage extends GetView<OverViewController> {
  const OverViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MyLoansController myLoansController = Get.put(MyLoansController());
    final TransactionController transactionController = Get.put(TransactionController());
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _buildHeader(),
              SizedBox(height: 14,),
              _buildHealthCardSection(context),
              _buildOverviewCardGrid(context),
              Obx(() {
                if (myLoansController.isLoading.value) {
                  return const Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (myLoansController.error.value != null) {
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Center(child: Text('Error: ${myLoansController.error.value}')),
                  );
                }
                if (myLoansController.loans.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Center(child: Text('No loans found.')),
                  );
                }
                return Obx(() => LoanSummarySection(
                  loans: myLoansController.loans,
                  tileIndex: 0,
                  expandedTileIndex: controller.expandedTileIndex.value,
                  onTileExpand: (idx) => controller.expandedTileIndex.value = idx,
                ));
              }),
              _buildQuickActions(context, transactionController),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000), // ~4% opacity black
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome, Patient User",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 4),
                Obx(() => Text(
                  controller.healthCard.value != null 
                    ? "Health Card ID: ${controller.healthCard.value!.uhid}"
                    : "No Health Card",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[600],
                  ),
                )),
              ],
            ),
          ),
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {},
                  color: Colors.grey[700],
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                  child: const Text(
                    "2",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHealthCardSection(BuildContext context) {
    final healthCardController = Get.find<HeathCardOverviewController>();
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: CircularProgressIndicator(),
          ),
        );
      }

      if (controller.error.value != null) {
        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1AFF0000), // ~10% opacity red
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 40),
              const SizedBox(height: 8),
              Text(
                'Error loading health card',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
              // const SizedBox(height: 4),
              // Text(
              //   controller.error.value!,
              //   style: TextStyle(
              //     color: Colors.grey[600],
              //     fontSize: 12,
              //   ),
              //   textAlign: TextAlign.center,
              // ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => controller.fetchHealthCard(),
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      }

      if (controller.healthCard.value == null) {
        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A9E9E9E), // ~10% opacity grey
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              const Icon(Icons.credit_card_off, color: Colors.grey, size: 40),
              const SizedBox(height: 8),
              Text(
                'No Health Card Found',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'You don\'t have an active health card yet',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.symmetric(vertical: isTablet ? 24 : 16, horizontal: isTablet ? 24 : 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.deepPurple.shade300],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x4D673AB7), // ~30% opacity deepPurple
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
                        fontSize: isTablet ? 20 : 14,
                      ),
                    ),
                    Text(
                      '${controller.healthCard.value!.cardType[0].toUpperCase()}${controller.healthCard.value!.cardType.substring(1)} Health Card',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: isTablet ? 16 : 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: isTablet ? 20 : 12),
                Text(
                  'Card Number',
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: isTablet ? 12 : 10,
                  ),
                ),
                Text(
                  controller.healthCard.value!.cardNumber,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: isTablet ? 20 : 14,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: isTablet ? 20 : 12),
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
                            fontSize: isTablet ? 12 : 10,
                          ),
                        ),
                        Text(
                          controller.healthCard.value!.expiryDate.toString().split(' ')[0],
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: isTablet ? 16 : 12,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isTablet ? 12 : 8,
                        vertical: isTablet ? 6 : 4,
                      ),
                      decoration: BoxDecoration(
                        color: controller.isActive ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        controller.isActive ? 'Active' : 'Expired',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: isTablet ? 12 : 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: isTablet ? 20 : 16),
          _buildBalanceSectionOverview(context),
          SizedBox(height: isTablet ? 20 : 16),
          _buildCreditUtilizationOverview(context),
          SizedBox(height: isTablet ? 20 : 16),
          _buildActionButtonsOverview(context),
        ],
      );
    });
  }

  Widget _buildBalanceSectionOverview(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(
        spacing: isTablet ? 16 : 10,
        runSpacing: isTablet ? 16 : 10,
        children: [
          _buildBalanceCardOverview(
            'Available Balance',
            '₹${controller.healthCard.value!.availableCredit.toStringAsFixed(2)}',
            context,
          ),
          _buildBalanceCardOverview(
            'Used Credit',
            '₹${controller.healthCard.value!.usedCredit.toStringAsFixed(2)}',
            context,
          ),
          _buildBalanceCardOverview(
            'Total Credit Limit',
            '₹${controller.healthCard.value!.requestedCreditLimit.toStringAsFixed(2)}',
            context,
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCardOverview(String title, String amount, BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    return Container(
      width: isTablet ? Get.width * 0.25 : Get.width * 0.28,
      height: isTablet ? Get.height * 0.15 : Get.height * 0.11,
      padding: EdgeInsets.all(isTablet ? 16 : 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000), // ~4% opacity black
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
              fontSize: isTablet ? 14 : 12,
            ),
          ),
          const Spacer(),
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

  Widget _buildCreditUtilizationOverview(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Credit Utilization',
                style: TextStyle(
                  fontSize: isTablet ? 20 : 16,
                  fontWeight: FontWeight.bold,
                   color: Colors.black,
                ),
              ),
              Obx(() => Text(
                    '${controller.creditUtilization.toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontSize: isTablet ? 20 : 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )),
            ],
          ),
          SizedBox(height: isTablet ? 16 : 10),
          Obx(() => LinearPercentIndicator(
                lineHeight: isTablet ? 12.0 : 8.0,
                percent: controller.creditUtilization / 100,
                backgroundColor: Colors.grey[300],
                progressColor: Colors.deepPurple,
                barRadius: Radius.circular(isTablet ? 6 : 4),
                animation: true,
                animationDuration: 1000,
              )),
        ],
      ),
    );
  }

  Widget _buildActionButtonsOverview(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(
        spacing: isTablet ? 24 : 24,
        runSpacing: isTablet ? 24 : 16,
        alignment: WrapAlignment.center,
        children: [
          _buildActionButtonOverview(Icons.add, 'Add Money', context, () {
            // TODO: Implement Add Money action
          }),
          _buildActionButtonOverview(Icons.chat_bubble_outline, 'Chatbot', context, () {
            // TODO: Implement Chatbot action
             Get.toNamed('/chatbot');
          }),
        ],
      ),
    );
  }

  Widget _buildActionButtonOverview(IconData icon, String label, BuildContext context, VoidCallback onTap) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(isTablet ? 16 : 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0A000000), // ~4% opacity black
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
              fontSize: isTablet ? 11 : 9,
              color: Colors.black,
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCardGrid(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isTablet ? 3 : 2,
          childAspectRatio: isTablet ? 1.5 : 1.3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: controller.cards.length,
        itemBuilder: (context, index) {
          return Obx(() => Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(0.2 * controller.cardOffsets[index].value / 50)
              ..rotateY(0.2 * controller.cardOffsets[index].value / 50)
              ..scale(controller.cardScales[index].value),
            alignment: FractionalOffset.center,
            child: Transform.translate(
              offset: Offset(0, controller.cardOffsets[index].value),
              child: Hero(
                tag: 'card_${controller.cards[index]['route']}',
                child: Material(
                  color: Colors.transparent,
                  child: _buildOverviewCard(
                    title: controller.cards[index]['title'] as String,
                    amount: controller.cards[index]['amount'] as String,
                    icon: controller.cards[index]['icon'] as IconData,
                    subtitle: controller.cards[index]['subtitle'] as String,
                    color: controller.cards[index]['color'] as Color,
                    info: controller.cards[index]['info'] as String,
                    index: index,
                  ),
                ),
              ),
            ),
          ));
        },
      ),
    );
  }

  Widget _buildOverviewCard({
    required String title,
    required String amount,
    required IconData icon,
    required String subtitle,
    required Color color,
    required String info,
    required int index,
  }) {
    return GestureDetector(
      onTapDown: (_) => controller.onCardTapDown(index),
      onTapUp: (_) => controller.onCardTapUp(index),
      onTapCancel: () => controller.onCardTapCancel(index),
      onTap: () => Get.toNamed(controller.cards[index]['route'] as String),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A000000), // ~4% opacity black
              blurRadius: 8,
              offset: Offset(0, 2),
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
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(icon, color: color, size: 16),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              amount,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 11,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Flexible(
              child: Text(
                info,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, TransactionController transactionController) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isTablet ? 32 : 16),
      child: Column(
        children: [
          _buildExpandableActionCard(
            title: 'Recent Transactions',
            subtitle: 'Your recent health card usage',
            icon: Icons.receipt_long_outlined,
            child: _buildTransactionsList(transactionController),
            tileIndex: 1,
            expandedTileIndex: controller.expandedTileIndex.value,
            onTileExpand: (idx) => controller.expandedTileIndex.value = idx,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildExpandableActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget child,
    required int tileIndex,
    required int expandedTileIndex,
    required void Function(int) onTileExpand,
  }) {
    final isExpanded = tileIndex == expandedTileIndex;
    return Builder(
      builder: (context) => Card(
        margin: const EdgeInsets.symmetric(vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0A000000), // ~4% opacity black
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
              ),
              child: ExpansionTile(
                initiallyExpanded: isExpanded,
                onExpansionChanged: (val) {
                  if (val) {
                    onTileExpand(tileIndex);
                  } else {
                    onTileExpand(-1);
                  }
                },
                tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                title: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(icon, color: Colors.deepPurple, size: 24),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          subtitle,
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                children: [
                  SizedBox(
                    height: 220,
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: child,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionsList(TransactionController controller) {
    if(controller.transactions.isEmpty) return Center(child: Text('No Transaction found', style: TextStyle(color: Colors.grey),));
    // Get recent transactions (e.g., from a controller)
    return Column(
      children: [ ...controller.transactions.asMap().entries.map((entry) {
    final index = entry.key;
    final transaction = entry.value;
    return TransactionCard(transaction: transaction,index: index,);
    }).toList()]
    );
  }
}

class LoanSummarySection extends StatelessWidget {
  final List<Loan> loans;
  final int tileIndex;
  final int expandedTileIndex;
  final void Function(int) onTileExpand;
  const LoanSummarySection({Key? key, required this.loans, required this.tileIndex, required this.expandedTileIndex, required this.onTileExpand}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isExpanded = tileIndex == expandedTileIndex;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A000000), // ~4% opacity black
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
            ),
            child: ExpansionTile(
              initiallyExpanded: isExpanded,
              onExpansionChanged: (val) {
                if (val) {
                  onTileExpand(tileIndex);
                } else {
                  onTileExpand(-1);
                }
              },
              tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.account_balance_wallet_outlined, color: Colors.deepPurple, size: 24),
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Loan Summary',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Your active medical loans',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),

              children: [
                SizedBox(
                  height: 220,
                  child: Scrollbar(
                    child: ListView.builder(
                      itemCount: loans.length,
                      itemBuilder: (context, i) => LoanCard(loan: loans[i]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}