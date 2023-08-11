


import 'package:permission_handler/permission_handler.dart';

class PermissionHandler{
  Future<bool> askPermission({bool location = false, bool media = false,bool notifikasi = false}) async{
    bool granted = true;
    if(location){
      var status = await Permission.location.request();
      if (status.isDenied) {
        granted = false;
      }
      if (status.isRestricted) {
        granted = false;
      }

      if (status.isPermanentlyDenied){
        granted = false;
      }
    }


    // if(camera){
    //   var status = await Permission.camera.request();
    //   if (status.isDenied) {
    //     granted = false;
    //   }
    //   if (status.isRestricted) {
    //     granted = false;
    //   }
    // }
    // if(storage){
    //   var status = await Permission.storage.request();
    //   if (status.isDenied) {
    //     granted = false;
    //   }
    //   if (status.isRestricted) {
    //     granted = false;
    //   }
    // }


    if(media){
      var statusPhoto = await Permission.photos.request();
      var statusVideo = await Permission.videos.request();
      var statusAudio = await Permission.audio.request();

      if (statusPhoto.isDenied || statusAudio.isDenied || statusVideo.isDenied  ) {
        granted = false;
      }

      if (statusPhoto.isPermanentlyDenied || statusAudio.isPermanentlyDenied || statusVideo.isPermanentlyDenied) {
        granted = false;
      }
    }

    if(notifikasi){
      var status = await Permission.notification.request();
      if (status.isDenied) {
        granted = false;
      }
      if (status.isRestricted) {
        granted = false;
      }
      if (status.isPermanentlyDenied) {
        granted = false;
      }
    }
    return granted;

  }
}