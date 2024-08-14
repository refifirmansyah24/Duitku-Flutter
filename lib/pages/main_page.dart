import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tbduitku/constanta.dart';
import 'package:tbduitku/pages/category_page.dart';
import 'package:tbduitku/pages/home_page.dart';
import 'package:tbduitku/pages/transaksi_page.dart';
import 'package:tbduitku/hidden_drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late DateTime selectedDate;
  late List<Widget> _children;
  late int currentIndex;
  bool showCalendarAppBar = true;

  @override
  void initState() {
    updateView(0, DateTime.now());
    super.initState();
  }

  // Update view and date
  void updateView(int index, DateTime? date) {
    setState(() {
      if (date != null) {
        selectedDate = DateTime.parse(DateFormat('yyyy-MM-dd').format(date));
      }
      currentIndex = index;
      _children = [
        HomePage(
          selectedDate: selectedDate,
        ),
        CategoryPage(),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (currentIndex == 0 && showCalendarAppBar)
          ? PreferredSize(
              preferredSize: Size.fromHeight(220),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(0),
                  bottom: Radius.circular(35.0),
                ),
                child: CalendarAppBar(
                  padding: 3.0,
                  accent: kNewColor,
                  backButton: false,
                  locale: 'id',
                  onDateChanged: (value) {
                    setState(() {
                      selectedDate = value;
                      updateView(0, selectedDate);
                    });
                  },
                  firstDate: DateTime.now().subtract(Duration(days: 140)),
                  lastDate: DateTime.now(),
                ),
              ),
            )
          : null,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(right: 16, top: 1),
            alignment: Alignment.topRight,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  showCalendarAppBar = !showCalendarAppBar;
                });
              },
              child:
                  Text(showCalendarAppBar ? 'Hide Calendar' : 'Show Calendar'),
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                  backgroundColor: kScaffoldColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
            ),
          ),
          Expanded(child: _children[currentIndex]),
        ],
      ),
      floatingActionButton: Visibility(
        visible: (currentIndex == 0),
        child: FloatingActionButton(
          elevation: 10,
          onPressed: () {
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (context) => TransaksiPage(
                  transactionWithCategory: null,
                ),
              ),
            )
                .then((value) {
              setState(() {});
            });
          },
          backgroundColor: kNewColor,
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
