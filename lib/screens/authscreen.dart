import 'package:appjam_group13/database/firebase.dart';
import 'package:appjam_group13/screens/homescreen.dart';
import 'package:appjam_group13/widgets/flash_message.dart';
import 'package:appjam_group13/widgets/fonts.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_button/sign_button.dart';

class AuthScreenState extends StatelessWidget {
  const AuthScreenState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const AuthScreen();
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseOperations _firebaseOperations = FirebaseOperations();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  late bool loginPageController = false;
  late bool startLoginPageController = false;

  @override
  void dispose() {
    // Firebase işlemlerini temizle
    // _firebaseOperations.dispose();
    super.dispose();
  }

  final OutlineInputBorder _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: const BorderSide(color: Colors.grey),
  );

  Future<void> _signUpWithEmailAndPassword() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;
    String name = _nameController.text;

    // Password length validation
    if (password.length < 6) {
      showErrorSnackBar(context, "Şifre en az 6 karakter olmalıdır.");
      return;
    }

    // Password match validation
    if (password != confirmPassword) {
      showErrorSnackBar(context, "Şifreler eşleşmiyor. Lütfen tekrar deneyin.");
      return;
    }

    // Email and password are not empty
    if (email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty) {
      UserCredential? userCredential = await _firebaseOperations
          .signUpWithEmailAndPassword(email, password, name);
      if (userCredential != null && mounted) {
        // Check if the state is still mounted
        print("Kayıt başarılı: ${userCredential.user?.email}");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        // Show error message
        if (mounted) {
          // Check if the state is still mounted before showing the error message
          showErrorSnackBar(context, "Kayıt başarısız. Lütfen tekrar deneyin.");
        }
      }
    } else {
      // Show error message if email or password is empty
      if (mounted) {
        // Check if the state is still mounted before showing the error message
        showErrorSnackBar(context, "E-posta ve şifre gerekli");
      }
    }
  }

  Future<void> _signInEmailAndPassword() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    // E-posta ve şifre geçerli mi kontrol et
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        // Firebase kimlik doğrulaması
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Giriş başarılı, kullanıcıyı yönlendir veya gerekli işlemleri yap
        print("Giriş başarılı: ${userCredential.user?.email}");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } catch (e) {
        // Giriş başarısız, hata mesajını göster
        print("Giriş başarısız: $e");
        showErrorSnackBar(
            context, "Giriş başarısız. Lütfen bilgilerinizi kontrol edin.");
      }
    } else {
      // E-posta veya şifre boşsa hata mesajını göster
      showErrorSnackBar(context, "E-posta ve şifre gerekli");
    }
  }

  Future<void> _signInWithGoogle() async {
    bool result = await _firebaseOperations.signInWithGoogle();
    if (result) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      showErrorSnackBar(
          context, "Giriş başarısız oldu. Lütfen daha sonra tekrar deneyiniz");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: startLoginPageController
          ? loginPageController
              ? signUpScreen()
              : signInScreen()
          : startLoginPageScreen(),
    );
  }

  Container startLoginPageScreen() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/auth_page_photo.jpeg"),
          fit: BoxFit.cover, // Adjusted BoxFit to cover the entire screen
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 100, // Adjust as needed to position vertically
            left: 20, // Adjust as needed to position horizontally from the left
            right:
                20, // Adjust as needed to position horizontally from the right
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                Text(
                  "AppJam",
                  style:
                      fontStyle(40, const Color(0xFFDBFF00), FontWeight.bold),
                ),
                const Spacer(),
              ],
            ),
          ),
          Positioned(
            bottom: 100, // Adjust as needed to position vertically
            left: 20, // Adjust as needed to position horizontally from the left
            right:
                20, // Adjust as needed to position horizontally from the right
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF007AFF),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      onPressed: () {
                        print("Start App");
                        setState(() {
                          startLoginPageController = true;
                        });
                      },
                      child: Text(
                        "Start",
                        style: fontStyle(25, Colors.white, FontWeight.normal),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Center signInScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  "AppJam13",
                  style: fontStyle(25, Colors.black, FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "E-posta",
                  border: _border,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Şifre",
                  border: _border,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _signInEmailAndPassword,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text("Sign In"),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              const Row(
                children: [
                  Expanded(
                    child: Divider(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("or continue with"),
                  ),
                  Expanded(
                    child: Divider(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                      child: SignInButton(
                    buttonType: ButtonType.google,
                    buttonSize: ButtonSize.medium,
                    onPressed: _signInWithGoogle,
                  )),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account ? "),
                  TextButton(
                    onPressed: () {
                      print("Login In");
                      setState(() {
                        loginPageController = !loginPageController;
                      });
                    },
                    child: const Text("Sign Up"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Center signUpScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: const Text("AppJam13"),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  border: _border,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "E-posta",
                  border: _border,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Şifre",
                  border: _border,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  border: _border,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _signUpWithEmailAndPassword,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text("Sign Up"),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              const Row(
                children: [
                  Expanded(
                    child: Divider(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("or continue with"),
                  ),
                  Expanded(
                    child: Divider(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                      child: SignInButton(
                    buttonType: ButtonType.google,
                    buttonSize: ButtonSize.medium,
                    onPressed: _signInWithGoogle,
                  )),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account ? "),
                  TextButton(
                    onPressed: () {
                      print("Login In");
                      setState(() {
                        loginPageController = !loginPageController;
                      });
                    },
                    child: const Text("Sign In"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
