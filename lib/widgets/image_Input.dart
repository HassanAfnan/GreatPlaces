import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput({
     this.onSelectImage
  });

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> takePicture() async{
    final imageFile = await ImagePicker.pickImage(source: ImageSource.camera,maxHeight: 600);
    setState(() {
      _storedImage = File(imageFile.path);
    });
    if(imageFile == null){
      return;
    }
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 200,
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(width: 1,color: Colors.grey),
          ),
          child: _storedImage != null ? Image.file(_storedImage,fit: BoxFit.cover,width: double.infinity,) :Text('No Image Taken',textAlign: TextAlign.center,),
          alignment: Alignment.center,
        ),
        SizedBox(height: 10,),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text("Take Picture"),
            textColor: Theme.of(context).primaryColor,
            onPressed: () => takePicture(),
          ),
        )
      ],
    );
  }
}
