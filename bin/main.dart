import 'dart:io';
import 'package:dart_console/dart_console.dart';

abstract class Karyawan {
  final int _id;
  String _nama;
  String _jabatan;
  int _jamKerja;
  final List<String> _absensi = [];
  String _jenisKelamin;
  int _gajiPerjam;

  int get gajiPerjam => _gajiPerjam;

  Karyawan(this._id, this._nama, this._jabatan, this._jamKerja,
      this._jenisKelamin, this._gajiPerjam);

  void tampilData();

  int hitungGaji() {
    return _gajiPerjam * _jamKerja;
  }

  void absen() {
    if (_absensi.isEmpty) {
      // Hanya tambahkan absensi jika belum ada
      final now = DateTime.now();
      final formattedDate =
          '${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}:${now.second}';
      _absensi.add(formattedDate);

      // Setelah absen, tampilkan jam kerja
      tampilkanJamKerja();
    } else {
      print('Karyawan $_nama (ID: $_id) sudah absen sebelumnya.');
    }
  }

  void tampilkanJamKerja() {
    int jamKerja = _jamKerja;
    if (this is KaryawanTetap) {
      jamKerja = 40;
    }
    print('Jam Kerja: $jamKerja jam');
  }
}

class KaryawanTetap extends Karyawan {
  KaryawanTetap(int id, String nama, String jenisKelamin)
      : super(id, nama, 'Karyawan Tetap', 40, jenisKelamin, 300000);

  @override
  void tampilData() {
    print('ID: $_id');
    print('Nama: $_nama');
    print('Jabatan: $_jabatan');
    print('Jenis Kelamin: ${_jenisKelamin == 'L' ? 'Laki-Laki' : 'Perempuan'}');
    print('Total Jam Kerja: $_jamKerja jam');
    if (_absensi.isNotEmpty) {
      print('Absensi:');
      for (var absen in _absensi) {
        print(absen);
      }
    } else {
      print('Belum ada data absensi.');
    }
    int totalGaji = hitungGaji();
    if (totalGaji >= 0) {
      print('Total Gaji: Rp $totalGaji');
    } else {
      print('Total Gaji: Rp 0 (Gaji negatif)');
    }
    print('-------------------------------------');
  }

  @override
  int hitungGaji() {
    return _gajiPerjam * 40;
  }
}

class KaryawanKontrak extends Karyawan {
  static const int _jamKerjaPerMinggu = 30;

  KaryawanKontrak(int id, String nama, String jenisKelamin)
      : super(id, nama, 'Karyawan Kontrak', _jamKerjaPerMinggu,
      jenisKelamin, 200000);

  @override
  void tampilData() {
    print('ID: $_id');
    print('Nama: $_nama');
    print('Jabatan: $_jabatan');
    print('Jenis Kelamin: ${_jenisKelamin == 'L' ? 'Laki-Laki' : 'Perempuan'}');
    print('Total Jam Kerja: $_jamKerja jam');
    if (_absensi.isNotEmpty) {
      print('Absensi:');
      for (var absen in _absensi) {
        print(absen);
      }
    } else {
      print('Belum ada data absensi.');
    }
    int totalGaji = hitungGaji();
    if (totalGaji >= 0) {
      print('Total Gaji: Rp $totalGaji');
    } else {
      print('Total Gaji: Rp 0 (Gaji negatif)');
    }
    print('-------------------------------------');
  }

  @override
  int hitungGaji() {

    return _gajiPerjam * 30;
  }
}

class KaryawanMagang extends Karyawan {
  static const int _jamKerjaPerMinggu = 20;

  KaryawanMagang(int id, String nama, String jenisKelamin)
      : super(id, nama, 'Karyawan Magang', _jamKerjaPerMinggu,
      jenisKelamin, 100000);

