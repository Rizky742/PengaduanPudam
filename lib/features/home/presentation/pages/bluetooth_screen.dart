import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pengaduan/core/snackbar/snackbar.dart';
import 'package:pengaduan/features/home/presentation/bloc/bluetooth_bloc.dart';
import 'package:pengaduan/features/home/presentation/pages/home_page_screen.dart';
import 'package:pengaduan/features/home/presentation/widgets/bluetooth_item_widget.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/header_widget.dart';
import 'package:pengaduan/theme.dart';

class BluetoothScreen extends StatelessWidget {
  const BluetoothScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var safeAreaPadding = MediaQuery.of(context).padding;
    print('woi');
    context.read<BluetoothBloc>().add(StartScan());
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 135.h + safeAreaPadding.top,
              color: blueCola,
            ),
            Container(
              padding: EdgeInsets.only(
                  top: safeAreaPadding.top + 42.h, left: 16.w, right: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderWidget(
                    jumpToPage: Homepage(),
                    title: 'Pengaturan Bluetooth',
                  ),
                  SizedBox(height: 28.h),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: brightGray),
                            borderRadius: BorderRadius.circular(8.r),
                            color: white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bluetooth',
                                  style: body1.copyWith(color: vampireBlack),
                                ),
                                Text(
                                  'PDAM Bluetooth',
                                  style: caption1.copyWith(color: graniteGray),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                  BlocBuilder<BluetoothBloc, BluetoothState>(
                    buildWhen: (previous, current) =>
                        current is BluetoothSetState,
                    builder: (context, state) {
                      if (state is BluetoothSetState) {
                        final isConnect =
                            state.connectedDevice != null ? true : false;
                        final connectedDevice = state.connectedDevice;
                        final List<BluetoothDevice> stateDevices;
                        if (isConnect) {
                          stateDevices = state.devices
                              .where((element) =>
                                  element.address != connectedDevice!.address)
                              .toList();
                        } else {
                          stateDevices = state.devices;
                        }
                        if (state.devices.isNotEmpty) {
                          return Column(
                            children: stateDevices.map((device) {
                              return BlocListener<BluetoothBloc, BluetoothState>(
                                listener: (context, state) {
                                  if(state is BluetoothError){
                                    print(state.message);
                                  }
                                },
                                child: GestureDetector(
                                  onTap: () {
                                    context
                                        .read<BluetoothBloc>()
                                        .add(ConnectDevice(device));
                                  },
                                  child: BluetoothItemWidget(
                                      title: device.name!,
                                      status: Status.connected),
                                ),
                              );
                            }).toList(),
                          );
                        } else {
                          return const Center(
                            child: Text('No Data'),
                          );
                        }
                      } else if (state is BluetoothError) {
                        return Center(
                          child: Text(state.message),
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
