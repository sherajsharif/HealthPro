import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OverViewController extends GetxController {
  // Animation states for each card
  final List<Map<String, RxDouble>> cardAnimations = [];

  @override
  void onInit() {
    super.onInit();
    // Initialize animation states for 4 cards
    for (int i = 0; i < 4; i++) {
      cardAnimations.add({
        'offset': 100.0.obs, // Initial offset for slide-up animation
        'scale': 1.0.obs,    // Scale for press animation
      });
    }

    // Trigger initial animations after frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      animateCardsIn();
    });
  }

  void animateCardsIn() {
    for (var i = 0; i < cardAnimations.length; i++) {
      Future.delayed(Duration(milliseconds: 100 * i), () {
        cardAnimations[i]['offset']?.value = 0.0;
      });
    }
  }

  void onCardPressed(int index) {
    cardAnimations[index]['scale']?.value = 0.95;
  }

  void onCardReleased(int index) {
    cardAnimations[index]['scale']?.value = 1.0;
  }
}