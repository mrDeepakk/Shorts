import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shorts/controllers/auth_controller.dart';
import 'package:shorts/views/screens/add_vidor_screen.dart';
import 'package:shorts/views/screens/profile_screen.dart';
import 'package:shorts/views/screens/search_screen.dart';
import 'package:shorts/views/screens/video_screen.dart';

const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;
// pages for BottomNavigationBar
List pages = [
  VideoScreen(),
  SearchScreen(),
  AddVideo(),
  Text("messages screen"),
  ProfileScreen(uid: authController.user.uid),
];
// firebase constant
var firebaseauth = FirebaseAuth.instance;
var firebasestorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

var authController = AuthController.instance;
