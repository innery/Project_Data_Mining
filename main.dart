import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  String _predictionResult = "";

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _predictionResult = ""; // Reset result when a new image is picked
      });
      await _sendImageToAPI(_image!);
    }
  }

  Future<void> _sendImageToAPI(File image) async {
    const String apiUrl = "http://10.0.2.2:52500/predict";


    try {
      // Prepare the image file for upload
      final request = http.MultipartRequest('POST', Uri.parse(apiUrl))
        ..files.add(await http.MultipartFile.fromPath('image', image.path));

      // Send the request
      final response = await request.send();

      if (response.statusCode == 200) {
        // Parse the response
        final responseData =
            json.decode(await response.stream.bytesToString());
        setState(() {
          _predictionResult = responseData['predictions'].toString();
        });
      } else {
        setState(() {
          _predictionResult =
              "Error: Server returned status code ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        _predictionResult = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Select an image and get predictions:',
            ),
            const SizedBox(height: 20),
            _image == null
                ? const Text('No image selected.')
                : Image.file(
                    _image!,
                    height: 200,
                  ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Resim Seç'),
            ),
            const SizedBox(height: 20),
            Text(
              _predictionResult.isEmpty
                  ? 'Prediction results will appear here.'
                  : 'Prediction Results:\n$_predictionResult',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
