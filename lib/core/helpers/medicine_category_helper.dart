import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Medicine category icons and colors
enum MedicineCategory {
  painkiller,
  vitamin,
  antibiotic,
  cardiovascular,
  digestive,
  respiratory,
  other,
}

/// Helper class for medicine category mapping
class MedicineCategoryHelper {
  static MedicineCategory getCategoryFromName(String medicineName) {
    final name = medicineName.toLowerCase();

    if (name.contains('paracetamol') ||
        name.contains('ibuprofen') ||
        name.contains('aspirin') ||
        name.contains('pain')) {
      return MedicineCategory.painkiller;
    } else if (name.contains('vitamin') ||
        name.contains('zinc') ||
        name.contains('calcium')) {
      return MedicineCategory.vitamin;
    } else if (name.contains('antibiotic') ||
        name.contains('amoxicillin') ||
        name.contains('penicillin')) {
      return MedicineCategory.antibiotic;
    } else if (name.contains('blood') ||
        name.contains('pressure') ||
        name.contains('heart') ||
        name.contains('aspirin')) {
      return MedicineCategory.cardiovascular;
    } else if (name.contains('digestive') ||
        name.contains('acid') ||
        name.contains('antacid') ||
        name.contains('omeprazole')) {
      return MedicineCategory.digestive;
    } else if (name.contains('respiratory') ||
        name.contains('asthma') ||
        name.contains('cough')) {
      return MedicineCategory.respiratory;
    }
    return MedicineCategory.other;
  }

  static IconData getCategoryIcon(MedicineCategory category) {
    switch (category) {
      case MedicineCategory.painkiller:
        return Icons.healing;
      case MedicineCategory.vitamin:
        return Icons.spa;
      case MedicineCategory.antibiotic:
        return Icons.local_pharmacy;
      case MedicineCategory.cardiovascular:
        return Icons.favorite;
      case MedicineCategory.digestive:
        return Icons.restaurant;
      case MedicineCategory.respiratory:
        return Icons.air;
      case MedicineCategory.other:
        return Icons.medication;
    }
  }

  static Color getCategoryColor(MedicineCategory category) {
    switch (category) {
      case MedicineCategory.painkiller:
        return AppColors.medicineCategories[0];
      case MedicineCategory.vitamin:
        return AppColors.medicineCategories[1];
      case MedicineCategory.antibiotic:
        return AppColors.medicineCategories[2];
      case MedicineCategory.cardiovascular:
        return AppColors.medicineCategories[3];
      case MedicineCategory.digestive:
        return AppColors.medicineCategories[4];
      case MedicineCategory.respiratory:
        return AppColors.medicineCategories[5];
      case MedicineCategory.other:
        return AppColors.primary;
    }
  }

  static String getCategoryName(MedicineCategory category) {
    switch (category) {
      case MedicineCategory.painkiller:
        return 'Painkillers';
      case MedicineCategory.vitamin:
        return 'Vitamins';
      case MedicineCategory.antibiotic:
        return 'Antibiotics';
      case MedicineCategory.cardiovascular:
        return 'Cardiovascular';
      case MedicineCategory.digestive:
        return 'Digestive';
      case MedicineCategory.respiratory:
        return 'Respiratory';
      case MedicineCategory.other:
        return 'Other';
    }
  }
}
