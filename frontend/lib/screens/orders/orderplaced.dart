import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../providers/cart.dart';
import '../../providers/user_provider.dart';

class OrderPlaced extends StatelessWidget {
  const OrderPlaced({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final orderPlaced = ModalRoute.of(context)!.settings.arguments
        as List; // contains the order and total Amount of the order!
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Order Submitted',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              )),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            // show the basic details for the user via the header
            const SizedBox(height: 60),
            const Center(
                child: Text(
              'Thank you!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )),
            const Image(
                image: AssetImage('assets/images/orderplaced.png'),
                height: 350,
                width: 300),
            const Center(
                child: SizedBox(
                    width: 300,
                    child: Text(
                      'Your order has been submitted.',
                      style: TextStyle(fontSize: 14, color: Colors.blueGrey),
                      textAlign: TextAlign.center,
                    ))),
            const SizedBox(height: 20),
            // const Center(
            //     child: SizedBox(
            //         width: 300,
            //         child: Text(
            //           'Order No# 3453242',
            //           style: TextStyle(fontSize: 14, color: Colors.blueGrey),
            //           textAlign: TextAlign.center,
            //         ))),
            Row(
              children: <Widget>[
                FloatingActionButton.extended(
                  icon: const Icon(Icons.print),
                  label: const Text('Print Invoice'),
                  onPressed: () {
                    pw.Document doc = printInvoice(
                        orderPlaced[0], orderPlaced[1], userProvider);
                    Printing.layoutPdf(
                        onLayout: (PdfPageFormat format) async => doc
                            .save()); //printing invoice for the pdf generated
                  },
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            // Commenting this for now as it does not add a lot of value as a feature
            // const SizedBox(height: 12),
            // Row(
            //   children: <Widget>[
            //     FloatingActionButton.extended(
            //       label: const Text('Continue Shopping'),
            //       onPressed: () {
            //         Navigator.of(context).popAndPushNamed('/home');
            //       },
            //     )
            //   ],
            //   mainAxisAlignment: MainAxisAlignment.center,
            // ),
          ],
        ));
  }

  pw.Document printInvoice(
      List<CartItem> order, num total, UserProvider userProvider) {
    List<pw.Text> items = [];
    for (var element in order) {
      items.add(pw.Text(
          element.title +
              "\t \$" +
              element.price.toStringAsFixed(2) +
              "\t x " +
              element.quantity.toString(),
          style: const pw.TextStyle(fontSize: 20)));
    }
    final doc = pw.Document();
    // creating a page of the invoice
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
                children: [
                      // Writing the content of the order to the pdf
                      pw.Text("UOMart",
                          style: const pw.TextStyle(fontSize: 40)),
                      pw.SizedBox(height: 20),
                      pw.Text(
                          "Invoice #" +
                              DateTime.now().millisecondsSinceEpoch.toString(),
                          style: const pw.TextStyle(fontSize: 30)),
                      pw.SizedBox(height: 10),
                      pw.Text(
                          DateFormat("yyyy-MM-dd hh:mm:ss")
                              .format(DateTime.now())
                              .toString(),
                          style: const pw.TextStyle(fontSize: 15)),
                      pw.SizedBox(height: 10),

                      pw.Text(
                          userProvider.users.first.name +
                              " - " +
                              userProvider.users.first.email,
                          style: const pw.TextStyle(fontSize: 15)),
                      pw.SizedBox(height: 10),
                      pw.Divider(),
                      pw.SizedBox(height: 20),
                    ] +
                    items +
                    [
                      pw.SizedBox(height: 10),
                      pw.Text("Total: \$" + total.toStringAsFixed(2),
                          style: pw.TextStyle(
                              fontSize: 20, fontWeight: pw.FontWeight.bold))
                    ]),
          );
        }));
    return doc;
  }
}
