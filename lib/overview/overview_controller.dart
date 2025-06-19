import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OverViewController extends GetxController with GetTickerProviderStateMixin {
  late List<AnimationController> cardControllers;
  final cardScales = <RxDouble>[];
  final cardOffsets = <RxDouble>[];
  final isAnimating = false.obs;

  final cards = [
    {
      'title': 'Health Card',
      'amount': '₹25,000',
      'icon': Icons.credit_card_outlined,
      'subtitle': 'Available Credit',
      'color': Colors.green,
      'info': 'Card: HC-78901-23456',
      'route': '/home'
    },
    {
      'title': 'Active Loan',
      'amount': '₹35,000',
      'icon': Icons.account_balance_outlined,
      'subtitle': 'Remaining Balance',
      'color': Colors.deepPurple,
      'info': 'Next Payment: ₹2,500 on Dec 15',
      'route': '/loan'
    },
    {
      'title': 'Health Activity',
      'amount': '4',
      'icon': Icons.local_hospital_outlined,
      'subtitle': 'Recent Medical Visits',
      'color': Colors.blue,
      'info': 'Last Visit: Nov 20, 2023',
      'route': '/transactions'
    },
    {
      'title': 'Appointments',
      'amount': '2',
      'icon': Icons.calendar_today_outlined,
      'subtitle': 'Upcoming Appointments',
      'color': Colors.orange,
      'info': 'Next: Dec 10, 2023',
      'route': '/appointments'
    },
  ];

  @override
  void onInit() {
    super.onInit();
    _initializeAnimations();
  }

  @override
  void onReady() {
    super.onReady();
    _playEntryAnimation();
  }

  void _initializeAnimations() {
    cardControllers = List.generate(
      cards.length,
          (index) => AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this,
      ),
    );

    // Initialize observable values for scales and offsets
    for (var i = 0; i < cards.length; i++) {
      cardScales.add(1.0.obs);
      cardOffsets.add(0.0.obs);
    }

    // Add listeners to animation controllers
    for (var i = 0; i < cardControllers.length; i++) {
      cardControllers[i].addListener(() {
        cardScales[i].value = Tween<double>(
          begin: 0.8,
          end: 1.0,
        ).evaluate(
          CurvedAnimation(
            parent: cardControllers[i],
            curve: Curves.easeOutQuad,
          ),
        );

        cardOffsets[i].value = Tween<double>(
          begin: 50.0,
          end: 0.0,
        ).evaluate(
          CurvedAnimation(
            parent: cardControllers[i],
            curve: Curves.easeOutQuad,
          ),
        );
      });
    }

    // Initialize all controllers to their end state
    for (var controller in cardControllers) {
      controller.value = 1.0;
    }
  }

  void _playEntryAnimation() async {
    if (isAnimating.value) return;
    isAnimating.value = true;

    // Reset all controllers
    for (var controller in cardControllers) {
      controller.reset();
    }

    // Play staggered animation
    for (var i = 0; i < cardControllers.length; i++) {
      await Future.delayed(Duration(milliseconds: 100 * i));
      if (cardControllers[i].isAnimating) continue;
      cardControllers[i].forward();
    }

    isAnimating.value = false;
  }

  void onCardTapDown(int index) {
    cardControllers[index].reverse();
  }

  void onCardTapUp(int index) {
    cardControllers[index].forward();
  }

  void onCardTapCancel(int index) {
    cardControllers[index].forward();
  }

  @override
  void onClose() {
    for (var controller in cardControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}