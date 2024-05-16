import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gallery_task/presentation/resources/api_manager.dart';
import 'package:gallery_task/presentation/resources/utilities.dart';
import '../resources/constants.dart';
import '../resources/routes_manager.dart';

class GalleryView extends StatefulWidget {
  const GalleryView({super.key});

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  @override
  Widget build(BuildContext context) {
    ApiManager apiManager = ApiManager();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Constants.galleryBgUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(100.w.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                Constants.welcomeString,
                style: TextStyle(fontSize: 28.sp),
              ),
              FutureBuilder(
                future: Utilities.getName(),
                builder: (context, snapshot) {
                  var name = snapshot.data;
                  return Text(
                    name ?? "",
                    style: TextStyle(fontSize: 28.sp),
                  );
                },
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50.r)),
                    width: 100.w,
                    height: 50.h,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, Routes.loginRoute);
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 5.w),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5.r)),
                            child: const Icon(
                              Icons.arrow_back,
                            ),
                          ),
                          SizedBox(width: 5.w),
                          const Text(Constants.logOutString)
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.white.withOpacity(0.5),
                            content: SizedBox(
                              height: 200.h,
                              child: Column(children: [
                                GestureDetector(
                                  onTap: () async {
                                    apiManager.uploadGalleryImage();
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 70.h,
                                    width: 150.w,
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(width: 10.w),
                                        const Icon(Icons.image_sharp),
                                        SizedBox(width: 5.w),
                                        const Text(
                                          Constants.galleryString,
                                          style: TextStyle(fontSize: 22),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 55.h),
                                Container(
                                  height: 70.h,
                                  width: 150.w,
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: GestureDetector(
                                    onTap: () async {
                                      apiManager.uploadCameraImage();
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(width: 10.w),
                                        const Icon(Icons.camera_alt_outlined),
                                        SizedBox(width: 5.w),
                                        const Text(
                                          Constants.cameraString,
                                          style: TextStyle(fontSize: 22),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50.r)),
                      width: 100.w,
                      height: 50.h,
                      child: Row(
                        children: [
                          SizedBox(width: 5.w),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(5.r)),
                            child: const Icon(
                              Icons.arrow_upward_sharp,
                            ),
                          ),
                          SizedBox(width: 5.w),
                          const Text(Constants.uploadString)
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              Expanded(
                child: FutureBuilder(
                  future: apiManager.getImages(),
                  builder: (context, snapshot) {
                    var images = snapshot.data?.data?.images;
                    return GridView.builder(
                      itemCount: images?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(images![index]),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(25.r)),
                          // width: 10,
                          // height: 15,
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 15.h,
                        mainAxisSpacing: 15.w,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
