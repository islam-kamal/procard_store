// ignore_for_file: public_member_api_docs

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:procard_store/Model/Orders_Model/orders_model.dart';

class ShareOrderPdf extends StatelessWidget {
  final int order_number;
  final String price;
  final String status;
  final String date;
  List<Products> products;
  ShareOrderPdf({this.order_number,this.status,this.date,this.products,this.price });


  @override
  Widget build(BuildContext context) {
    return  PdfPreview(
          build: (format) => _generatePdf(
            format: format,
            status: status,
            date: date,
            price: price,
            products: products,
            order_number: order_number.toString()
          )
    );
  }

  Future<Uint8List> _generatePdf({PdfPageFormat format, String order_number, String price, String status, String date,List<Products> products }) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
              pw.SizedBox(
                width: double.infinity,
                child: pw.FittedBox(child: pw.Text('#${order_number}', style: pw.TextStyle(font: font)),),
              ),
              pw.SizedBox(height: 20),
              pw.Flexible(child: pw.Text('Price :  ${price}', style: pw.TextStyle(font: font)),),
              pw.SizedBox(height: 20),
              pw.Flexible(child: pw.Text('products', style: pw.TextStyle(font: font)),),
              pw.ListView.builder(
                itemCount: products.length,
                  itemBuilder: (context , index){
                    return   pw.Flexible(child: pw.Text('${products[index]}', style: pw.TextStyle(font: font)),);
                  },
              ),
              pw.SizedBox(height: 20),
              pw.Flexible(child: pw.Text('status   :  ${status}', style: pw.TextStyle(font: font)),),
              pw.SizedBox(height: 20),
              pw.Flexible(child: pw.Text('date   :  ${date}', style: pw.TextStyle(font: font)),),

            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}