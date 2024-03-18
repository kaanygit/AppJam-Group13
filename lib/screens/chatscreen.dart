import 'dart:io';
import 'package:GezginAt/database/firebase.dart';
import 'package:GezginAt/services/gemini.dart';
import 'package:GezginAt/widgets/fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _chatTextBoxController = TextEditingController();
  bool _isLoadingGeminiChat = false;
  final Gemini _gemini = Gemini();
  List<String> _responseGemini = [];
  List<String> _responseUser = [];
  List<String> _allResponse = [];
  String? _returnResponse = "";
  String? _sendResponse = "";
  bool isGeminiVisible = true;
  String? currentUserPhoto;

  Map<String, dynamic> userProfile = {};

  bool _imageSet = false;
  late File _image;
  final picker = ImagePicker();

  @override
  void initState() {
    _image = File('');
    super.initState();
    _initializeUserProfile();
    _responseUser = [];
    _responseGemini = [];
    _allResponse = [];
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print("Kullanıcı bulunamadı");
      } else {
        setState(() {
          currentUserPhoto = user.photoURL ?? '';
          print(currentUserPhoto);
        });
      }
    });
  }

  @override
  void dispose() {
    _chatTextBoxController.dispose();
    super.dispose();
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print("resim seçildi");
        _imageSet = true;
        print(_image);
      }
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print("resim çekildi");
        _imageSet = true;
        print(_image);
      }
    });
  }

  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text('Photo Gallery'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _initializeUserProfile() async {
    userProfile = await FirebaseOperations().getProfileBio();
    print(userProfile);

    _responseUser = [];

    // State değişikliklerini tetikle
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          if (isGeminiVisible)
            Positioned(
              top: MediaQuery.of(context).size.height / 2 - 150,
              right: 0,
              left: 0,
              child: Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      'Powered by',
                      style: fontStyle(
                          15, Colors.blue.shade400, FontWeight.normal),
                    ),
                    Image.asset(
                      'assets/images/gemini_logo.png',
                      width: 100,
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  reverse: true,
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < _allResponse.length; i++)
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(25)),
                                child: Row(
                                  children: [
                                    Container(
                                      child: i % 2 == 0
                                          ? currentUserPhoto != null &&
                                                  currentUserPhoto != ""
                                              ? ClipOval(
                                                  child: Image.network(
                                                    "$currentUserPhoto",
                                                    width: 50,
                                                    height: 50,
                                                  ),
                                                )
                                              : ClipOval(
                                                  child: Image.asset(
                                                    "assets/images/placeholder.png",
                                                    width: 50,
                                                    height: 50,
                                                  ),
                                                )
                                          : ClipOval(
                                              child: Image.asset(
                                                "assets/images/gemini_logo.png",
                                                width: 50,
                                                height: 50,
                                              ),
                                            ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Text(
                                        _responseUser[i],
                                        style: fontStyle(
                                          14,
                                          Colors.black,
                                          FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              // Alt kısım (Input ve diğer widget'lar)
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _chatTextBoxController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 16,
                              ),
                              fillColor: Colors.grey.shade200,
                              filled: true,
                              hintText: "Bana bir yer önerir misin?",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            enabled: !_isLoadingGeminiChat,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        if (!_imageSet)
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.amber,
                                border: Border.all(
                                    color: Colors.white, width: 0.5)),
                            child: InkWell(
                              onTap: () {
                                print("Rs");
                                showOptions();
                              },
                              child: Center(
                                child: FaIcon(
                                  FontAwesomeIcons.images,
                                  size: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        else
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                                border: Border.all(
                                    color: Colors.white, width: 0.5)),
                            child: InkWell(
                              onTap: () {
                                print("Rs");
                                showOptions();
                              },
                              child: Center(
                                child: FaIcon(
                                  FontAwesomeIcons.check,
                                  size: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        SizedBox(
                          width: 2,
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.amberAccent,
                            border: Border.all(
                              color: Colors.white,
                              width: 0.5,
                            ),
                          ),
                          child: InkWell(
                            onTap: () async {
                              setState(() {
                                _isLoadingGeminiChat = true;
                                _sendResponse =
                                    _chatTextBoxController.text.trim();
                                _responseUser.add(_sendResponse!);
                                _allResponse.add(_sendResponse!);
                                isGeminiVisible = false;
                              });

                              final String text =
                                  _chatTextBoxController.text.trim();
                              // _returnResponse = (_imageSet
                              //     ? await _gemini.geminiTextPrompt(text)
                              //     : await _gemini.geminImageAndTextPrompt(
                              //         (text), _image.path))!;
                              var response;

                              // if (!_imageSet) {
                              //   response = await _gemini.geminiTextPrompt(text);
                              // } else {
                              //   if (_image != null &&
                              //       _image.path != null &&
                              //       _image.path.isNotEmpty) {
                              //     print("Burası açlıyor");
                              //     response =
                              //         await _gemini.geminImageAndTextPrompt(
                              //             text, _image.path);
                              //   } else {
                              //     // Handle the case where _image or _image.path is null or empty
                              //     // You might want to log a warning, provide a default response, or take other appropriate actions.
                              //     response =
                              //         'Default response'; // Change this line based on your requirements
                              //   }
                              // }
                              if (!_imageSet) {
                                response = await _gemini.geminiTextPrompt(text);
                              } else {
                                if (_image != null &&
                                    _image.path != null &&
                                    _image.path.isNotEmpty) {
                                  print("Burası çalışıyor");
                                  response =
                                      await _gemini.geminImageAndTextPrompt(
                                          text, _image.path);
                                } else {
                                  // Handle the case where _image or _image.path is null or empty
                                  // You might want to log a warning, provide a default response, or take other appropriate actions.
                                  response =
                                      'Default response'; // Change this line based on your requirements
                                }
                              }

                              _returnResponse = response;
                              _responseGemini.add(_returnResponse!);

                              setState(() {
                                _isLoadingGeminiChat = false;
                                _responseUser.add(_returnResponse!);
                                _allResponse.add(_returnResponse!);
                                _chatTextBoxController.clear();
                                _chatTextBoxController.text = "";
                                FirebaseOperations()
                                    .setGeminiChat(_allResponse);
                                _imageSet = false;
                                _chatTextBoxController.selection =
                                    TextSelection.fromPosition(
                                  TextPosition(offset: 0),
                                );
                              });
                            },
                            child: FaIcon(
                              FontAwesomeIcons.arrowUp,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
