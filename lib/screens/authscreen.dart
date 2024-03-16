import 'package:appjam_group13/database/firebase.dart';
import 'package:appjam_group13/screens/homescreen.dart';
import 'package:appjam_group13/widgets/flash_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:sign_button/sign_button.dart';

class AuthScreenState extends StatelessWidget {
  const AuthScreenState({Key? key});

  @override
  Widget build(BuildContext context) {
    return AuthScreen();
  }
}

class AuthScreen extends StatefulWidget {
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

  OutlineInputBorder _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: BorderSide(color: Colors.grey),
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
      body: loginPageController ? signUpScreen() : signInScreen(),
    );
  }

  Center signInScreen() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Text("AppJam13"),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "E-posta",
                  border: _border,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Şifre",
                  border: _border,
                ),
              ),
              SizedBox(height: 24),
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
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text("Sign In"),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("or continue with"),
                  ),
                  Expanded(
                    child: Divider(),
                  ),
                ],
              ),
              SizedBox(height: 16),
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
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account ? "),
                  TextButton(
                    onPressed: () {
                      print("Login In");
                      setState(() {
                        loginPageController = !loginPageController;
                      });
                    },
                    child: Text("Sign Up"),
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
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Text("AppJam13"),
              ),
              SizedBox(height: 24),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  border: _border,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "E-posta",
                  border: _border,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Şifre",
                  border: _border,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  border: _border,
                ),
              ),
              SizedBox(height: 24),
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
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text("Sign Up"),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("or continue with"),
                  ),
                  Expanded(
                    child: Divider(),
                  ),
                ],
              ),
              SizedBox(height: 16),
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
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account ? "),
                  TextButton(
                    onPressed: () {
                      print("Login In");
                      setState(() {
                        loginPageController = !loginPageController;
                      });
                    },
                    child: Text("Sign In"),
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
