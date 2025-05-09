import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drive_safe/Pages/history/history_page.dart';
import 'package:drive_safe/Pages/home/widgets/home_appbar.dart';
import 'package:drive_safe/Pages/home/widgets/home_body.dart';
import 'package:drive_safe/Pages/setting/setting_page.dart';
import 'package:drive_safe/apps/theme/theme.dart';
import 'package:drive_safe/apps/theme/providers/theme_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  String _displayName = 'Người dùng';
  @override
  void initState() {
    super.initState();
    _loadDisplayName();
  }
  Future<void> _loadDisplayName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (doc.exists) {
        setState(() {
          _displayName = doc['displayName'] ?? 'Người dùng';
        });
      }
    }
  }
  final List<Widget> _screens = [
    const HistoryPage(),
    const HomeBody(),
    const SettingPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final backgroundGradient = themeProvider.backgroundGradient;

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: HomeAppbar(displayName: _displayName)
,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: backgroundGradient,
            ),
          ),
          SafeArea(
            child: _screens[_selectedIndex],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: isDarkMode ? MyColor.white : MyColor.blueDark, 
        unselectedItemColor: isDarkMode ? MyColor.grey : MyColor.black, 
        backgroundColor: isDarkMode ? MyColor.darkBackground : MyColor.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Lịch sử'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Cài đặt'),
        ],
      ),
    );
  }
}