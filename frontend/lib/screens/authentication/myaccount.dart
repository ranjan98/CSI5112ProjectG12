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
              const SizedBox(height: 30),
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
                  DataRow(cells: [
                    DataCell(
                      Text("Job Title",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    DataCell(Text('Software Developer')),
                  ]),
                  DataRow(cells: [
                    DataCell(
                      Text("Payment Method",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    DataCell(Text('Credit Card')),
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