  @override
  void tampilData() {
    print('ID: $_id');
    print('Nama: $_nama');
    print('Jabatan: $_jabatan');
    print('Jenis Kelamin: ${_jenisKelamin == 'L' ? 'Laki-Laki' : 'Perempuan'}');
    print('Jam Kerja: $_jamKerja jam');
    if (_absensi.isNotEmpty) {
      print('Absensi:');
      for (var absen in _absensi) {
        print(absen);
      }
    } else {
      print('Belum ada data absensi.');
    }
    int totalGaji = hitungGaji();
    if (totalGaji >= 0) {
      print('Total Gaji: Rp $totalGaji');
    } else {
      print('Total Gaji: Rp 0 (Gaji negatif)');
    }
    print('-------------------------------------');
  }

  @override
  int hitungGaji() {
    return _gajiPerjam * 20;
  }
}

class KaryawanUpdater {
  static void updateKaryawan(Karyawan karyawan) {
    stdout.write('Masukkan nama baru (Enter untuk tidak mengubah): ');
    String newNama = stdin.readLineSync()!;
    if (newNama.isNotEmpty) {
      karyawan._nama = newNama;
    }

    stdout.write(
        'Masukkan jenis kelamin baru (L/P/Enter untuk tidak mengubah): ');
    String newJenisKelamin = stdin.readLineSync()!.toUpperCase();

    if (newJenisKelamin.isNotEmpty) {
      while (newJenisKelamin != 'L' && newJenisKelamin != 'P') {
        print('Jenis kelamin tidak valid. Harap masukkan L atau P.');
        stdout.write(
            'Masukkan jenis kelamin baru (L/P/Enter untuk tidak mengubah): ');
        newJenisKelamin = stdin.readLineSync()!.toUpperCase();
      }
      karyawan._jenisKelamin = newJenisKelamin;
    } else {
      karyawan._jenisKelamin = karyawan._jenisKelamin;
    }

    stdout.write(
        'Masukkan jabatan baru (1: Tetap, 2: Kontrak, 3: Magang, Enter untuk tidak mengubah): ');
    String jabatanChoice = stdin.readLineSync()!;
    if (jabatanChoice.isNotEmpty) {
      if (jabatanChoice == '1') {
        // Jabatan "Tetap" - Tetapkan jam kerja ke 40 jam
        karyawan._jabatan = 'Karyawan Tetap';
        karyawan._jamKerja = 40;
        karyawan._gajiPerjam = 300000; // Update hourly rate for Tetap
      } else if (jabatanChoice == '2') {
        // Jabatan "Kontrak"
        karyawan._jabatan = 'Karyawan Kontrak';
        karyawan._jamKerja = 30;
        karyawan._gajiPerjam = 200000; // Update hourly rate for Kontrak
      } else if (jabatanChoice == '3') {
        // Jabatan "Magang"
        karyawan._jabatan = 'Karyawan Magang';
        karyawan._jamKerja = 20;
        karyawan._gajiPerjam = 100000; // Update hourly rate for Magang
      } else {
        print('Pilihan jabatan tidak valid. Jabatan tidak diubah.');
      }
    }

    print('Data karyawan berhasil diupdate.');
  }
}

void updateJabatanKontrak(Karyawan karyawan) {
  stdout.write('Masukkan jam kerja baru (Enter untuk tidak mengubah): ');
  String newJamKerja = stdin.readLineSync()!;
  if (newJamKerja.isNotEmpty) {
    karyawan._jabatan = 'Karyawan Tetap';
    karyawan._jamKerja = 40;
    karyawan._gajiPerjam = 300000;// Update hourly rate for Kontrak
    var total;
    total = karyawan._jamKerja * karyawan._gajiPerjam;
  } else {
    karyawan._jabatan = 'Karyawan Magang';
    karyawan._jamKerja = 20;
    karyawan._gajiPerjam = 100000; // Update hourly rate for Kontrak
    var total;
    total = karyawan._jamKerja * karyawan._gajiPerjam;
  }
}

void updateJabatanMagang(Karyawan karyawan) {
  stdout.write('Masukkan jam kerja baru (Enter untuk tidak mengubah): ');
  String newJamKerja = stdin.readLineSync()!;
  if (newJamKerja.isNotEmpty) {
    karyawan._jabatan = 'Karyawan Tetap';
    karyawan._jamKerja = 40;
    karyawan._gajiPerjam = 300000; // Update hourly rate for Magang
    var total;
    total = karyawan._jamKerja * karyawan._gajiPerjam;
  } else {
    karyawan._jabatan = 'Karyawan Kontrak';
    karyawan._jamKerja = 30;
    karyawan._gajiPerjam = 200000; // Update hourly rate for Magang
    var total;
    total = karyawan._jamKerja * karyawan._gajiPerjam;
  }
}


