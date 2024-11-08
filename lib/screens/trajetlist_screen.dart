import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projet_covoiturage/screens/home.dart';
import 'map_screen.dart'; // Assurez-vous d'importer votre MapScreen

class TrajetListScreen extends StatefulWidget {
  const TrajetListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TrajetListScreenState createState() => _TrajetListScreenState();
}

class _TrajetListScreenState extends State<TrajetListScreen> {
  int _selectedIndex = 1;  // Le TrajetListScreen est l'index 1 dans la navigation

  static final List<Widget> _screens = [
    const HomeScreen(),  // Redirige vers l'écran Home
    const TrajetListScreen(),  // Redirige vers TrajetListScreen
    const Placeholder(),
    const Placeholder(),
    const Placeholder(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Naviguer vers l'écran approprié selon l'index sélectionné
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TrajetListScreen()),
      );
    } else if (index == 2) {
    } else if (index == 3) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 90, 164, 165), 
        title: const Text(
          'Liste des Trajets',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('trajets')
            .orderBy('timestamp', descending: true) 
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Aucun trajet trouvé.'));
          }

          final trajets = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: trajets.length,
            itemBuilder: (context, index) {
              final trajet = trajets[index];
              final departureCity = trajet['departureCity'];
              final arrivalCity = trajet['arrivalCity'];
              final timestamp = trajet['timestamp'].toDate();
              final formattedDate = '${timestamp.day}/${timestamp.month}/${timestamp.year}';

              return Card(
                elevation: 4.0,
                shadowColor: const Color.fromARGB(255, 90, 164, 165), // Ombre avec la couleur spécifique
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  leading: const Icon(
                    Icons.directions_car,
                    color: Color.fromARGB(255, 90, 164, 165),
                    size: 40.0,
                  ),
                  title: Text(
                    '$departureCity -> $arrivalCity',
                    style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Date: $formattedDate',
                    style: const TextStyle(color: Colors.grey, fontSize: 14.0),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Color.fromARGB(255, 90, 164, 165),
                  ),
                  onTap: () {
                    // Ajouter une action si nécessaire, comme voir les détails du trajet
                  },
                ),
              );
            },
          );
        },
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