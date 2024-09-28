import 'package:pengaduan/core/error/failure.dart';
import 'package:pengaduan/features/pengaduan/data/datasources/pengaduan_remote_datasource.dart';

class Profile {
  final String nama;
  final String alamat;

  Profile(this.nama, this.alamat);
}

void main() async {
  try {
    final PengaduanRemoteDatasource remoteDatasource =
        PengaduanRemoteDatasourceImpl();
    var response = await remoteDatasource.getJenisPenyelesaian();
    print('sdfsdf');
    print(response.toList());
  } catch (e) {
    if (e is ServerFailure) {
      print(ServerFailure(e.message));
    }
  }
}
