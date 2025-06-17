import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class HeathCardOverviewController extends GetxController with GetTickerProviderStateMixin{
  final cardNumber = 'HC-78901-23456'.obs;
  final expiryDate = '31/12/2026'.obs;
  final isActive = true.obs;
  final availableBalance = 25000.0.obs;
  final usedCredit = 15000.0.obs;
  final totalCreditLimit = 40000.0.obs;

  // Animation controllers
  late AnimationController cardAnimationController;
  late AnimationController balanceAnimationController;
  late AnimationController actionsAnimationController;

  // Animations
  late Animation<double> cardScale;
  late Animation<double> cardRotateX;
  late Animation<double> cardRotateY;
  final cardHoverX = 0.0.obs;
  final cardHoverY = 0.0.obs;

  double get creditUtilization => (usedCredit.value / totalCreditLimit.value) * 100;
  @override
  void onInit() {
    super.onInit();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    // Card animation controller
    cardAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Balance animation controller
    balanceAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // Actions animation controller
    actionsAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Card animations
    cardScale = Tween<double>(
      begin: 0.95,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: cardAnimationController,
      curve: Curves.easeOutBack,
    ));

    cardRotateX = Tween<double>(
      begin: 0.1,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: cardAnimationController,
      curve: Curves.easeOutBack,
    ));

    cardRotateY = Tween<double>(
      begin: 0.1,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: cardAnimationController,
      curve: Curves.easeOutBack,
    ));

    // Play initial animations
    cardAnimationController.forward();
    balanceAnimationController.forward();
    actionsAnimationController.forward();
  }

  void onCardHover(Offset localPosition, Size cardSize) {
    // Convert local position to values between -1 and 1
    cardHoverX.value = (localPosition.dx / cardSize.width - 0.5) * 2;
    cardHoverY.value = (localPosition.dy / cardSize.height - 0.5) * 2;
  }

  void onCardExit() {
    cardHoverX.value = 0;
    cardHoverY.value = 0;
  }

  @override
  void onClose() {
    cardAnimationController.dispose();
    balanceAnimationController.dispose();
    actionsAnimationController.dispose();
    super.onClose();
  }

}