void main() {
  List<Karyawan> daftarKaryawan = [];
  int currentId = 1;
  final console = Console(); // Create an instance of Console

  while (true) {
    console.clearScreen(); // Clear the screen at the beginning of each case
    print('\n===== Sistem Manajemen Karyawan Hotel =====');
    print('1. Tambah Karyawan');
    print('2. Tampilkan Data Karyawan');
    print('3. Update Karyawan');
    print('4. Delete Karyawan');
    print('5. Absen Karyawan');
    print('6. Keluar');
    stdout.write('Pilih menu (1/2/3/4/5/6): ');
    String menu = stdin.readLineSync()!;

    switch (menu) {
      case '1':
        console.clearScreen();
        print('\nTambah Karyawan');
        print('=====================');
        stdout.write('Masukkan nama karyawan: ');
        String nama = stdin.readLineSync()!;
        if (nama.isEmpty) {
          print('Nama tidak boleh kosong.');
          break; // Keluar dari case 1
        }
        String jenisKelamin;
        do {
          stdout.write('Masukkan jenis kelamin (L/P): ');
          jenisKelamin = stdin.readLineSync()!.toUpperCase();
          if (jenisKelamin != 'L' && jenisKelamin != 'P') {
            print('Input jenis kelamin tidak valid. Harap masukkan L atau P.');
          }
        } while (jenisKelamin != 'L' && jenisKelamin != 'P');

        String jabatanChoice;
        do {
          stdout.write('Pilih jabatan (1: Tetap, 2: Kontrak, 3: Magang): ');
          jabatanChoice = stdin.readLineSync()!;
          if (jabatanChoice != '1' &&
              jabatanChoice != '2' &&
              jabatanChoice != '3') {
            print(
                'Pilihan jabatan tidak valid. Harap pilih dari opsi yang tersedia.');
          }
        } while (jabatanChoice != '1' &&
            jabatanChoice != '2' &&
            jabatanChoice != '3');

        int jamLembur = 0;

        // Hanya tambahkan jam lembur jika jabatan adalah Kontrak atau Magang
        if (jabatanChoice == '1' ||
            jabatanChoice == '2' ||
            jabatanChoice == '3') {
          while (true) {
            stdout.write('Masukkan jam lembur: ');
            String jamLemburInput = stdin.readLineSync()!;
            if (jamLemburInput.isEmpty) {
              // Jika input jam lembur kosong, set jam lembur ke 0 dan keluar dari loop
              jamLembur = 0;
              break;
            } else {
              try {
                jamLembur = int.parse(jamLemburInput);
                break; // Keluar dari loop jika input jam lembur valid
              } catch (e) {
                print(
                    'Jam lembur harus berupa angka. Harap masukkan jam lembur yang valid atau biarkan kosong.');
              }
            }
          }
        }

        Karyawan karyawan;

        if (jabatanChoice == '1') {
          karyawan = KaryawanTetap(currentId, nama, jenisKelamin);
        } else if (jabatanChoice == '2') {
          karyawan = KaryawanKontrak(currentId, nama, jenisKelamin);
        } else if (jabatanChoice == '3') {
          karyawan = KaryawanMagang(currentId, nama, jenisKelamin);
        } else {
          print('Pilihan jabatan tidak valid.');
          break; // Keluar dari case 1
        }

        daftarKaryawan.add(karyawan);
        currentId++;
        print('Karyawan berhasil ditambahkan.');
        break; // Keluar dari case 1

      case '2':
        print('\nDaftar Karyawan');
        print('=====================');
        if (daftarKaryawan.isEmpty) {
          print('\nBelum ada karyawan yang ditambahkan.');
        } else {
          print('\nData Karyawan:');
          List<List<String>> tableData = [
            [
              'ID',
              'Nama',
              'Jabatan',
              'Jenis Kelamin',
              'Absensi & Jam Kerja',
              'Total Gaji'
            ]
          ];

          for (var karyawan in daftarKaryawan) {
            final absensiAndJamKerja = karyawan._absensi.isNotEmpty
                ? TampilkanAbsensiDanJamKerja(karyawan)
                : 'Belum ada data absensi.';
            final total = karyawan.hitungGaji() >= 0
                ? 'Rp ${karyawan.hitungGaji()}'
                : 'Rp 0 (Gaji negatif)';
            tableData.add([
              karyawan._id.toString(),
              karyawan._nama,
              karyawan._jabatan,
              karyawan._jenisKelamin == 'L' ? 'Laki-Laki' : 'Perempuan',
              absensiAndJamKerja,
              total,
            ]);
          }

          // Menampilkan tabel
          printTable(tableData);
        }
        // Tambahkan pemberhentian untuk kembali ke menu utama
        stdout.write('\nTekan Enter untuk kembali ke menu utama...');
        stdin.readLineSync();
        break;

      case '3':
        console.clearScreen();
        // Update Karyawan
        print('\nUpdate Karyawan');
        print('=====================');

        // Memeriksa apakah daftarKaryawan kosong
        if (daftarKaryawan.isEmpty) {
          print('Tidak ada data karyawan.');
          stdout.write('\nTekan Enter untuk kembali ke menu utama...');
          stdin.readLineSync();
          break;
        }

        // Menampilkan daftar ID karyawan
        print('Daftar ID Karyawan:');
        for (var karyawan in daftarKaryawan) {
          print('ID: ${karyawan._id}, Nama: ${karyawan._nama}');
        }

        int? idToUpdate;

        // Loop untuk memastikan pengguna memasukkan ID yang valid
        while (idToUpdate == null) {
          stdout.write('Masukkan ID karyawan yang akan diupdate: ');
          String? input = stdin.readLineSync();

          if (input == null || input.isEmpty) {
            print('ID tidak boleh kosong. Silakan masukkan ID.');
          } else {
            try {
              idToUpdate = int.parse(input);
            } catch (e) {
              print('ID harus berupa angka. Silakan masukkan ID yang valid.');
            }
          }
        }

        Karyawan? karyawanToUpdate;

        for (var karyawan in daftarKaryawan) {
          if (karyawan._id == idToUpdate) {
            karyawanToUpdate = karyawan;
            break;
          }
        }

        if (karyawanToUpdate == null) {
          print('Karyawan dengan ID $idToUpdate tidak ditemukan.');
        } else {
          KaryawanUpdater.updateKaryawan(karyawanToUpdate);
        }
        break;

      case '4':
        console.clearScreen();
        print('\nDelete Karyawan');
        print('====================');

        // Memeriksa apakah daftarKaryawan kosong
        if (daftarKaryawan.isEmpty) {
          print(
              'Tidak ada data karyawan. Mohon tambah karyawan terlebih dahulu.');
          stdout.write('\nTekan Enter untuk kembali ke menu utama...');
          stdin.readLineSync();
          break;
        }

        // Menampilkan daftar ID Karyawan
        print('Daftar ID Karyawan:');
        for (var karyawan in daftarKaryawan) {
          print('ID: ${karyawan._id}, Nama: ${karyawan._nama}');
        }

        int idToDelete;
        Karyawan? karyawanToDelete;

        // Meminta pengguna memasukkan ID karyawan yang akan dihapus
        while (true) {
          stdout.write('Masukkan ID karyawan yang akan dihapus: ');

          // Validasi input agar harus berupa bilangan bulat
          try {
            idToDelete = int.parse(stdin.readLineSync()!);
            break; // Keluar dari loop jika input valid
          } catch (e) {
            print('Mohon masukkan ID dalam bentuk bilangan bulat.');
          }
        }

        for (var karyawan in daftarKaryawan) {
          if (karyawan._id == idToDelete) {
            karyawanToDelete = karyawan;
            break;
          }
        }

        if (karyawanToDelete == null) {
          print('Karyawan dengan ID $idToDelete tidak ditemukan.');
        } else {
          daftarKaryawan.remove(karyawanToDelete);
          print('Data karyawan berhasil dihapus.');
        }
        break;

      case '5':
        console.clearScreen();
        print('\nAbsen Karyawan');
        print('====================');
        if (daftarKaryawan.isEmpty) {
          print('Belum ada karyawan yang ditambahkan.');
          // Tambahkan pemberhentian untuk kembali ke menu utama
          stdout.write('\nTekan Enter untuk kembali ke menu utama...');
          stdin.readLineSync();
        } else {
          print('\nAbsen Karyawan');
          for (var karyawan in daftarKaryawan) {
            if (karyawan._absensi.isEmpty) {
              print('ID: ${karyawan._id}, Nama: ${karyawan._nama}');
            } else {
              print(
                  'ID: ${karyawan._id}, Nama: ${karyawan._nama} (Sudah absen)');
            }
          }

          int idToAbsen;
          while (true) {
            try {
              stdout.write('Masukkan ID karyawan yang akan absen: ');
              idToAbsen = int.parse(stdin.readLineSync()!);

              // Check if the entered ID exists
              if (daftarKaryawan.any((karyawan) => karyawan._id == idToAbsen)) {
                Karyawan karyawanToAbsen = daftarKaryawan
                    .firstWhere((karyawan) => karyawan._id == idToAbsen);

                if (karyawanToAbsen._absensi.isEmpty) {
                  karyawanToAbsen.absen();
                  // Tampilkan jam kerja setelah absen (tanpa jam lembur)
                  // print('Jam Kerja: ${karyawanToAbsen._jamKerja} jam');
                } else {
                  print(
                      'Karyawan dengan ID $idToAbsen (Nama: ${karyawanToAbsen._nama}) sudah absen sebelumnya.');
                }

                break;
              } else {
                print(
                    'Karyawan dengan ID "$idToAbsen" tidak ditemukan. Silakan coba lagi.');
              }
            } catch (e) {
              print('Input ID tidak valid. Harap masukkan angka.');
            }
          }
        }
        break;


      case '6':
        console.clearScreen();
        console.writeLine("Terima Kasih!", TextAlignment.center);
        return;

      default:
        console.writeLine("Pilihan tidak valid.", TextAlignment.center);
    }
  }
}

