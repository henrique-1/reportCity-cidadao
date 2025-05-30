import 'package:cidadao/views/home_notifications.dart';
import 'package:cidadao/views/home_profile.dart';
import 'package:cidadao/views/home_report.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// TODO: Ideally, these colors should come from a centralized Theme file (e.g., main.dart or a dedicated theme.dart)
// For now, defining them here for localized consistency.
const Color _appBackgroundColor = Color(0xFFEFEFEF);
const Color _navigationBarColor = Color(0xFFF6F6F6);
const Color _navigationIndicatorColor = Color(0xFFCEE4D2); // Light green, might be accent or primary variant
const Color _primaryTextColor = Color(0xFF2E4D34); // Dark green, might be primary or onAccent/onPrimaryVariant

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: _appBackgroundColor,
      bottomNavigationBar: NavigationBar(
        backgroundColor: _navigationBarColor,
        onDestinationSelected: (int index) {
          setState(
            () {
              currentPageIndex = index;
            },
          );
        },
        selectedIndex: currentPageIndex,
        indicatorColor: _navigationIndicatorColor,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon:
                Icon(Icons.notifications_sharp, color: _primaryTextColor),
            icon: Icon(Icons.notifications_outlined),
            label: 'Notificações',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.home, color: _primaryTextColor),
            icon: Icon(Icons.home_outlined),
            label: 'Feed',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person, color: _primaryTextColor),
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
        ],
      ),
      body: const <Widget>[
        HomeNotifications(),
        HomeReport(),
        HomeProfile(),
      ][currentPageIndex],
      floatingActionButton: Visibility(
        visible: currentPageIndex == 1, // FAB is visible only on the 'Feed' screen (index 1)
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, "/report");
          },
          backgroundColor: _navigationIndicatorColor, // Or another appropriate theme color
          label: Text(
            "Denunciar",
            style: GoogleFonts.inter(
                fontSize: 16.sp,
                color: _primaryTextColor,
                fontWeight: FontWeight.w600),
          ),
          icon: const Icon(
            Icons.warning,
            color: _primaryTextColor,
          ),
        ),
      ),
    );
  }
}
