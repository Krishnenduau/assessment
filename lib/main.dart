import 'package:assessment/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory documentDirectory = await initImage();
  runApp(MainApp(documentDirectory: documentDirectory));
}

Future<Directory> initImage() async {
  
// download image

  // to get application directory path
  Directory documentDirectory = await getApplicationDocumentsDirectory();
  // download image
  var response = await http.get(Uri.parse(AppUrls.image));
  // create file in documentdirectory with file name as image url
  File file =
      File(path.join(documentDirectory.path, path.basename(AppUrls.image)));
  // store the image
  await file.writeAsBytes(response.bodyBytes);
  //  returm documentdirectory for to show image
  return documentDirectory;
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.documentDirectory});
  final Directory documentDirectory;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Image Loaded from Applications Document Directory',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Image.file(File(path.join(
                    documentDirectory.path, path.basename(AppUrls.image))))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
