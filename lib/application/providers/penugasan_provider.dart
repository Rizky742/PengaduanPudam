import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dropdownValueProvider = StateProvider.autoDispose<String?>((ref) => null);
final petugasController = Provider.autoDispose<TextEditingController>(
    (ref) => TextEditingController());
final dateController =
    StateProvider.autoDispose<DateTime>((ref) => DateTime(2024, 4, 4));
final dayProvider = StateProvider.autoDispose<String?>((ref) => null);
final monthProvider = StateProvider.autoDispose<String?>((ref) => null);
final yearProvider = StateProvider.autoDispose<String?>((ref) => null);
