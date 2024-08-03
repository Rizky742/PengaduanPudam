

class Profile {
  final String nama;
  final String alamat;

  Profile(this.nama, this.alamat);
}

void main() async {
  // final GetPengaduan getPengaduan =
  //     GetPengaduan(PengaduanRepositoryImpl(PengaduanRemoteDatasourceImpl()));
  // var response = await getPengaduan.call(month: '07', year: '2024');

  // response.fold((failure) {
  //   print(failure.message);
  // }, (pengaduan) {
  //   pengaduan.map((e) =>  print(e.noAduan)).toList();
  // });

  final List<Profile> test = [
    Profile('juno', 'Probolinggo'),
    Profile('ahmad', 'malang')
  ];
  final testhalo = test
      .where(
        (element) => element.alamat.toLowerCase().contains('p'),
      )
      .toList();
  testhalo.map((e) => print(e.nama)).toList();
  // try {
  //   var response = await pengaduanRemoteDatasourceImpl.getPengaduan(month: '07', year: '2024');
  //   response.map((e) => print(e.noPelanggan),).toList();
  // } catch (e) {
  //   if (e is ServerFailure) {
  //     print('Server error: ${e.message}');
  //   } else {
  //     print('Unexpected error: $e');
  //   }
  // }
}
