import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gallery_task/data/models/UserData.dart';
import 'package:gallery_task/presentation/resources/api_manager.dart';
import '../resources/constants.dart';
import '../resources/routes_manager.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final ApiManager apiManager = ApiManager();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Constants.logInBgUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 230.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                Constants.myString,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 50.sp,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                Constants.galleryString,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 50.sp,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 100.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 83.w),
                child: Column(children: [
                  Text(
                    Constants.logInString,
                    style:
                        TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 50.h),
                  TextField(
                    controller: userNameController,
                    autofocus: false,
                    style: TextStyle(fontSize: 15.sp),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: Constants.userNameString,
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                    ),
                  ),
                  SizedBox(height: 50.h),
                  TextField(
                    obscureText: true,
                    controller: passwordController,
                    autofocus: false,
                    style: TextStyle(fontSize: 15.sp),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: Constants.passwordString,
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                    ),
                  ),
                  SizedBox(height: 50.h),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        var result = await apiManager.logIn(
                            userNameController.text, passwordController.text);
                        result.fold((l) {
                          {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: SizedBox(
                                    height: 200.h,
                                    child: Text(l.toString()),
                                  ),
                                );
                              },
                            );
                          }
                        }, (r) {
                          if (r.token != null) {
                            Navigator.pushReplacementNamed(
                                context, Routes.galleryRoute);
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(Constants.ok),
                                    ),
                                  ],
                                  content: SizedBox(
                                    height: 200.h,
                                    child: Center(
                                      child: Text(
                                        Constants.errorCre,
                                        style: TextStyle(
                                            fontSize: 25.sp, color: Colors.red),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.blue),
                      ),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 65.w),
                        child: const Text(
                          Constants.submitString,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
