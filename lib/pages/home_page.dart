import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tbduitku/constanta.dart';
import 'package:tbduitku/data/database.dart';
import 'package:tbduitku/data/transactioncat.dart';
import 'package:tbduitku/pages/transaksi_page.dart';
import 'main_page.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomePage extends StatefulWidget {
  final DateTime selectedDate;
  const HomePage({Key? key, required this.selectedDate}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AppDb database = AppDb();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            //dashboard pemasukan dan pengeluaran
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.shade900,
                          Colors.blue.shade800,
                          Colors.blue.shade700,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.download,
                            color: kTextColor,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pemasukan",
                              style: GoogleFonts.poppins(
                                  color: kTextColor, fontSize: 14),
                            ),
                            //fungsi jumlah pemasukan
                            StreamBuilder<List<TransactionCategory>>(
                              stream: database.getTransactionByDateRepo(
                                  widget.selectedDate),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else {
                                  if (snapshot.hasData) {
                                    final totalPemasukan =
                                        snapshot.data!.fold<double>(
                                      0,
                                      (previousValue, element) =>
                                          element.category.type == 1
                                              ? previousValue +
                                                  element.transaction.amunt
                                              : previousValue,
                                    );
                                    return Text(
                                      totalPemasukan > 0
                                          ? "Rp. ${totalPemasukan.toStringAsFixed(0)}"
                                          : "Rp. 0",
                                      style: GoogleFonts.poppins(
                                        color: kTextColor,
                                        fontSize: 14,
                                      ),
                                    );
                                  } else {
                                    return Text(
                                      "Rp.0 ",
                                      style: GoogleFonts.poppins(
                                          color: kTextColor, fontSize: 14),
                                    );
                                  }
                                }
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue.shade900,
                            Colors.blue.shade800,
                            Colors.blue.shade700,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Container(
                            child: Icon(
                              Icons.upload,
                              color: kTextColor,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pengeluaran",
                                style: GoogleFonts.poppins(
                                    color: kTextColor, fontSize: 14),
                              ),
                              //fungsi jumlah pengeluaran
                              StreamBuilder<List<TransactionCategory>>(
                                stream: database.getTransactionByDateRepo(
                                    widget.selectedDate),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else {
                                    if (snapshot.hasData) {
                                      final totalPengeluaran =
                                          snapshot.data!.fold<double>(
                                        0,
                                        (previousValue, element) =>
                                            element.category.type == 2
                                                ? previousValue +
                                                    element.transaction.amunt
                                                : previousValue,
                                      );
                                      return Text(
                                        totalPengeluaran > 0
                                            ? "Rp. ${totalPengeluaran.toStringAsFixed(0)}"
                                            : "Rp. 0",
                                        style: GoogleFonts.poppins(
                                          color: kTextColor,
                                          fontSize: 14,
                                        ),
                                      );
                                    } else {
                                      return Text(
                                        "RP.0",
                                        style: GoogleFonts.poppins(
                                            color: kTextColor, fontSize: 14),
                                      );
                                    }
                                  }
                                },
                              ),
                            ],
                          )
                        ],
                      )),
                ],
              ),
            ),
          ),
          //Transaksi
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Transaksi",
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.bold, color: kTextColor),
            ),
          ),
          StreamBuilder<List<TransactionCategory>>(
              stream: database.getTransactionByDateRepo(widget.selectedDate),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    if (snapshot.data!.length > 0) {
                      return SingleChildScrollView(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final item = snapshot.data![index].transaction;
                                //agar bisa dihapus dengan digeser maka gunakan dismissible
                                return Dismissible(
                                  key: Key(item.id.toString()),
                                  onDismissed: (direction) async {
                                    //geser kiri ke kanan hapus
                                    if (direction ==
                                        DismissDirection.startToEnd) {
                                      await database
                                          .deleteTransactionRepo(item.id);
                                      setState(() {
                                        snapshot.data!.removeAt(index);
                                      });
                                    }
                                    //geser kanan ke kiri edit
                                    else if (direction ==
                                        DismissDirection.endToStart) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TransaksiPage(
                                                    transactionWithCategory:
                                                        snapshot.data![index],
                                                  )));
                                    }
                                  },
                                  background: Container(
                                    color: kPrimaryColor,
                                    alignment: Alignment.centerLeft,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child:
                                        Icon(Icons.delete, color: kTextColor),
                                  ),
                                  secondaryBackground: Container(
                                    color: kPrimaryColor,
                                    alignment: Alignment.centerRight,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Icon(Icons.edit, color: kTextColor),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Card(
                                        elevation: 10,
                                        color: kPrimaryColor,
                                        child: ListTile(
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [],
                                          ),
                                          title: Text(
                                            "Rp. " +
                                                snapshot.data![index]
                                                    .transaction.amunt
                                                    .toString(),
                                            style: GoogleFonts.poppins(
                                              color: kTextColor,
                                            ),
                                          ),
                                          subtitle: Text(
                                              snapshot.data![index].category
                                                      .name +
                                                  " (" +
                                                  snapshot.data![index]
                                                      .transaction.name +
                                                  ")",
                                              style: GoogleFonts.poppins(
                                                color: kTextColor,
                                              )),
                                          leading: Container(
                                            //kondisi dimana icon pemasukan dan pengeluaran ditampilkan di homepag pada transaksi
                                            child: (snapshot.data![index]
                                                        .category.type ==
                                                    2)
                                                ? Icon(
                                                    Icons.upload,
                                                    color: kTextColor,
                                                  )
                                                : Icon(
                                                    Icons.download,
                                                    color: kTextColor,
                                                  ),
                                          ),
                                        ),
                                      )),
                                );
                              }));
                    } else {
                      return Center(
                        child: Text(
                          "Tidak Ada Transaksi",
                          style: GoogleFonts.poppins(color: kTextColor),
                        ),
                      );
                    }
                  } else {
                    return Center(
                      child: Text("Tidak ada Data",
                          style: GoogleFonts.poppins(color: kTextColor)),
                    );
                  }
                }
              }),
        ],
      )),
    );
  }
}
