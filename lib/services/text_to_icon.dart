
import 'package:flutter/material.dart';


Icon iconForPackage(String packageName) {
  switch (packageName) {
    case 'com.instagram.android':
      return const Icon(Icons.camera_alt);
    case 'com.whatsapp':
      return const Icon(Icons.chat);
    case 'com.snapchat.android':
      return const Icon(Icons.message);
    case 'com.facebook.katana':
      return const Icon(Icons.facebook);
    case 'com.twitter.android':
      return const Icon(Icons.alternate_email);
    case 'com.google.android.youtube':
      return const Icon(Icons.ondemand_video);
    case 'com.spotify.music':
      return const Icon(Icons.music_note);
    default:
      return const Icon(Icons.apps);
  }
}
