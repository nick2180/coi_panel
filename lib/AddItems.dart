// ignore_for_file: file_names, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coi_panel/Classes/COI.dart';
import 'package:coi_panel/Classes/Items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddSubView extends StatefulWidget {
  const AddSubView({Key? key}) : super(key: key);

  @override
  State<AddSubView> createState() => _MainViewState();
}

class _MainViewState extends State<AddSubView> {
  Color mainColor = Colors.black;
  Color secondColor = Colors.white;

  double titleSize = 60;
  double textSize = 20;
  double bottomText = 10;
  double iconSize = 15;

  int activeCOI = 0;

  double space = 20;
  List<String> db = [
    'un',
    'deux',
  ];

  String dropdownValue = 'Select COI';

  final subController = TextEditingController();
  final itemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          actions: [],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(
            30,
          ),
          child: Center(
            child: Column(
              children: [
                Text(
                  'Add sub to COI',
                  style: TextStyle(
                    color: mainColor,
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 150,
                ),
                Container(
                  height: 800,
                  child: StreamBuilder<List<COI>>(
                    stream: COIList(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Erreur');
                      } else if (snapshot.hasData) {
                        final coi = snapshot.data!;

                        return GridView.count(
                            childAspectRatio: 2,
                            mainAxisSpacing: space,
                            crossAxisSpacing: space,
                            crossAxisCount: 5,
                            children: coi.map(showCOI).toList());
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showCOI(COI coi) {
    return InkWell(
      onTap: () => showCupertinoDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Add an item to ' + coi.coi,
              style: TextStyle(
                color: mainColor,
                fontSize: textSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SingleChildScrollView(
              child: Row(
                children: <Widget>[
                  Container(
                    child: const Text('Item:'),
                    width: 50,
                  ),
                  Container(
                    child: TextFormField(
                      controller: itemController,
                    ),
                    width: 150,
                  ),
                  Container(
                    child: MaterialButton(
                      onPressed: () {
                        Future AddNewCOI(Item sub) async {
                          final docUser = FirebaseFirestore.instance
                              .collection(
                                'COIs',
                              )
                              .doc(coi.coi)
                              .collection('subs')
                              .doc(sub.item);

                          final json = sub.toJson();

                          await docUser.set(json);
                        }

                        final item = Item(
                          item: itemController.text,
                          followers: 0,
                          isReviewed: true,
                        );

                        AddNewCOI(item);

                        itemController.clear();
                      },
                      color: mainColor,
                      child: Text(
                        'OK',
                        style: TextStyle(
                          color: secondColor,
                          fontSize: textSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    width: 50,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      child: Container(
        width: 400,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: mainColor,
          ),
          color: secondColor,
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(20),
                border: Border.all(color: mainColor),
                color: mainColor,
              ),
              width: 600,
              child: Text(
                coi.coi,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: secondColor,
                  fontSize: textSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      'Subs',
                      style: TextStyle(
                        color: mainColor,
                        fontSize: textSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      coi.subs.toString(),
                      style: TextStyle(
                        color: mainColor,
                        fontSize: bottomText,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Stream<List<COI>> COIList() => FirebaseFirestore.instance
      .collection(
        'COIs',
      )
      .orderBy('coi', descending: false)
      .snapshots()
      .map(
        (snapshots) =>
            snapshots.docs.map((doc) => COI.fromJson(doc.data())).toList(),
      );
}
