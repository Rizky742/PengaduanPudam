import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final checkboxProvider = StateProvider.autoDispose<bool>((ref) => false);
final obscureText = StateProvider.autoDispose<bool>((ref) => true);
final emailProvider = StateProvider.autoDispose<TextEditingController>((ref) => TextEditingController());
final passwordProvider = StateProvider.autoDispose<TextEditingController>((ref) => TextEditingController());
