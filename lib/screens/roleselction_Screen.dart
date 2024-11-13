

// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet_covoiturage/constants.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sélectionner un rôle")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              User? user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                // Mise à jour du rôle dans Firestore
                await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
                  'role': 'conducteur',
                });
                // ignore: use_build_context_synchronously
                Navigator.pushReplacementNamed(context, Constants.homeRoute); // Redirection vers la page du conducteur
              }
            },
            child: const Text("Conducteur"),
          ),
          ElevatedButton(
            onPressed: () async {
              User? user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                // Mise à jour du rôle dans Firestore
                await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
                  'role': 'passager',
                });
              }
            },
            child: const Text("Passager"),
          ),
        ],
      ),
    );
  }
}
