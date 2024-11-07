import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mekanik/app/componen/color.dart';

import '../../../data/data_endpoint/login.dart';
import '../../../data/endpoint.dart';
import '../../../routes/app_pages.dart';
import '../common/common.dart';
import '../widgets/custom_widget.dart';
import 'fade_animationtest.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscureText = true;
  late TextEditingController _passwordController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
  }

  bool flag = true;
  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: MyColors.appPrimaryBackground,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: MyColors.appPrimaryColor,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: MyColors.appPrimaryColor,
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        },
        child: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
          child: size.width >= 600 // Check if the device is a tablet
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Form Section
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              MyColors.appPrimaryColor.withOpacity(0.0),
                              MyColors.appPrimaryColor.withOpacity(0.9),
                              MyColors.appPrimaryColor,
                            ],
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FadeInAnimation(
                                    delay: 1.3,
                                    child: Text(
                                      "Selamat Datang",
                                      style: Common().mediumTheme,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  FadeInAnimation(
                                    delay: 1.9,
                                    child: CustomTextFormField(
                                      hinttext: 'Masukkan email Anda',
                                      obsecuretext: false,
                                      controller: _emailController,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  FadeInAnimation(
                                    delay: 2.2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: MyColors.bgformborder),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: TextFormField(
                                        controller: _passwordController,
                                        obscureText: obscureText,
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.all(18),
                                          hintText: "Masukkan kata sandi Anda",
                                          hintStyle: Common().hinttext,
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          suffixIcon: IconButton(
                                            onPressed: togglePasswordVisibility,
                                            icon: Icon(
                                              obscureText
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  FadeInAnimation(
                                    delay: 2.5,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: () {
                                          // Get.to(const ForgetPasswordPage());
                                        },
                                        child: Text(
                                          "",
                                          style: Common().semiboldblack,
                                        ),
                                      ),
                                    ),
                                  ),
                                  FadeInAnimation(
                                    delay: 2.8,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: MyColors.bgformborder),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: CustomElevatedButton(
                                        message: "Masuk",
                                        function: () async {
                                          HapticFeedback.lightImpact();
                                          if (_emailController
                                                  .text.isNotEmpty &&
                                              _passwordController
                                                  .text.isNotEmpty) {
                                            try {
                                              Token aksesPX = await API.login(
                                                email: _emailController.text,
                                                password:
                                                    _passwordController.text,
                                              );

                                              if (aksesPX.status != false) {
                                                if (aksesPX.token != null) {
                                                  Get.offAllNamed(Routes.HOME);
                                                }
                                              } else {
                                                String errorMessage = aksesPX
                                                        .message ??
                                                    'Terjadi kesalahan saat login';
                                                Object errorDetail =
                                                    aksesPX.data ?? '';
                                                Get.snackbar('Error',
                                                    '$errorMessage: $errorDetail',
                                                    backgroundColor:
                                                        Colors.redAccent,
                                                    colorText: Colors.white);
                                              }
                                            } catch (e) {
                                              print('Error during login: $e');
                                              Get.snackbar('Gagal Login',
                                                  'Terjadi kesalahan saat login',
                                                  backgroundColor:
                                                      Colors.redAccent,
                                                  colorText: Colors.white);
                                            }
                                          } else {
                                            Get.snackbar('Gagal Login',
                                                'Username dan Password harus diisi',
                                                backgroundColor:
                                                    Colors.redAccent,
                                                colorText: Colors.white);
                                          }
                                        },
                                        color: MyColors.appPrimaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Logo Section
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: FadeInAnimation(
                          delay: 1.6,
                          child: Image.asset('assets/logo_autobenz2.png'),
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeInAnimation(
                            delay: 1.3,
                            child: Text(
                              "Selamat Datang",
                              style: Common().mediumTheme,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Form(
                        child: Column(
                          children: [
                            FadeInAnimation(
                              delay: 1.9,
                              child: CustomTextFormField(
                                hinttext: 'Masukkan email Anda',
                                obsecuretext: false,
                                controller: _emailController,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FadeInAnimation(
                              delay: 2.2,
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: MyColors.bgformborder),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  controller: _passwordController,
                                  obscureText: obscureText,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(18),
                                    hintText: "Masukkan kata sandi Anda",
                                    hintStyle: Common().hinttext,
                                    border: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: togglePasswordVisibility,
                                      icon: Icon(
                                        obscureText
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            FadeInAnimation(
                              delay: 2.5,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    // Get.to(const ForgetPasswordPage());
                                  },
                                  child: Text(
                                    "",
                                    style: Common().semiboldblack,
                                  ),
                                ),
                              ),
                            ),
                            FadeInAnimation(
                              delay: 2.8,
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: MyColors.bgformborder),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: CustomElevatedButton(
                                  message: "Masuk",
                                  function: () async {
                                    HapticFeedback.lightImpact();
                                    if (_emailController.text.isNotEmpty &&
                                        _passwordController.text.isNotEmpty) {
                                      try {
                                        Token aksesPX = await API.login(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                        );

                                        if (aksesPX.status != false) {
                                          if (aksesPX.token != null) {
                                            Get.offAllNamed(Routes.HOME);
                                          }
                                        } else {
                                          String errorMessage = aksesPX
                                                  .message ??
                                              'Terjadi kesalahan saat login';
                                          Object errorDetail =
                                              aksesPX.data ?? '';
                                          Get.snackbar('Error',
                                              '$errorMessage: $errorDetail',
                                              backgroundColor: Colors.redAccent,
                                              colorText: Colors.white);
                                        }
                                      } catch (e) {
                                        print('Error during login: $e');
                                        Get.snackbar('Gagal Login',
                                            'Terjadi kesalahan saat login',
                                            backgroundColor: Colors.redAccent,
                                            colorText: Colors.white);
                                      }
                                    } else {
                                      Get.snackbar('Gagal Login',
                                          'Username dan Password harus diisi',
                                          backgroundColor: Colors.redAccent,
                                          colorText: Colors.white);
                                    }

                                    setState(() {
                                      flag = !flag;
                                    });
                                  },
                                  color: MyColors.appPrimaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
