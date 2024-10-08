import 'package:get_it/get_it.dart';
import 'package:pengaduan/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:pengaduan/features/auth/data/repository/auth_repository_impl.dart';
import 'package:pengaduan/features/auth/domain/repository/auth_repository.dart';
import 'package:pengaduan/features/auth/domain/usecases/sign_in.dart';
import 'package:pengaduan/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pengaduan/features/home/data/datasources/dashboard_remote_datasource.dart';
import 'package:pengaduan/features/home/data/repository/dashboard_repository_impl.dart';
import 'package:pengaduan/features/home/domain/repository/dashboard_repository.dart';
import 'package:pengaduan/features/home/domain/usecases/get_dashboard_by_periode.dart';
import 'package:pengaduan/features/home/domain/usecases/get_periode.dart';
import 'package:pengaduan/features/home/presentation/bloc/dashboard_bloc.dart';
import 'package:pengaduan/features/home/presentation/bloc/periode_bloc.dart';
import 'package:pengaduan/features/pengaduan/data/datasources/pengaduan_remote_datasource.dart';
import 'package:pengaduan/features/pengaduan/data/repository/pengaduan_repository_impl.dart';
import 'package:pengaduan/features/pengaduan/domain/repository/pengaduan_repository.dart';
import 'package:pengaduan/features/pengaduan/domain/usecases/get_jenis_penyelesaian.dart';
import 'package:pengaduan/features/pengaduan/domain/usecases/get_pengaduan.dart';
import 'package:pengaduan/features/pengaduan/domain/usecases/get_penugasan.dart';
import 'package:pengaduan/features/pengaduan/domain/usecases/get_penyelesaian_by_id.dart';
import 'package:pengaduan/features/pengaduan/domain/usecases/get_petugas.dart';
import 'package:pengaduan/features/pengaduan/domain/usecases/send_penugasan.dart';
import 'package:pengaduan/features/pengaduan/domain/usecases/send_penyelesaian.dart';
import 'package:pengaduan/features/pengaduan/presentation/bloc/get_penugasan_bloc.dart';
import 'package:pengaduan/features/pengaduan/presentation/bloc/jenis_penyelesaian_bloc.dart';
import 'package:pengaduan/features/pengaduan/presentation/bloc/pengaduan_bloc.dart';
import 'package:pengaduan/features/pengaduan/presentation/bloc/petugas_bloc.dart';
import 'package:pengaduan/features/pengaduan/presentation/bloc/send_data_penyelesaian_bloc.dart';
import 'package:pengaduan/features/pengaduan/presentation/bloc/send_penugasan_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()),
    )
    ..registerFactory(
      () => SignIn(serviceLocator()),
    )
    ..registerFactory(
      () => AuthBloc(serviceLocator()),
    )
    ..registerFactory<DashboardRemoteDatasource>(
      () => DashboardRemoteDatasourceImpl(),
    )
    ..registerFactory<DashboardRepository>(
      () => DashboardRepositoryImpl(serviceLocator()),
    )
    ..registerFactory(
      () => GetDashboardByPeriode(serviceLocator()),
    )
    ..registerFactory(
      () => GetPeriode(serviceLocator()),
    )
    ..registerFactory(
      () => PeriodeBloc(),
    )
    ..registerFactory(
      () => DashboardBloc(serviceLocator(), serviceLocator()),
    )
    ..registerFactory<PengaduanRemoteDatasource>(
      () => PengaduanRemoteDatasourceImpl(),
    )
    ..registerFactory<PengaduanRepository>(
      () => PengaduanRepositoryImpl(serviceLocator()),
    )
    ..registerFactory(
      () => GetPengaduan(serviceLocator()),
    )
    ..registerFactory(
      () => GetJenisPenyelesaian(serviceLocator()),
    )
    ..registerFactory(
      () => GetPetugas(serviceLocator()),
    )
    ..registerFactory(
      () => SendPenugasan(serviceLocator()),
    )
    ..registerFactory(
      () => SendPenyelesaian(serviceLocator()),
    )
    ..registerFactory(
      () => GetPenugasan(serviceLocator()),
    )
    ..registerFactory(
      () => GetPenyelesaianById(serviceLocator()),
    )
    ..registerFactory(
      () => SendDataPenyelesaianBloc(serviceLocator(), serviceLocator()),
    )
    ..registerFactory(
      () => PengaduanBloc(serviceLocator()),
    )
    ..registerFactory(
      () => JenisPenyelesaianBloc(serviceLocator()),
    )
    ..registerFactory(
      () => PetugasBloc(serviceLocator()),
    )
    ..registerFactory(
      () => SendPenugasanBloc(serviceLocator()),
    )
    ..registerFactory(
      () => GetPenugasanBloc(serviceLocator()),
    );
}
