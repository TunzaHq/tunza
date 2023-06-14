import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tunza/ui/auth/sign_in.dart';
import 'package:tunza/util/file_path.dart';

class Success extends StatefulWidget {
  const Success({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerLeft,
                child: SvgPicture.asset(mainBanner),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _centerContent(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _centerContent() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SvgPicture.asset(logo),
          const SizedBox(
            height: 18,
          ),
          Text(
            'Welcome to Tunza!',
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(
            height: 18,
          ),
          const SizedBox(
            height: 18,
          ),
          SizedBox(
            width: double.infinity,
            child: MaterialButton(
              elevation: 0,
              color: const Color(0xFFFFAC30),
              height: 50,
              minWidth: 200,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              onPressed: () async {
                await Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => const SignIn()));
              },
              child: Text(
                'Sign In',
                style: Theme.of(context).textTheme.button,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
