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
        int i =0;
        photos.forEach((element) {
          if(i<4) {
            photosFiles.add(File(element.path));
            i++;
          }
        });
        return photosFiles;
      }
    }
    catch(e){
      print("Failed to pick image $e");
    }
  }

  Future<File?> getPhotoFromGallery() async {
    try{
      final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
      if(photo == null)
        return null;
      else{
        final File photoFile;
        photoFile = File(photo.path);
        return photoFile;
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