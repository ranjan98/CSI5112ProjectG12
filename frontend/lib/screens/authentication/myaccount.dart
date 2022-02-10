import 'package:flutter/material.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              DataTable(
                columns: [
                  DataColumn(
                    label: Container(),
                  ),
                  DataColumn(
                    label: Container(),
                  ),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text(
                      "Name",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.fade,
                    )),
                    DataCell(Text('Ranjan Goyal')),
                  ]),
                  DataRow(cells: [
                    DataCell(
                      Text("Email ID",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    DataCell(Text('rgoya021@uottawa.ca')),
                  ]),
                  DataRow(cells: [
                    DataCell(
                      Text("Mobile",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    DataCell(Text('613-xxx-xxxx')),
                  ]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
