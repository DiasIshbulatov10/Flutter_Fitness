import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_flutter/core/const/color_constants.dart';
import 'package:fitness_flutter/core/const/path_constants.dart';
import 'package:fitness_flutter/core/const/text_constants.dart';
import 'package:fitness_flutter/screens/settings/bloc/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildContext(context));
  }

  BlocProvider<SettingsBloc> _buildContext(BuildContext context) {
    return BlocProvider<SettingsBloc>(
      create: (context) => SettingsBloc(),
      child: BlocConsumer<SettingsBloc, SettingsState>(
        buildWhen: (_, currState) => currState is SettingsInitial,
        builder: (context, state) {
          return _settingsContent();
        },
        listenWhen: (_, currState) => true,
        listener: (context, state) {},
      ),
    );
  }

  Widget _settingsContent() {
    final User? user = FirebaseAuth.instance.currentUser;
    final displayName = user?.displayName ?? "No Username";
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Column(children: [
            Stack(alignment: Alignment.topRight, children: [
              Center(child: Image(image: AssetImage(PathConstants.profile), height: 120, fit: BoxFit.fitHeight)),
              TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(shape: CircleBorder(), backgroundColor: ColorConstants.primaryColor.withOpacity(0.16)),
                  child: Icon(Icons.edit, color: ColorConstants.primaryColor)),
            ]),
            SizedBox(height: 15),
            Text(displayName, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(TextConstants.joinUs),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () => launch('https://www.facebook.com/perpetio/'),
                    style: TextButton.styleFrom(shape: CircleBorder(), backgroundColor: Colors.white, elevation: 1),
                    child: Image.asset(PathConstants.facebook)),
                TextButton(
                    onPressed: () => launch('https://www.instagram.com/perpetio/'),
                    style: TextButton.styleFrom(shape: CircleBorder(), backgroundColor: Colors.white, elevation: 1),
                    child: Image.asset(PathConstants.instagram)),
                TextButton(
                    onPressed: () => launch('https://twitter.com/perpetio'),
                    style: TextButton.styleFrom(shape: CircleBorder(), backgroundColor: Colors.white, elevation: 1),
                    child: Image.asset(PathConstants.twitter)),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
