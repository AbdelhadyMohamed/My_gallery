import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:gallery_task/data/models/GalleryResponse.dart';
import 'package:gallery_task/presentation/resources/utilities.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/models/UserData.dart';
import 'constants.dart';

class ApiManager {
  Dio dio = Dio();

  Future<Either<String, UserData>> logIn(
      String? userName, String? password) async {
    // print(userName);
    // print(password);
    Response response = await dio.post(
      "${Constants.baseUrl}auth/login",
      data: {
        'email': "jessica.pouros@example.org",
        'password': "password",
      },
    );
    try {
      UserData userData = UserData.fromJson(response.data);
      Utilities.storeToken(userData.token ?? "");
      Utilities.storeName(userData.user?.name ?? "");
      return Right(userData);
    } catch (e) {
      print(e.toString());
      return Left(response.data.toString());
    }
  }

  Future<GalleryResponse> getImages() async {
    String token = await Utilities.getToken(); // Await the token retrieval

    print("TOKEN IS : $token");
    Response response = await dio.get(
      "${Constants.baseUrl}my-gallery",
      options: Options(
        headers: {
          'Authorization':
              'Bearer $token', // Pass the token in the Authorization header
        },
      ),
    );
    GalleryResponse galleryResponse = GalleryResponse.fromJson(response.data);
    return galleryResponse;
  }

  Future<void> uploadGalleryImage() async {
    int? n;
    for (var i = 0; i < 5; i++) {
      n = (Random().nextInt(1000));
    }
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      print('No image selected');
      return;
    }
    File imageFile = File(pickedFile.path);

    FormData formData = FormData.fromMap({
      'img': await MultipartFile.fromFile(
        imageFile.path,
        filename: 'image${n ?? 0}.jpg',
      ),
    });
    String token = await Utilities.getToken();
    Response response = await dio.post(
      "${Constants.baseUrl}upload",
      data: formData,
      options: Options(
        headers: {
          'Authorization':
              'Bearer $token', // Pass the token in the Authorization header
        },
      ),
    );
  }

  Future<void> uploadCameraImage() async {
    int? n;
    for (var i = 0; i < 5; i++) {
      n = (Random().nextInt(1000));
    }
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) {
      print('No image selected');
      return;
    }
    File imageFile = File(pickedFile.path);

    FormData formData = FormData.fromMap({
      'img': await MultipartFile.fromFile(
        imageFile.path,
        filename: 'image${n ?? 0}.jpg',
      ),
    });
    String token = await Utilities.getToken();
    Response response = await dio.post(
      "${Constants.baseUrl}upload",
      data: formData,
      options: Options(
        headers: {
          'Authorization':
              'Bearer $token', // Pass the token in the Authorization header
        },
      ),
    );
  }
}
