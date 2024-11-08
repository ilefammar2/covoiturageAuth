import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_covoiturage/screens/date_depart.dart';
import 'package:projet_covoiturage/screens/home.dart';
import 'package:projet_covoiturage/screens/map_screen.dart';
import 'package:projet_covoiturage/screens/trajetlist_screen.dart';

class PrixScreen extends StatefulWidget {
  const PrixScreen({super.key});

  @override
  _PrixScreenState createState() => _PrixScreenState();
}

class _PrixScreenState extends State<PrixScreen> {
  int _selectedIndex = 0;
  final TextEditingController _priceController = TextEditingController(text: "0");
  String _displayedPrice = "0"; // Variable to hold the displayed price

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Handle navigation based on selected index
    if (index == 0) {
      // Navigate to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else if (index == 1) {
      // Navigate to TrajetListScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TrajetListScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 242, 236, 244),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Prix Par Personne',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _priceController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _displayedPrice = value.isNotEmpty ? value : "0";
                });
              },
            ),
            const SizedBox(height: 20),
            Text(
              '$_displayedPrice DNT',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavBarItem(Icons.home, 0),
                        buildNavBarItem(Icons.assignment, 1),

                          const SizedBox(width: 10),
            buildNavBarItem(Icons.history, 2),
            buildNavBarItem(Icons.directions_car, 3),
            ],
          ),
        ),
      ),
      floatingActionButton: ClipOval(
        child: Material(
          color: const Color.fromARGB(255, 13, 17, 50),
          elevation: 10,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MapScreen()),
              );
            },
            child: const SizedBox(
              width: 48,
              height: 48,
              child: Icon(
                CupertinoIcons.add_circled,
                size: 28,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildNavBarItem(IconData icon, int index) {
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: _selectedIndex == index
                ? const Color.fromARGB(255, 90, 164, 165)
                : const Color.fromARGB(255, 13, 17, 50),
          ),
        ],
      ),
    );
  }
}