// bluetooth_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:meta/meta.dart';

part 'bluetooth_event.dart';
part 'bluetooth_state.dart';

class BluetoothBloc extends Bloc<BluetoothEvent, BluetoothState> {
  final BluetoothPrint _bluetoothPrint = BluetoothPrint.instance;

  BluetoothBloc() : super(BluetoothSetState()) {
    on<StartScan>(_onStartScan);
    on<StopScan>(_onStopScan);
    on<ConnectDevice>(_onConnectDevice);
    on<DisconnectDevice>(_onDisconnectDevice);
    on<PrintReceipt>(_printReceipt);
  }

  @override
  Future<void> close() async {
    // Stop scan when the bloc is disposed
    await _bluetoothPrint.stopScan();
    return super.close();
  }

  Future<void> _onStartScan(
      StartScan event, Emitter<BluetoothState> emit) async {
    try {
      final status = await _bluetoothPrint.isOn;
      if (status) {
        emit(BluetoothSetState(status: BluetoothStatus.scanning));
        await _bluetoothPrint.startScan(timeout: const Duration(seconds: 10));
        await emit.forEach(
          _bluetoothPrint.scanResults,
          onData: (List<BluetoothDevice> results) =>
              BluetoothSetState().copyWith(
            status: BluetoothStatus.initial,
            devices: results,
          ),
        );
        emit(BluetoothSetState().copyWith(status: BluetoothStatus.initial));
      } else {
        emit(BluetoothError('Bluetooth belum menyala'));
      }
    } catch (e) {
      emit(BluetoothError(e.toString()));
    }
  }

  Future<void> _onStopScan(StopScan event, Emitter<BluetoothState> emit) async {
    try {
      await _bluetoothPrint.stopScan();
      emit(BluetoothSetState().copyWith(status: BluetoothStatus.initial));
    } catch (e) {
      emit(BluetoothSetState().copyWith(status: BluetoothStatus.initial));
    }
  }

  Future<void> _printReceipt(
      PrintReceipt event, Emitter<BluetoothState> emit) async {
    try {
      print(await _bluetoothPrint.isConnected);
      Map<String, dynamic> config = {
        'gap' : 7
      };

      List<LineText> receipt = [];
      receipt.add(LineText(content: 'PUDAM BAYUANGGA', align: LineText.ALIGN_CENTER, weight: 3, width: 1, height: 2, type: LineText.TYPE_TEXT, linefeed: 1));
      receipt.add(LineText(content: 'Bukti Penyelesaian', align: LineText.ALIGN_CENTER, weight: 3, type: LineText.TYPE_TEXT, linefeed: 1));
      receipt.add(LineText(content: 'Nomor Aduan', align: LineText.ALIGN_LEFT, weight: 2, type: LineText.TYPE_TEXT, linefeed: 1));
      receipt.add(LineText(content: '345345345', align: LineText.ALIGN_LEFT, weight: 1, type: LineText.TYPE_TEXT, linefeed: 1));

      await _bluetoothPrint.printReceipt(config, receipt);
      print('dfgf');
    } catch (e) {
      // emit(BluetoothSetState().copyWith(status: BluetoothStatus.initial));
      print('gagal');
    }
  }

  Future<void> _onConnectDevice(
      ConnectDevice event, Emitter<BluetoothState> emit) async {
    try {
      print(event.deviceAddress.name);
      await _bluetoothPrint.connect(event.deviceAddress);
      emit(BluetoothSetState().copyWith(
          status: BluetoothStatus.connected,
          connectedDevice: event.deviceAddress));
    } catch (e) {
      emit(BluetoothError('Gagal Connect'));
    }
  }

  Future<void> _onDisconnectDevice(
      DisconnectDevice event, Emitter<BluetoothState> emit) async {
    try {
      await _bluetoothPrint.disconnect();
      emit(BluetoothSetState().copyWith(
          status: BluetoothStatus.disconnected, connectedDevice: null));
    } catch (e) {
      emit(BluetoothSetState().copyWith(status: BluetoothStatus.initial));
    }
  }
}
