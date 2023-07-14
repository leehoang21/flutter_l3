import 'package:flutter/cupertino.dart';
import 'package:timesheet/utils/images.dart';

class HomeScreenSection0 extends StatefulWidget {
  const HomeScreenSection0({Key? key}) : super(key: key);

  @override
  State<HomeScreenSection0> createState() => _HomeScreenSection0State();
}

class _HomeScreenSection0State extends State<HomeScreenSection0> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 60, 0, 20),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Images.background_sign_in),
                    fit: BoxFit.fill)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Find Your\nFavorite Food",
                    style: TextStyle(fontSize: 31, fontWeight: FontWeight.bold)),
                Image.asset(Images.icon_notification)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
