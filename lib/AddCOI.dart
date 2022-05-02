import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coi_panel/Classes/COI.dart';
import 'package:flutter/material.dart';

class AddCOIView extends StatefulWidget {
  const AddCOIView({Key? key}) : super(key: key);

  @override
  State<AddCOIView> createState() => _AddCOIViewState();
}

class _AddCOIViewState extends State<AddCOIView> {
  Color textColor = Colors.black;

  double titleSize = 30;
  double textSize = 20;

  TextEditingController COIController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: textColor,
          actions: [],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 150,
                ),
                Text(
                  'Add a Center Of Interest',
                  style: TextStyle(
                    color: textColor,
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 150,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      child: Text(
                        'COI name:',
                        style: TextStyle(
                          color: textColor,
                          fontSize: textSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      width: 100,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      child: TextFormField(
                        controller: COIController,
                        decoration: InputDecoration(
                          fillColor: textColor,
                        ),
                      ),
                      width: 200,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                MaterialButton(
                  onPressed: () {
                    var rng = Random();

                    final coi = COI(
                      coi: COIController.text,
                      followers: rng.nextInt(1000000),
                      isReviewed: true,
                    );

                    AddNewCOI(coi);

                    COIController.clear();
                  },
                  padding: const EdgeInsets.all(
                    30,
                  ),
                  color: textColor,
                  child: Text(
                    'Send',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: textSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future AddNewCOI(COI coi) async {
    final docUser = FirebaseFirestore.instance
        .collection(
          'COIs',
        )
        .doc(coi.coi);

    final json = coi.toJson();

    await docUser.set(json);
  }
}
