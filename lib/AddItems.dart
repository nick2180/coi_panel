// ignore_for_file: file_names, non_constant_identifier_names

import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coi_panel/Classes/COI.dart';
import 'package:coi_panel/Classes/Items.dart';
import 'package:coi_panel/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  double space = 20;
  int activeCOI = 0;

  bool paste = false;

  String copiedText = '';

  List<String> db = [
    'un',
    'deux',
  ];

  String dropdownValue = 'Select COI';
  ClipboardData data = ClipboardData(text: '<Text to copy goes here>');
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
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: mainColor,
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                            childAspectRatio: 1.5,
                            mainAxisSpacing: space,
                            crossAxisSpacing: space,
                            crossAxisCount: 2,
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
            title: Column(
              children: [
                Text(
                  'Add an item to ' + coi.coi,
                  style: TextStyle(
                    color: mainColor,
                    fontSize: textSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                MaterialButton(
                  color: mainColor,
                  onPressed: () {
                    setState(() {
                      FlutterClipboard.paste().then((value) {
                        setState(
                          () {
                            itemController.text = value.toString();
                          },
                        );
                      });
                    });
                  },
                  child: Text(
                    'Paste',
                    style: TextStyle(
                      color: secondColor,
                      fontSize: textSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
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
                      textCapitalization: TextCapitalization.words,
                      controller: itemController,
                    ),
                    width: 150,
                  ),
                  Container(
                    child: MaterialButton(
                      onPressed: () {
                        Future AddNewItem(Item sub) async {
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

                        AddNewItem(item);

                        Future IncreaseItems(COI coi) async {
                          final docUser = FirebaseFirestore.instance
                              .collection(
                                'COIs',
                              )
                              .doc(coi.coi);

                          final json = coi.toJson();

                          await docUser.set(json);
                        }

                        final increaseItemNumber = COI(
                            subs: coi.subs + 1,
                            coi: coi.coi,
                            followers: coi.followers,
                            isReviewed: true);
                        IncreaseItems(increaseItemNumber);

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
                    width: 60,
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