String TampilkanHariKerja(Karyawan karyawan) {
  int jamKerja = karyawan._jamKerja;
  if (karyawan is KaryawanTetap) {
    jamKerja = 40;
  }
  int hariKerja = jamKerja ~/ 8;
  return '$hariKerja hari';
}

void printTable(List<List<String>> tableData) {
  // Menampilkan tabel dengan memformat lebar kolom
  List<int> columnWidths = List.filled(tableData[0].length, 0);

  for (var row in tableData) {
    for (int i = 0; i < row.length; i++) {
      if (row[i].length > columnWidths[i]) {
        columnWidths[i] = row[i].length;
      }
    }
  }

  for (var row in tableData) {
    for (int i = 0; i < row.length; i++) {
      final cell = row[i].padRight(columnWidths[i]);
      stdout.write('$cell | ');
    }
    print('');
  }
}

String TampilkanAbsensiDanJamKerja(Karyawan karyawan) {
  String absensiAndJamKerja = '';

  if (karyawan is KaryawanTetap) {
    absensiAndJamKerja = TampilkanAbsensi(karyawan);
  } else if (karyawan is KaryawanKontrak) {
    absensiAndJamKerja = TampilkanAbsensi(karyawan);
  } else if (karyawan is KaryawanMagang) {
    absensiAndJamKerja = TampilkanAbsensi(karyawan);
  }

  absensiAndJamKerja += ' - Jam Kerja: ${karyawan._jamKerja} jam';

  return absensiAndJamKerja;
}

String TampilkanAbsensi(Karyawan karyawan) {
  return karyawan._absensi.isNotEmpty
      ? karyawan._absensi.join('\n')
      : 'Belum ada data absensi.';
}
