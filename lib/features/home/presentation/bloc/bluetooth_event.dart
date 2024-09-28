part of 'bluetooth_bloc.dart';

@immutable
sealed class BluetoothEvent {}

class StartScan extends BluetoothEvent {}

class StopScan extends BluetoothEvent {}

class ConnectDevice extends BluetoothEvent {
  final BluetoothDevice deviceAddress;

  ConnectDevice(this.deviceAddress);
}

class PrintReceipt extends BluetoothEvent {}

class DisconnectDevice extends BluetoothEvent {
  final String deviceAddress;

  DisconnectDevice(this.deviceAddress);
}
