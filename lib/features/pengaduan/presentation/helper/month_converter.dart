int? convert(String month) {
  switch (month) {
    case 'Januari':
      return 1;
    case 'Februari':
      return 2;
    case 'Maret':
      return 3;
    case 'April':
      return 4;
    case 'Mei':
      return 5;
    case 'Juni':
      return 6;
    case 'Juli':
      return 7;
    case 'Agustus':
      return 8;
    case 'September':
      return 9;
    case 'Oktober':
      return 10;
    case 'November':
      return 11;
    case 'Desember':
      return 12;
    default:
      return null; // Or throw an exception if the month is invalid
  }
}
