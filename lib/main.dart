import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:consejofeem/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /*final root = await getExternalStorageDirectory();
  if(root!=null){
    if(!File("${root.path}/$file1").existsSync()) createFileFromAssets(root.path, file1);
    if(!File("${root.path}/$file2").existsSync()) createFileFromAssets(root.path, file2);
    if(!File("${root.path}/$file3").existsSync()) createFileFromAssets(root.path, file3);
    if(!File("${root.path}/$file4").existsSync()) createFileFromAssets(root.path, file4);
    if(!File("${root.path}/$file5").existsSync()) createFileFromAssets(root.path, file5);
    if(!File("${root.path}/$file6").existsSync()) createFileFromAssets(root.path, file6);
    if(!File("${root.path}/$file7").existsSync()) createFileFromAssets(root.path, file7);
    if(!File("${root.path}/$file8").existsSync()) createFileFromAssets(root.path, file8);
    if(!File("${root.path}/$file9").existsSync()) createFileFromAssets(root.path, file9);
    if(!File("${root.path}/$file10").existsSync()) createFileFromAssets(root.path, file10);
  }*/

  runApp(const MainApp());
}

Future<void> createFileFromAssets(String root, String assetFile) async {
  final path = join(root, assetFile);
  ByteData data = await rootBundle.load("assets/files/$assetFile");
  List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  await File(path).writeAsBytes(bytes);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Consejo nacional FEEM",
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
            
      ),
      darkTheme: ThemeData.dark().copyWith(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark),
      ),
    );
  }
}
