import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:consejofeem/constants.dart';
import 'package:consejofeem/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final root = await getExternalStorageDirectory();
  if(root!=null){
    if(!File("${root.path}/$file1").existsSync()) createFileFromAssets(root.path, file1);
    if(!File("${root.path}/$file2").existsSync()) createFileFromAssets(root.path, file2);
    if(!File("${root.path}/$file3").existsSync()) createFileFromAssets(root.path, file3);
    if(!File("${root.path}/$file4").existsSync()) createFileFromAssets(root.path, file4);
    if(!File("${root.path}/$file5").existsSync()) createFileFromAssets(root.path, file5);
    if(!File("${root.path}/$file6").existsSync()) createFileFromAssets(root.path, file6);
  }

  runApp(MainApp(root: root!.path));
}

Future<void> createFileFromAssets(String root, String assetFile) async {
  final path = join(root, assetFile);
  ByteData data = await rootBundle.load("assets/files/$assetFile");
  List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  await File(path).writeAsBytes(bytes);
}

class MainApp extends StatelessWidget {
  const MainApp({required this.root, super.key});

  final String root;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Consejo nacional FEEM",
      debugShowCheckedModeBanner: false,
      home: HomePage("$root/"),
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
