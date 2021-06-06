import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

class ImageController{
  static final _picker = ImagePicker();

  static Future<Uint8List> getImageFromGallery() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    Uint8List _newImageBytes = await File(pickedFile.path).readAsBytes();
    return _newImageBytes;
  }

  static Future<Uint8List> getImageFromCamera() async {
    final pickedFile = await _picker.getImage(source: ImageSource.camera);
    Uint8List _newImageBytes = await File(pickedFile.path).readAsBytes();
    return _newImageBytes;
  }
}