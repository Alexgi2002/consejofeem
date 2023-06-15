import 'dart:convert';
import 'dart:io';

import 'package:consejofeem/constants.dart';
import 'package:consejofeem/pages/file_viewer_page.dart';
import 'package:docx_to_text/docx_to_text.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage(this.root, {super.key});

  final String root;

  @override
  Widget build(BuildContext context) {

    final list   = [file1, file2, file3, file4, file5, file6];
    final images = ["img1.jpg", "img3.jpg", "img11.jpg", "img10.jpg", "img5.jpg", "img4.jpg"];

    return Scaffold(
      appBar: AppBar(title: const Text("Consejo nacional FEEM"),),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: InkWell(
                    onTap: () async {
                      final file = File(root+list[index]);
                      final bytes = await file.readAsBytes();
              
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return FileViewerPage(list[index].replaceAll(".docx", ""), bytes);
                      },));
                    },
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset("assets/images/${images[index]}", height: 100, width: 100, fit: BoxFit.cover,)
                        ),
                        const SizedBox(width: 10,),
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(list[index].replaceAll(".docx", ""), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                              const SizedBox(height: 10,),
                              FutureBuilder<String>(
                                future: getTextFromDocx(root, list[index]),
                                builder: (context, snapshot) {
                                  if(snapshot.hasData && snapshot.data!=null && snapshot.data!.isNotEmpty){
                                    return Text(snapshot.data!, maxLines: 3, overflow: TextOverflow.ellipsis,);
                                  }
                                  return const SizedBox();
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );          
        }, 
      )
      
      
      /*SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Text(file1.replaceAll(".docx", ""))
                    ],
                  ),
                ),
              ),
              Center(
                child: FilledButton(onPressed: () async {
              
                  final file = File(root+file6);
                  final bytes = await file.readAsBytes();
              
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FileViewerPage(file1.replaceAll(".docx", ""), bytes);
                  },));
                }, child: Text("ver pagina")),
              ),
            ],
          ),
        ),
      ),*/
    );
  }
  
  Future<String> getTextFromDocx(String root, String fileName) async {
    final file = File(root+fileName);
    final bytes = await file.readAsBytes();
    final docx = docxToText(bytes).codeUnits;
    return const Utf8Decoder(allowMalformed: true).convert(docx);
  }
}