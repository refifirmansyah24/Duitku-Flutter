import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tbduitku/constanta.dart';
import 'package:tbduitku/data/database.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  //agar pas di switch ikon ikut hijau
  bool pengeluaran = true;
  int type = 2;
  //panggil database
  final AppDb database = AppDb();
  //agar situlisan pada menambah kategori masuk ke database
  TextEditingController categoryNameController = TextEditingController();

  Future insert(String name, int type) async {
    DateTime now = DateTime.now();
    final row = await database.into(database.categories).insertReturning(
        CategoriesCompanion.insert(
            name: name, type: type, createdAt: now, updatedAt: now));
    print(row);
    print('Masuk :' + row.toString());
  }

  Future<List<Category>> getAllCategory(int type) async {
    return await database.getAllCategoryRepo(type);
  }

  Future update(int categoryId, String newName) async {
    return await database.updateCategoryRepo(categoryId, newName);
  }

  //buat nambah dan edit
  void bukaDialog(Category? category) {
    if (category != null) {
      categoryNameController.text = category.name;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            //bungkus pake single child biar form inputan tidak panjang kebawah
            content: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Text(
                        (pengeluaran)
                            ? "Masukan Pengeluaran"
                            : "Masukan Pemasukan",
                        style: GoogleFonts.poppins(
                            fontSize: 18, color: kTextColor)),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      //biar bisa masuk database ygy yang diinputnya
                      controller: categoryNameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: "Name"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          //pada edit kategori agar menyimpan edit an nya
                          if (category == null) {
                            insert(categoryNameController.text,
                                pengeluaran ? 2 : 1);
                          } else {
                            update(category.id, categoryNameController.text);
                          }
                          Navigator.of(context, rootNavigator: true)
                              .pop('dialog');
                          setState(() {});
                          categoryNameController.clear();
                        },
                        child: Text("Simpan"))
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ColoredBox(
            color: kPrimaryColor,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    //agar ikon dan tombol switch tidak bredekatan
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [
                      //Tombol Switch
                      Switch(
                        //agar pas di switch ikon ikut hijau
                        value: pengeluaran,
                        onChanged: (bool value) {
                          setState(() {
                            pengeluaran = value;
                            type = value ? 2 : 1;
                          });
                        },
                        inactiveTrackColor: Colors.grey,
                        inactiveThumbColor: Colors.white,
                        activeColor: Colors.white,
                      ),
                      Text(
                        pengeluaran ? 'Pengeluaran' : 'Pemasukan',
                        style: GoogleFonts.poppins(
                            fontSize: 14, color: kTextColor),
                      ),
                      //Button ASS +
                      IconButton(
                          onPressed: () {
                            //membuka dialog
                            bukaDialog(null);
                          },
                          icon: Icon(Icons.add))
                    ],
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
                          return ListView.builder(
                            //mengambil data dari data base pake item count
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                key: UniqueKey(),
                                //delete
                                background: Container(
                                  color: kScaffoldColor,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                                //edit
                                secondaryBackground: Container(
                                  color: kScaffoldColor,
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Icon(Icons.edit, color: Colors.white),
                                ),
                                onDismissed: (direction) {
                                  if (direction ==
                                      DismissDirection.startToEnd) {
                                    // Delete kategori
                                    database.deleteCategoryRepo(
                                        snapshot.data![index].id);
                                  } else if (direction ==
                                      DismissDirection.endToStart) {
                                    // Edit kategori
                                    bukaDialog(snapshot.data![index]);
                                  }
                                  setState(() {});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Card(
                                    elevation: 10,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: kPrimaryColor),
                                      child: ListTile(
                                          leading: Container(
                                              padding: EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                  color: kPrimaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: (pengeluaran)
                                                  ? Icon(Icons.upload,
                                                      color: kTextColor)
                                                  : Icon(
                                                      Icons.download,
                                                      color: kTextColor,
                                                    )),
                                          title: Text(
                                            //agar menyesuaikan dengan data yang diimput pada kategori
                                            snapshot.data![index].name,
                                            style: GoogleFonts.poppins(
                                                color: kTextColor),
                                          )),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(
                              child: Text(
                            "Kategori Kosong",
                            style: GoogleFonts.poppins(color: kTextColor),
                          ));
                        }
                      } else {
                        return Center(
                            child: Text("Kategori Kosong",
                                style: GoogleFonts.poppins(color: kTextColor)));
                      }
                    }
                  },
                ),
              ],
            )));
  }
}
