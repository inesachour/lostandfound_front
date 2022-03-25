import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerService{
  final ImagePicker _picker = ImagePicker();
  String path="assets/publications_images";

  Future<List<File>?> getPhotosFromGallery() async {
    try{
      final List<XFile>? photos = await _picker.pickMultiImage();
      if(photos == null)
        return [];
      else{
        final List<File> photosFiles = [];
        photos.forEach((element) {
          photosFiles.add(File(element.path));
        });
        return photosFiles;
      }
    }
    catch(e){
      print("Failed to pick image $e");
    }
  }

  savePhoto(File photo,String name) async{
    final File newPhoto = await photo.copy('$path/$name.png');
    return newPhoto;
  }

  /*
  getPhotoFromCamera() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
  }
  */
}