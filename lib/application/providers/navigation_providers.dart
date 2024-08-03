// lib/application/providers/navigation_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);
final pageControllerProvider = Provider<PageController>((ref) => PageController());
