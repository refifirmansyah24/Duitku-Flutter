import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tbduitku/data/database.dart';
import 'package:tbduitku/data/transactioncat.dart';
import 'package:tbduitku/hidden_drawer.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:tbduitku/pages/main_page.dart';

import '../constanta.dart';

class TransaksiPage extends StatefulWidget {
  final TransactionCategory? transactionWithCategory;
  const TransaksiPage({Key? key, required this.transactionWithCategory})
      : super(key: key);

  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  final AppDb database = AppDb();
  bool pengeluaran = true;
  late int type;

  List<String> list = [
    'Tuang',
    'Bengsin',
    'Jajan',
  ];
  late String dropDownValue = list.first;
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  Category? selectedCategory;

  Future insert(
      int amount, DateTime date, String nameDetail, int categoryId) async {
    //ada insert ke data base
    DateTime now = DateTime.now();
    final row = await database.into(database.transactions).insertReturning(
        TransactionsCompanion.insert(
            name: nameDetail,
            category_id: categoryId,
            transaction_date: date,
            amunt: amount,
            createdAt: now,
            updatedAt: now));
    //cek data
    print('Cek : ' + row.toString());
  }

  Future<List<Category>> getAllCategory(int type) async {
    return await database.getAllCategoryRepo(type);
  }

  Future update(int transactionId, int amount, int categoryId,
      DateTime transactionDate, String nameDetail) async {
    return await database.updateTransactionRepo(
        transactionId, amount, categoryId, transactionDate, nameDetail);
  }

  @override
  void initState() {
    // TODO: implement initState
    if (widget.transactionWithCategory != null) {
      updateTransactionView(widget.transactionWithCategory!);
    } else {
      type = 2;
    }
    super.initState();
  }

  void updateTransactionView(TransactionCategory transactionWithCategory) {
    amountController.text =
        transactionWithCategory.transaction.amunt.toString();
    detailController.text = transactionWithCategory.transaction.name;
    dateController.text = DateFormat("yyyy-MM-dd")
        .format(transactionWithCategory.transaction.transaction_date);
    type = transactionWithCategory.category.type;
    (type == 2) ? pengeluaran = true : pengeluaran = false;
    selectedCategory = transactionWithCategory.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kNewColor,
        title: Text("Masukan Transaksi"),
      ),
      body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Tombol Switch
              Switch(
                value: pengeluaran,
                onChanged: (bool value) {
                  setState(() {
                    pengeluaran = value;
                    type = (pengeluaran) ? 2 : 1;
                    selectedCategory = null;
                  });
                },
                inactiveTrackColor: Colors.grey,
                inactiveThumbColor: Colors.white,
                activeColor: Colors.white,
              ),
              Text(
                pengeluaran ? 'Pengeluaran' : 'Pemasukan',
                style: GoogleFonts.poppins(fontSize: 14, color: kTextColor),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //form masukan
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextFormField(
              controller: amountController,
              style: TextStyle(color: kTextColor),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Amount",
                labelStyle: GoogleFonts.poppins(color: kTextColor),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          //buat kategori ygy
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Kategori',
              style: GoogleFonts.poppins(fontSize: 14, color: kTextColor),
            ),
          ),

          FutureBuilder<List<Category>>(
              future: getAllCategory(type),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    if (snapshot.data!.length > 0) {
                      selectedCategory = (selectedCategory == null)
                          ? snapshot.data!.first
                          : selectedCategory;
                      print('ApaanTUh: ' + snapshot.toString());
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: DropdownButton<Category>(
                            dropdownColor: kPrimaryColor,
                            //agar bisa milih kategori gaes
                            value: (selectedCategory == null)
                                ? snapshot.data!.first
                                : selectedCategory,
                            isExpanded: true,
                            style: TextStyle(color: kTextColor),
                            icon: Icon(Icons.arrow_downward),
                            items: snapshot.data!.map((Category item) {
                              return DropdownMenuItem<Category>(
                                value: item,
                                child: Text(item.name),
                              );
                            }).toList(),
                            onChanged: (Category? value) {
                              setState(() {
                                selectedCategory = value;
                              });
                            }),
                      );
                    } else {
                      return Center(
                        child: Text('Data Kosong',
                            style: GoogleFonts.poppins(color: kTextColor)),
                      );
                    }
                  } else {
                    return Center(
                      child: Text(
                        'Tidak Ada Data',
                        style: GoogleFonts.poppins(color: kTextColor),
                      ),
                    );
                  }
                }
              }),

          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              //masukan tanggal
              readOnly: true,
              controller: dateController,
              decoration: InputDecoration(
                  labelText: "Masukan Tanggal",
                  labelStyle: TextStyle(color: kTextColor)),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2099),
                );
                if (pickedDate != null) {
                  String formatedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  dateController.text = formatedDate;
                }
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          //detail
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextFormField(
              controller: detailController,
              style: TextStyle(color: kTextColor),
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Detail",
                labelStyle: TextStyle(color: kTextColor),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          //Tombol Simpan
          Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: kNewColor),
                  onPressed: () async {
                    (widget.transactionWithCategory == null)
                        ? insert(
                            int.parse(amountController.text),
                            DateTime.parse(dateController.text),
                            detailController.text,
                            selectedCategory!.id)
                        : await update(
                            widget.transactionWithCategory!.transaction.id,
                            int.parse(amountController.text),
                            selectedCategory!.id,
                            DateTime.parse(dateController.text),
                            detailController.text,
                          );

                    print('amount: ' + amountController.text);
                    print('date: ' + dateController.text);
                    print('detail: ' + detailController.text);
                    //pada ssetelah mengisi transaksi kembali kehalaman peratama atau home
                    setState(() {});
                    //agar langsung refresh halamannya
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HiddenDrawer()));
                    Scaffold.of(context).openDrawer();
                  },
                  child: Text("Simpan")))
        ],
      ))),
    );
  }
}
