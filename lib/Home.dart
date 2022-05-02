// ignore_for_file: file_names

import 'package:coi_panel/AddItems.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Color textColor = Colors.black;

  double titleSize = 30;
  double textSize = 20;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 300,
                ),
                MaterialButton(
                  padding: const EdgeInsets.all(
                    30,
                  ),
                  color: textColor,
                  onPressed: () {
                    Navigator.of(context).push(AddSubs());
                  },
                  child: Text(
                    'Add COI',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: textSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                MaterialButton(
                  padding: const EdgeInsets.all(
                    30,
                  ),
                  color: textColor,
                  onPressed: () {
                    Navigator.of(context).push(AddSubs());
                  },
                  child: Text(
                    'Add subs',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: textSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                MaterialButton(
                  padding: const EdgeInsets.all(
                    30,
                  ),
                  color: textColor,
                  onPressed: () {},
                  child: Text(
                    'Manage COI',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: textSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Route AddCOI() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context,
          Animation<double> animation, //
          Animation<double> secondaryAnimation) {
        return const AddSubView();
      },
      transitionsBuilder: (BuildContext context,
          Animation<double> animation, //
          Animation<double> secondaryAnimation,
          Widget child) {
        return child;
      },
    );
  }

  Route AddSubs() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context,
          Animation<double> animation, //
          Animation<double> secondaryAnimation) {
        return const AddSubView();
      },
      transitionsBuilder: (BuildContext context,
          Animation<double> animation, //
          Animation<double> secondaryAnimation,
          Widget child) {
        return child;
      },
    );
  }
}
