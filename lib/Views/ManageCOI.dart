// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coi_panel/Classes/COI.dart';
import 'package:coi_panel/Classes/Items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManageCOIView extends StatefulWidget {
  const ManageCOIView({Key? key}) : super(key: key);

  @override
  State<ManageCOIView> createState() => _ManageCOIViewState();
}

class _ManageCOIViewState extends State<ManageCOIView> {
  Color mainColor = Colors.black;
  Color secondColor = Colors.white;

  double titleSize = 60;
  double textSize = 20;
  double itemSize = 30;
  double bottomText = 10;
  double iconSize = 15;
  double space = 10;

  Color reviewedColor(Item item) {
    if (item.isReviewed == true) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          actions: [],
        ),
        body: Center(
            child: SingleChildScrollView(
          padding: const EdgeInsets.all(
            50,
          ),
          child: Column(
            children: [
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
                          crossAxisCount: 4,
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
        )),
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
                  'List of items in ' + coi.coi,
                  style: TextStyle(
                    color: mainColor,
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            content: SingleChildScrollView(
              child: Row(
                children: <Widget>[
                  Container(
                    height: 600,
                    width: 1500,
                    child: StreamBuilder<List<Item>>(
                      stream: FirebaseFirestore.instance
                          .collection(
                            'COIs',
                          )
                          .doc(coi.coi)
                          .collection('subs')
                          .orderBy('item', descending: false)
                          .snapshots()
                          .map(
                            (snapshots) => snapshots.docs
                                .map((doc) => Item.fromJson(doc.data()))
                                .toList(),
                          ),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Erreur');
                        } else if (snapshot.hasData) {
                          final item = snapshot.data!;

                          return GridView.count(
                              childAspectRatio: 2,
                              mainAxisSpacing: space,
                              crossAxisSpacing: space,
                              crossAxisCount: 4,
                              children: item.map(showItems).toList());
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

  Widget showItems(Item item) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        shape: BoxShape.rectangle,
      ),
      child: InkWell(
        onTap: () => showCupertinoDialog<void>(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog();
          },
        ),
        child: Column(
          children: [
            Text(
              item.item,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: mainColor,
                fontSize: itemSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              height: 10,
              color: mainColor,
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    'Followers: ',
                    style: TextStyle(
                      color: mainColor,
                      fontSize: textSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    item.followers.toString(),
                    style: TextStyle(
                      color: mainColor,
                      fontSize: textSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    'isReviewed: ',
                    style: TextStyle(
                      color: mainColor,
                      fontSize: textSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    item.isReviewed.toString(),
                    style: TextStyle(
                      color: reviewedColor(item),
                      fontSize: textSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
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
