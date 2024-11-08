import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projet_covoiturage/screens/home.dart';
import 'package:projet_covoiturage/screens/map_screen.dart';
import 'package:projet_covoiturage/screens/prix_screen.dart';
import 'package:projet_covoiturage/screens/trajetlist_screen.dart';

class DateDepartScreen extends StatefulWidget {
  const DateDepartScreen({super.key});

  @override
  _DateDepartScreenState createState() => _DateDepartScreenState();
}

class _DateDepartScreenState extends State<DateDepartScreen> {
  DateTime _selectedDate = DateTime.now();
  int _selectedIndex = 0;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
 if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TrajetListScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd MMMM yyyy').format(_selectedDate);

    return Scaffold(
      
      appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 242, 236, 244),


        title: const Text('Date de départ'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Quand voulez-vous partir ?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(width: 2),
                ),
                child: Text(
                  formattedDate,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PrixScreen()),
    );
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Color.fromARGB(255, 143, 193, 194),
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    ),
    elevation: 5,
  ),
  child: const Text(
    'Suivant',
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  ),
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
