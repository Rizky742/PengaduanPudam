import 'package:flutter/material.dart';
import 'package:pengaduan/features/pengaduan/presentation/pages/pengaduan_screen.dart';

class PengaduanNavigator extends StatelessWidget {
  const PengaduanNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (context) => const PengaduanScreen(),
        );
      },
    );
  }
}
