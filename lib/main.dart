import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pengaduan/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pengaduan/features/auth/presentation/bloc/ui_bloc.dart';
import 'package:pengaduan/features/home/presentation/bloc/dashboard_bloc.dart';
import 'package:pengaduan/features/home/presentation/bloc/periode_bloc.dart';
import 'package:pengaduan/features/pengaduan/presentation/bloc/pengaduan_bloc.dart';
import 'package:pengaduan/features/pengaduan/presentation/bloc/petugas_bloc.dart';
import 'package:pengaduan/init_dependencies.dart';
import 'package:pengaduan/features/home/presentation/pages/home_page_screen.dart';
import 'package:pengaduan/features/auth/presentation/pages/login_page_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  await Hive.initFlutter();
  //  Hive.registerAdapter(Auth;);
  // await Hive.openBox('UserDataBox');
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<DashboardBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<PeriodeBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<PengaduanBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<PetugasBloc>(),
      ),
      BlocProvider(
        create: (context) => UiBloc(),
      ),
      // BlocProvider(
      //   create: (context) => NavigationBloc(PageController()),
      // ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/login',
          routes: {
            '/login': (context) => const LoginPage(),
            '/home': (context) => const Homepage(),
          },
        );
      },
    );
  }
}
