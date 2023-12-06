import 'package:flutter/material.dart';

void main() {
  runApp(GameStore());
}

class GameStore extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: firstPage(),
    );
  }
}
class firstPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
            'Game List',
            style: TextStyle(
            color: Colors.black,
            fontFamily: 'Merriweather',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          gameWidget('Marvels Spider-Man 2','img1.jpeg','Spider-Man 2 from Insomniac Games launched at the end of October and '
              'quickly became one of the best-selling game of 2023.','USD.399'),
          gameWidget('Elden Ring','img2.jpg','Elden Ring released all the way back in February 2022, and its still doing well, '
              'being a top seller for 2023 thus far','USD.349'),
          gameWidget('EA 24','FC24.jpg','EA SPORTS FC™ 24 welcomes you to the most true-to-football experience'
              ' with HyperMotionV, PlayStyles optimized by Opta, and a revolutionized Frostbite™ Engine.','USD.449'),
          gameWidget('Minecraft Java Edition','mcraft.png','Minecraft is a game made up of blocks, creatures, and community.'
              ' You can survive the night or build a work of art – the choice is all yours.','USD.259'),
          gameWidget('COD Warzone','cod.jpg','A massive combat experience with up to 150 players from the world of Call of Duty:'
              ' Modern Warfare, free-to-play for everyone.','USD.259'),
          gameWidget('PUBG PC','pubg.jpg','PUBG is a pvp shooter game in which up to one hundred players fight in a battle royale,'
              ' where players fight to remain the last alive.','USD.299'),
          gameWidget('GTA VI','gta6.jpg','Grand Theft Auto VI is an action-adventure game set in the fictional open world state of Leonida—based on'
              ' Florida—which includes Vice City, a fictional version of Miami.','USD.799'),
          gameWidget('Forza Horizon','forza.jpg','Forza Horizon focuses specifically on casual street racing, rather than professionally on race tracks,'
              ,'USD.359'),
        ],
      ),
    );

  }
}

class gameWidget extends StatelessWidget {
  String gameName;
  String imageName;
  String description;
  String price;

  gameWidget(this.gameName, this.imageName, this.description, this.price);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      child: Column(
        children: [
          ListTile(
            leading: Image.asset(
              'assets/images/$imageName',
              width: 100.0, // Adjust the width as needed
              height: 100.0, // Adjust the height as needed
            ),
            title: Text(
              gameName,
              style: TextStyle(fontSize: 25, fontFamily: 'Merriweather',color: Colors.amber),
            ),
            subtitle: Text(
              description,
              style: TextStyle(fontSize: 15, fontFamily: 'Merriweather',color: Colors.white),
            ),
          ),
          ListTile(
            title: Text(
              'Price: $price',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'Merriweather',color: Colors.white),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondPage(gameName, imageName, description, price)),
              );
            },
            icon: Icon(Icons.shopping_cart),
            label: Text(
                'Buy Now',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.amber),
            ),
          ),
        ],
      ),
    );
  }
}
class SecondPage extends StatefulWidget {
  String gameName;
  String imageName;
  String description;
  String price;

  SecondPage(this.gameName, this.imageName, this.description, this.price);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  String? selectedOption;
  List<String> paymentOptions = ['Credit Card', 'PayPal', 'Google Pay']; // Add more options as needed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Buy Now Page',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Merriweather',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${widget.gameName}\n', style: TextStyle(fontSize: 20, fontFamily: 'Merriweather',color: Colors.amber)),
            Image.asset('assets/images/${widget.imageName}'),

            Text('\nShort Description:\n${widget.description}',style: TextStyle(fontSize: 15, fontFamily: 'Merriweather',color: Colors.white)),
            Text('\nPrice: \$${widget.price}', style: TextStyle(fontSize: 15, fontFamily: 'Merriweather',color: Colors.white)),
            DropdownButton<String>(
              items: ['X-BOX', 'PS5', 'PC'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedOption = newValue!;
                });
              },
              value: selectedOption,
              hint: Text(
                'Select platform',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16.0), // Add spacing between dropdown and payment options
            Text(
              'Choose Payment Method:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Row(
              children: [
                PaymentOption('assets/images/bkash.png', 'BKash'),
                PaymentOption('assets/images/nagad.png', 'Nagad'),
                PaymentOption('assets/images/rocket.png', 'Rocket'),
                PaymentOption('assets/images/mastercard.png', 'M.Card'),
                PaymentOption('assets/images/img3.png', 'AmEx'),
                // Add more payment options as needed
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // You can use the selectedOption here or perform any other action
                Navigator.pop(context);
              },
              child: Text(
                'Go Back',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.amber),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentOption extends StatelessWidget {
  final String imagePath;
  final String optionName;

  PaymentOption(this.imagePath, this.optionName);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 50.0,
            height: 50.0,
          ),
          SizedBox(height: 8.0),
          Text(
            optionName,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
