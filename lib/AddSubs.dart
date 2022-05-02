// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddSubView extends StatefulWidget {
  const AddSubView({Key? key}) : super(key: key);

  @override
  State<AddSubView> createState() => _MainViewState();
}

class _MainViewState extends State<AddSubView> {
  Color textColor = Colors.black;

  double titleSize = 30;
  double textSize = 20;

  int activeCOI = 0;

  List<String> db = [
    'un',
    'deux',
  ];

  String dropdownValue = 'Select COI';

  final subController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                    color: textColor,
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 150,
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: TextStyle(
                    color: textColor,
                    fontSize: textSize,
                    fontWeight: FontWeight.bold,
                  ),
                  underline: Container(
                    height: 2,
                    color: textColor,
                  ),
                  onChanged: (String? newValue) {
                    setState(
                      () {
                        dropdownValue = newValue!;
                        if (kDebugMode) {
                          print(dropdownValue);
                        }
                      },
                    );
                  },
                  onTap: () {
                    setState(
                      () {},
                    );
                  },
                  items: <String>[
                    'Select COI',
                    'One',
                    'Two',
                    'Free',
                    'Four',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 150,
                ),
                SizedBox(
                  width: 500,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 120,
                        child: Text(
                          'Sub Name:',
                          style: TextStyle(
                              color: textColor,
                              fontSize: textSize,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: subController,
                          cursorColor: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                MaterialButton(
                  padding: const EdgeInsets.all(15),
                  color: textColor,
                  onPressed: () {},
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

  DropDownAction() {
    setState(
      () {},
    );
  }
}
