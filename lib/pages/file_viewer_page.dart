import 'dart:convert' as utf8;
import 'dart:typed_data';
import 'package:docx_to_text/docx_to_text.dart';
import 'package:flutter/material.dart';

class FileViewerPage extends StatefulWidget {
  const FileViewerPage(this.title, this.bytes, {super.key});

  final String title;
  final Uint8List bytes;

  @override
  State<FileViewerPage> createState() => _FileViewerPageState();
}

class _FileViewerPageState extends State<FileViewerPage> {

  @override
  Widget build(BuildContext context) {
    final docx = docxToText(widget.bytes).codeUnits;
    String text = const utf8.Utf8Decoder(allowMalformed: true).convert(docx);

    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(text, style: const TextStyle(fontSize: 17),),
      )),
    );
  }
}
