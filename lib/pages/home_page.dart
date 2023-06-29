import 'dart:convert';

import 'package:consejofeem/constants.dart';
import 'package:consejofeem/pages/file_viewer_page.dart';
import 'package:docx_to_text/docx_to_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    final list = [
      file1, 
      file2, 
      file3,
      file5, 
      file6, 
      file7, 
      file8, 
      file9, 
      file10
    ];
    final images = [
      "img1.jpg", 
      "img3.jpg", 
      "img11.jpg",
      "img5.jpg", 
      "img9.jpg",
      "img4.jpg",
      "img7.jpg",
      "img12.jpg",
      "img6.jpg",
    ];

    print(list.length);
    print(images.length);

    return Scaffold(
      appBar: AppBar(title: const Text("Consejo nacional FEEM"),),
      body: ListView.builder(
        itemCount: list.length+1,
        itemBuilder: (context, i) {
          if(i==0){
            return Image.asset("assets/images/cover.jpg", height: 350, fit: BoxFit.cover,);
          }
          return Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: InkWell(
                    onTap: () async {
                      // final file = File(root+list[index]);
                      // final bytes = await file.readAsBytes();

                      final bytes = await getBytesFromFile(list[i-1]);
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return FileViewerPage(list[i-1].replaceAll(".docx", ""), bytes);
                      },));
                    },
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset("assets/images/${images[i-1]}", height: 100, width: 100, fit: BoxFit.cover,)
                        ),
                        const SizedBox(width: 10,),
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(list[i-1].replaceAll(".docx", ""), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                              const SizedBox(height: 10,),
                              FutureBuilder<String>(
                                future: getTextFromDocx(list[i-1]),
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
  
  Future<String> getTextFromDocx(String fileName) async {
    // final file = File(root+fileName);
    // final bytes = await file.readAsBytes();
    final docx = docxToText(await getBytesFromFile(fileName)).codeUnits;
    return const Utf8Decoder(allowMalformed: true).convert(docx);
  }

  Future<Uint8List> getBytesFromFile(String fileName) async {
    return (await rootBundle.load("assets/files/$fileName")).buffer.asUint8List();
  }
}