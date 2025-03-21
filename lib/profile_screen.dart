import 'package:flutter/material.dart';
// import 'package:notes_app/services/auth_provider.dart';
import 'package:provider/provider.dart';

import 'AuthProvider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Email: ${user?.email ?? ''}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await authProvider.logout();
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Text("Logout"),
            )
          ],
        ),
      ),
    );
  }
}
