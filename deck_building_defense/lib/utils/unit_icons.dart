import 'package:flutter/material.dart';

class UnitIcons {
  static IconData getUnitIcon(String unitName) {
    switch (unitName) {
      case "마린":
        return Icons.person_4;
      case "파이어뱃":
        return Icons.local_fire_department;
      case "고스트":
        return Icons.visibility_off;
      case "시즈탱크":
        return Icons.security;
      case "메딕":
        return Icons.medical_services;
      default:
        return Icons.flash_on;
    }
  }

  static Color getUnitColor(String unitName) {
    switch (unitName) {
      case "마린":
        return Colors.blue;
      case "파이어뱃":
        return Colors.red;
      case "고스트":
        return Colors.purple;
      case "시즈탱크":
        return Colors.orange;
      case "메딕":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  static String getUnitType(String unitName) {
    switch (unitName) {
      case "마린":
        return "보병";
      case "파이어뱃":
        return "화염";
      case "고스트":
        return "저격";
      case "시즈탱크":
        return "기갑";
      case "메딕":
        return "지원";
      default:
        return "유닛";
    }
  }
}