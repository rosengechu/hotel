import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hotel/presentation/home/widgets/text_widget.dart';
import 'package:provider/provider.dart';
import 'package:hotel/providers/auth_provider.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:hotel/domain/models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}); // Corrected key parameter syntax
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    final UserModel? user = authProvider.user;
    //debugPrint('${user!.email} is the user\'s name from the profile screen');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Hello  ',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 212, 0, 177),
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                  children: <TextSpan>[
                    if (user != null && user.displayName != null) // Check if user and displayName is not null
                      TextSpan(
                        text: user.displayName!,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 212, 0, 177),
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('My name is pressed');
                          },
                      )
                    else
                      TextSpan(
                        text: 'Guest',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 212, 0, 177),
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextWidget(
                text: user?.email ?? 'guest@example.com', // Default email if user is null
                color: Colors.cyan,
                textSize: 18,
                // isTitle: true,
              ),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(
                height: 20,
              ),
              _listTiles(
                title: 'Address 2',
                subtitle: 'My subtitle',
                icon: IconlyLight.profile,
                onPressed: () {},
                color: Colors.cyan,
              ),
              _listTiles(
                title: 'Bookings',
                icon: IconlyLight.bag,
                onPressed: () {},
                color: Colors.cyan,
              ),
              _listTiles(
                title: 'Viewed',
                icon: IconlyLight.show,
                onPressed: () {},
                color: Colors.cyan,
              ),
              _listTiles(
                title: 'Forget password',
                icon: IconlyLight.unlock,
                onPressed: () {},
                color: Colors.cyan,
              ),
              _listTiles(
                title: 'Logout',
                icon: IconlyLight.logout,
                onPressed: () {
                  authProvider.signOut(context);
                },
                color: Colors.cyan,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listTiles({
    required String title,
    String? subtitle,
    required IconData icon,
    required Function onPressed,
    required Color color,
  }) {
    return ListTile(
      title: TextWidget(
        text: title,
        color: color,
        textSize: 22,
        // isTitle: true,
      ),
      subtitle: TextWidget(
        text: subtitle ?? "",
        color: color,
        textSize: 18,
      ),
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrowRight2),
      onTap: () {
        onPressed();
      },
    );
  }
}
