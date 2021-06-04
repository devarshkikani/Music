import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audioplayers_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:radio/models/radio.dart';
import 'package:radio/utils/ai_utils.dart';

class HomeController extends GetxController {
  List<MyRadio>? radios;
  MyRadio? selectedRadio;
  Color fSelectedColor = AIColor.primaryColor2;
  Color sSelectedColor = AIColor.primaryColor1;
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();
  RxBool isPlaying = false.obs;
  Duration position = Duration();
  Duration musicLength = Duration();

  final suggestion = [
    'Romantic',
    'Hip Hop',
    'Some sad',
    'Rap Song',
    'Album',
    'English Hits'
  ];

  fetchRadios() async {
    final radioJson = await rootBundle.loadString("assets/radio.json");
    print(radioJson);
    radios = MyRadioList.fromJson(radioJson).radios;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchRadios();

    audioPlayer.onDurationChanged.listen((d) {
      musicLength = d;
      print(musicLength);
      update();
    });

    audioPlayer.onAudioPositionChanged.listen((event) {
      position = event;
      update();
    });

    audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.PLAYING) {
        isPlaying.value = true;
        print("/$event");
      } else if (event == PlayerState.COMPLETED) {
        playMusic(false);
        isPlaying.value = true;
      } else {
        isPlaying.value = false;
        print("*$event");
      }
    });
  }

  playMusic(value) {
    if (value == true) {
      play(selectedRadio!.url);
    } else if (value == false) {
      audioPlayer.stop();
      play(selectedRadio!.url);
    }
    isPlaying.value = true;
    update();
  }

  stopMusic() {
    audioPlayer.pause();
    isPlaying.value = false;
    update();
  }

  play(String url) async {
    int result = await audioPlayer.play(url);
    selectedRadio = radios!.firstWhere((element) => element.url == url);
    // changeColour(selectedRadio);
    update();
  }

  changeColour(index) {
    final fColorHex = radios![index].fColor;
    final sColorHex = radios![index].sColor;
    fSelectedColor = Color(int.parse(fColorHex));
    sSelectedColor = Color(int.parse(sColorHex));
    update();
  }

  seekToSec(int value) {
    Duration newpos = Duration(seconds: value);
    audioPlayer.seek(newpos);
  }

  previous() {
    int count = selectedRadio!.id;
    count--;
    selectedRadio = radios![count];
    playMusic(false);
    update();
  }

  next() {
    int count = selectedRadio!.id;
    count++;
    selectedRadio = radios![count];
    playMusic(false);
    update();
  }

  like() {
    if (selectedRadio!.like) {
      selectedRadio!.like = false;
    } else {
      selectedRadio!.like = true;
    }
    update();
  }

  RxInt selected = 0.obs;

  void changeSelected(int index) {
    selected.value = index;
  }

  drawer() {
    return Drawer(
      child: Obx(
            () => Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Unknown"),
              accountEmail: Text("abcd1234@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: sSelectedColor,
                child: Text(
                  "U",
                  style: TextStyle(color: Colors.white, fontSize: 40.0),
                ),
              ),
              decoration: BoxDecoration(
                color: fSelectedColor,
              ),
            ),
            ListTile(
              selected: selected == 0,
              leading: Icon(Icons.home),
              title: Text(
                "Home",
                style: TextStyle(
                  fontFamily: "Oswald",
                  fontSize: 18,
                ),
              ),
              onTap: () {
                changeSelected(0);
              },
            ),
            ListTile(
              selected: selected == 1,
              leading: Icon(Icons.favorite),
              title: Text(
                "Favorite",
                style: TextStyle(
                  fontFamily: "Oswald",
                  fontSize: 18,
                ),
              ),
              onTap: () {
                changeSelected(1);
              },
            ),
            ListTile(
              selected: selected == 2,
              leading: Icon(Icons.settings),
              title: Text(
                "Settings",
                style: TextStyle(
                  fontFamily: "Oswald",
                  fontSize: 18,
                ),
              ),
              onTap: () {
                changeSelected(2);
              },
            ),
            ListTile(
              selected: selected == 3,
              leading: Icon(Icons.brush),
              title: Text(
                "Theme",
                style: TextStyle(
                  fontFamily: "Oswald",
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Get.bottomSheet(
                  Container(
                    child: Wrap(
                      children: <Widget>[
                        ListTile(
                            leading: Icon(Icons.wb_sunny_outlined),
                            title: Text("Light theme"),
                            onTap: () {
                              Get.changeTheme(ThemeData.light());
                              Get.back();
                            }),
                        ListTile(
                            leading: Icon(Icons.wb_sunny),
                            title: Text("Dark theme"),
                            onTap: () {
                              Get.changeTheme(ThemeData.dark());
                              Get.back();
                            }),
                      ],
                    ),
                  ),
                  // barrierColor: Colors.black,
                  backgroundColor: Colors.blue[300],
                  isDismissible: true,
                );
                changeSelected(3);
              },
            ),
            ListTile(
              selected: selected == 4,
              leading: Icon(Icons.logout),
              title: Text(
                "Logout",
                style: TextStyle(
                  fontFamily: "Oswald",
                  fontSize: 18,
                ),
              ),
              onTap: () {
                changeSelected(4);
                AlertDialog(
                  // title: "Logging out",
                  content: SizedBox(
                    height: 50,
                    child: Center(
                      child: Text(
                        "Are you sure want to logout?",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    InkWell(
                      child: Text("Cancel"),
                      onTap: () {
                        Get.back();
                      },
                    ),
                    InkWell(
                      child: Text("Cancel"),
                      onTap: () {
                        Get.back();
                      },
                    ),
                  ],
                );
              },
            ),
            Divider(
              thickness: 2,
            ),
            ListTile(
              selected: selected == 5,
              title: Text(
                "About Us",
                style: TextStyle(
                  fontFamily: "Oswald",
                  fontSize: 18,
                ),
              ),
              onTap: () {
                changeSelected(5);
              },
            ),
            ListTile(
              selected: selected == 6,
              title: Text(
                "Privacy Policy",
                style: TextStyle(
                  fontFamily: "Oswald",
                  fontSize: 18,
                ),
              ),
              onTap: () {
                changeSelected(6);
              },
            ),
          ],
        ),
      ),
    );
  }

}
