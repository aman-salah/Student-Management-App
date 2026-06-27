import 'package:flutter/material.dart';
import 'package:frontend/features/profile/providers/profile_provider.dart';
import 'package:frontend/features/profile/view/widgets/profile_info_card.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    Future.microtask(() {
      context.read<ProfileProvider>().getProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F8),
      appBar: AppBar(
        //leading: Padding(padding: EdgeInsetsGeometry.all(8)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none, color: Color(0xff4F46E5)),
          ),
        ],
        backgroundColor: const Color(0xFFF0F0F8),
        title: Text(
          'P R O F I L E',
          style: TextStyle(
            color: Color(0xff4F46E5),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                child: Icon(size: 50, Icons.person),
              ),
              SizedBox(height: 25),
              ProfileInfoCard(
                info: profileProvider.profile?.username ?? 'unknown',
              ),
              SizedBox(height: 10),
              ProfileInfoCard(
                info: profileProvider.profile?.email ?? 'unknown@gmail.com',
              ),
              SizedBox(height: 10),
              ProfileInfoCard(
                info: profileProvider.profile?.role ?? 'unknown role',
              ),
              SizedBox(height: 10),
              ProfileInfoCard(
                info:
                    profileProvider.profile?.department ?? 'unknown department',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
