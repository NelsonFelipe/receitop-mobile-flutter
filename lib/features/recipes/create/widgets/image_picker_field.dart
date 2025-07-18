import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerField extends StatelessWidget {
  final File? imageFile;
  final ValueChanged<File> onImagePicked;

  const ImagePickerField({
    Key? key,
    required this.imageFile,
    required this.onImagePicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (picked != null) onImagePicked(File(picked.path));
      },
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          image: imageFile != null
            ? DecorationImage(
                image: FileImage(imageFile!), fit: BoxFit.cover)
            : null,
        ),
        child: imageFile == null
          ? Center(child: Icon(Icons.camera_alt, size: 40, color: Colors.grey))
          : null,
      ),
    );
  }
}
