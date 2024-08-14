import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tbduitku/constanta.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kScaffoldColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bagaimana Cara Menambahkan Transaksi Baru?',
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: kTextColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Klik ikon + untuk menambahkan transaksi',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: kTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bagaimana Cara Menambahkan Kategori Baru?',
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: kTextColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.list,
                            color: kTextColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Klik ikon List',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: kTextColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Lalu pilih Kategori untuk masuk ke menu Kategori.',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: kTextColor,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Jika ingin menambahkan kategori Pemasukan maka klik tombol Switch sampai berubah ke Pemasukan.',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: kTextColor,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Jika ingin menambahkan kategori Pengeluaran maka klik tombol Switch sampai berubah ke Pengeluaran.',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: kTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bagaimana Cara Menghapus dan Edit Transaki?',
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: kTextColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Geser ke kiri salah satu Transaksi untuk menghapus',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: kTextColor,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.delete,
                            color: kTextColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Maka akan muncul ikon delete',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: kTextColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Geser ke kanan salah satu Transaksi untuk edit transaksi',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: kTextColor,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.edit,
                            color: kTextColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Maka akan muncul ikon edit',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: kTextColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bagaimana Cara Menghapus dan Edit Kategori?',
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: kTextColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Buka menu Kategori',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: kTextColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Geser ke kiri salah satu Kategori untuk menghapus kategori',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: kTextColor,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.delete,
                            color: kTextColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Maka akan muncul ikon delete',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: kTextColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Geser ke kanan salah satu Kategori untuk edit kategori',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: kTextColor,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.edit,
                            color: kTextColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Maka akan muncul ikon edit',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: kTextColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
