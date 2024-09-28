import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class TextControllerCubit extends Cubit<void> {
  final TextEditingController searchController = TextEditingController();

  TextControllerCubit() : super(null);

  void reset() {
    searchController.clear();
  }

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}
