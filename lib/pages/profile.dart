import 'dart:io'; // Import for exit(0)
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicallim_test/widgets/app_colors.dart'; // Import reusable color widget
import 'package:musicallim_test/services/database_service.dart'; // Import DatabaseService
import 'package:musicallim_test/models/user_model.dart'; // Import UserModel
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var userName = "Guest".obs; // Make username reactive using .obs
  final DatabaseService _databaseService =
      DatabaseService(); // Instance of DatabaseService

  @override
  void initState() {
    super.initState();
    _loadUserName(); // Load username from database when the page loads
  }

  // Function to load the username from the database
  Future<void> _loadUserName() async {
    UserModel? user = await _databaseService.getUser();
    if (user != null) {
      userName.value = user.name; // Set the username from the database
    }
  }

  // Function to handle editing the profile name
  void _editProfile() {
    TextEditingController nameController =
        TextEditingController(text: userName.value);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Enter your name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                userName.value =
                    nameController.text; // Update username reactively
                await _saveUserName(userName
                    .value); // Save the updated username to the database
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Function to save the username to the database
  Future<void> _saveUserName(String name) async {
    UserModel? existingUser = await _databaseService.getUser();

    if (existingUser != null) {
      // Update existing user
      existingUser.name = name;
      await _databaseService.updateUser(existingUser);
    } else {
      // Create new user if none exists
      UserModel newUser = UserModel(name: name);
      await _databaseService.addUser(newUser);
    }
  }

  // Function to handle logout
  void _logout() {
    exit(0); // Close the application
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // Set background color
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold, // Tebal seperti font Spotify
            fontSize: 24, // Ukuran font
          ),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  'https://w7.pngwing.com/pngs/24/650/png-transparent-computer-icons-service-avatar-user-guest-house-gaulish-language-purple-service-logo.png', // URL gambar profil
                ),
              ),
            ),
            const SizedBox(height: 16),

            // User Name (wrapped in Obx for reactivity)
            Obx(() => Text(
                  userName.value, // Display dynamic username reactively
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary, // Set text color
                  ),
                )),
            const SizedBox(height: 8),

            // Divider
            const Divider(
              height: 20,
              thickness: 2,
              indent: 20,
              endIndent: 20,
              color: AppColors.cardBackground, // Set divider color
            ),
            const SizedBox(height: 16),

            // Edit Profile Button
            ListTile(
              leading: const Icon(Icons.edit,
                  color: AppColors.iconColor), // Set icon color
              title: const Text(
                'Edit Profile',
                style:
                    TextStyle(color: AppColors.textPrimary), // Set text color
              ),
              onTap: _editProfile, // Trigger edit profile logic
            ),
            // Logout Button
            ListTile(
              leading: const Icon(Icons.logout,
                  color: AppColors.iconColor), // Set icon color
              title: const Text(
                'Exit',
                style:
                    TextStyle(color: AppColors.textPrimary), // Set text color
              ),
              onTap: _logout, // Trigger logout logic
            ),
          ],
        ),
      ),
    );
  }
}
