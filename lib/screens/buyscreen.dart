import 'package:GezginAt/database/firebase.dart';
import 'package:GezginAt/screens/homescreen.dart';
import 'package:GezginAt/widgets/flash_message.dart';
import 'package:GezginAt/widgets/fonts.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuyScreen extends StatelessWidget {
  final int travelId;
  const BuyScreen({Key? key, required this.travelId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BuyDetailScreen(travelId: travelId),
    );
  }
}

class BuyDetailScreen extends StatefulWidget {
  final int travelId;

  const BuyDetailScreen({Key? key, required this.travelId}) : super(key: key);

  @override
  State<BuyDetailScreen> createState() => _BuyDetailScreenState();
}

class _BuyDetailScreenState extends State<BuyDetailScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: PageView.builder(
        controller: _pageController,
        itemBuilder: (context, index) {
          if (index == 0) {
            return FirstScreen();
          } else if (index == 1) {
            return SecondScreen(
              travelId: widget.travelId,
            );
          } else {
            return ThirdScreen(travelId: widget.travelId);
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text(
                    "Geri", // Buton metni
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SecondScreen(
                        travelId: widget.travelId,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "Satın Al", // Buton metni
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          print("Geri düğmesine basıldı");
          Navigator.pop(context);
        },
        child: Container(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      title: Text("Satın alma"),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Rezervasyon Adı",
                border: _border,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Kimlik Numarası",
                border: _border,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Kişi Sayısı",
                border: _border,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "E-posta",
                border: _border,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final OutlineInputBorder _border = OutlineInputBorder(
  borderRadius: BorderRadius.circular(12.0),
  borderSide: const BorderSide(color: Colors.grey),
);

class SecondScreen extends StatefulWidget {
  final int travelId;
  const SecondScreen({Key, key, required this.travelId}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  int _selectedIndex = -1; // Başlangıçta herhangi bir seçim yok
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            print("Geri düğmesine basıldı");
            Navigator.pop(context);
          },
          child: Container(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        title: Text("Satın alma"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildPaymentMethodContainer(
                imagePath: "assets/images/mastercard.png",
                text: "Kredi Kartı",
                index: 0,
              ),
              SizedBox(height: 30),
              buildPaymentMethodContainer(
                imagePath: "assets/images/apple.png",
                text: "Apple Pay",
                index: 1,
              ),
              SizedBox(height: 30),
              buildPaymentMethodContainer(
                imagePath: "assets/images/paypal.png",
                text: "Paypal",
                index: 2,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text(
                    "Geri", // Buton metni
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_selectedIndex != -1) {
                    print("Seçilen ödeme yöntemi: $_selectedIndex");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ThirdScreen(travelId: widget.travelId),
                      ),
                    );
                    // Ödeme yöntemi seçildiğinde işlemleri yapabilirsiniz
                  } else {
                    print("Lütfen bir ödeme yöntemi seçin");
                    showErrorSnackBar(context, "Lütfen Ödeme Yöntemi Seçiniz");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "Satın Al", // Buton metni
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPaymentMethodContainer({
    required String imagePath,
    required String text,
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // Seçilen ödeme yönteminin indeksini güncelle
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(width: 2.0, color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(20),
          color: _selectedIndex == index ? Colors.grey.shade200 : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  imagePath,
                  width: 50,
                  height: 50,
                ),
                SizedBox(width: 8),
                Text(
                  text,
                  style: fontStyle(16, Colors.black, FontWeight.bold),
                ),
              ],
            ),
            if (_selectedIndex == index)
              Icon(
                Icons.verified,
                color: Colors.green,
              ),
          ],
        ),
      ),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  final int travelId;

  const ThirdScreen({Key? key, required this.travelId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            print("Geri düğmesine basıldı");
            Navigator.pop(context);
          },
          child: Container(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        title: Text("Satın alma"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border:
                        Border.all(width: 2.0, color: Colors.grey.shade500)),
                child: Image.asset(
                  "assets/images/creditcard.png",
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Kart Numarası",
                  border: _border,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Ay",
                  border: _border,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Yıl",
                  border: _border,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "CVC",
                  border: _border,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text(
                    "Geri", // Buton metni
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  FirebaseOperations().orderTravelData(travelId);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SuccessScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "Satın Al", // Buton metni
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
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

class SuccessScreen extends StatefulWidget {
  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  late ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 30));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      "Alışveriş \nTamamlandı",
                      style: fontStyle(30, Colors.black, FontWeight.bold),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Seyahate çıkma zamanı gelene kadar her şeyi hazırlayın!",
                      style: fontStyle(
                          25, Colors.grey.shade700, FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _controller,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ], // Konfeti renkleri
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text(
                    "Yeni Yerler Keşfet !", // Buton metni
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
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
