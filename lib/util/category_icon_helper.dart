import 'package:flutter/material.dart';

/// Утилита для получения иконки по названию категории.
/// Централизует логику, которая ранее дублировалась в 3 файлах:
/// transaction_item.dart, transactions_screen.dart, analytics_category_item.dart
abstract final class CategoryIconHelper {
  static IconData getIcon(String? name) {
    if (name == null) { return Icons.category_rounded; }
    final lower = name.toLowerCase();

    // --- Доходы ---
    if (lower.contains('salary')) { return Icons.payments_rounded; }
    if (lower.contains('bonus')) { return Icons.card_giftcard_rounded; }
    if (lower.contains('gift')) { return Icons.card_giftcard_rounded; }
    if (lower.contains('invest')) { return Icons.trending_up_rounded; }
    if (lower.contains('rent')) { return Icons.home_work_rounded; }
    if (lower.contains('freelance')) { return Icons.laptop_mac_rounded; }
    if (lower.contains('dividend')) { return Icons.account_balance_wallet_rounded; }
    if (lower.contains('cashback')) { return Icons.monetization_on_rounded; }
    if (lower.contains('income')) { return Icons.south_rounded; }

    // --- Питание ---
    if (lower.contains('food') ||
        lower.contains('restaurant') ||
        lower.contains('cafe')) { return Icons.restaurant_rounded; }
    if (lower.contains('grocer')) { return Icons.local_grocery_store_rounded; }

    // --- Транспорт ---
    if (lower.contains('publictransport') ||
        lower.contains('bus') ||
        lower.contains('metro')) { return Icons.directions_bus_rounded; }
    if (lower.contains('fuel')) { return Icons.local_gas_station_rounded; }
    if (lower.contains('parking')) { return Icons.local_parking_rounded; }
    if (lower.contains('transport') ||
        lower.contains('auto') ||
        lower.contains('car')) { return Icons.directions_car_rounded; }

    // --- Жильё ---
    if (lower.contains('utilities') ||
        lower.contains('utility')) { return Icons.water_drop_rounded; }
    if (lower.contains('repair') ||
        lower.contains('maintenance')) { return Icons.build_rounded; }
    if (lower.contains('housing') ||
        lower.contains('mortgage')) { return Icons.home_rounded; }

    // --- Прочее ---
    if (lower.contains('clothing') ||
        lower.contains('footwear') ||
        lower.contains('shop')) { return Icons.checkroom_rounded; }
    if (lower.contains('medicine') ||
        lower.contains('doctor') ||
        lower.contains('health')) { return Icons.medical_services_rounded; }
    if (lower.contains('insurance')) { return Icons.security_rounded; }
    if (lower.contains('movie') ||
        lower.contains('theater') ||
        lower.contains('entertainment') ||
        lower.contains('hobby')) { return Icons.sports_esports_rounded; }
    if (lower.contains('travel') ||
        lower.contains('vacation')) { return Icons.flight_takeoff_rounded; }
    if (lower.contains('sport') ||
        lower.contains('fitness') ||
        lower.contains('gym')) { return Icons.fitness_center_rounded; }
    if (lower.contains('education') ||
        lower.contains('course') ||
        lower.contains('learn')) { return Icons.school_rounded; }
    if (lower.contains('loan') ||
        lower.contains('debt')) { return Icons.money_off_rounded; }
    if (lower.contains('pet') ||
        lower.contains('vet')) { return Icons.pets_rounded; }
    if (lower.contains('charity')) { return Icons.favorite_rounded; }
    if (lower.contains('internet') ||
        lower.contains('communication') ||
        lower.contains('phone')) { return Icons.wifi_rounded; }
    if (lower.contains('transfer')) { return Icons.swap_horiz_rounded; }

    return Icons.category_rounded;
  }
}
