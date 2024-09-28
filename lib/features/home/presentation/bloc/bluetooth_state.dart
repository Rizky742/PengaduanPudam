part of 'bluetooth_bloc.dart';

enum BluetoothStatus { initial, scanning, connected, disconnected }

@immutable
sealed class BluetoothState {}

final class BluetoothLoading extends BluetoothState {}

final class BluetoothSetState extends BluetoothState {
  final BluetoothStatus status;
  final List<BluetoothDevice> devices;
  final BluetoothDevice? connectedDevice;

  BluetoothSetState({
    this.status = BluetoothStatus.initial,
    this.devices = const [],
    this.connectedDevice,
  });

  BluetoothSetState copyWith({
    BluetoothStatus? status,
    List<BluetoothDevice>? devices,
    BluetoothDevice? connectedDevice,
  }) {
    return BluetoothSetState(
        status: status ?? this.status,
        devices: devices ?? this.devices,
        connectedDevice: connectedDevice ?? this.connectedDevice);
  }
}

final class BluetoothError extends BluetoothState {
  final String message;

  BluetoothError(this.message);
}
