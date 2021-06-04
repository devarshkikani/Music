import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radio/Controller/home_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class CurrentPlay extends StatelessWidget {
  final control = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(
        builder: (value) => Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.antiAlias,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: control.selectedRadio != null
                  ? BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(control.selectedRadio!.image),
                        fit: BoxFit.cover,
                        // colorFilter: ColorFilter.mode(
                        //     Colors.black.withOpacity(0.3), BlendMode.darken),
                      ),
                    )
                  : BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blueGrey,
                          Colors.grey,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
            ),
            20.heightBox,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppBar(
                  leading: IconButton(
                    icon: Icon(CupertinoIcons.chevron_back),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  title: control.selectedRadio != null
                      ? control.selectedRadio!.name.text.xl3.make()
                      : null,
                  actions: [
                    IconButton(
                      icon: control.selectedRadio != null
                          ? control.selectedRadio!.like == true
                              ? Icon(CupertinoIcons.heart_fill,
                                  color: Colors.red)
                              : Icon(CupertinoIcons.heart)
                          : Icon(CupertinoIcons.heart),
                      onPressed: () {
                        control.like();
                      },
                    ),
                  ],
                ).h(80),
                if (control.selectedRadio != null)
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Column(
                      children: [
                        Obx(
                          () => Align(
                            alignment: Alignment.bottomCenter,
                            child: [
                              10.heightBox,
                              "${control.selectedRadio!.tagline}"
                                  .text
                                  .xl2
                                  .white
                                  .make(),
                              "${control.selectedRadio!.artist}"
                                  .text
                                  .white
                                  .xl
                                  .makeCentered(),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    "${control.position.inMinutes}:${control.position.inSeconds.remainder(60)}"
                                        .text
                                        .white
                                        .make(),
                                    Expanded(
                                      child: SliderTheme(
                                        data: SliderThemeData(
                                            trackHeight: 2.0,
                                            thumbShape: RoundSliderThumbShape(
                                                enabledThumbRadius: 8)),
                                        child: Slider(
                                          value: control.position.inSeconds
                                              .toDouble(),
                                          max: control.musicLength.inSeconds
                                              .toDouble(),
                                          activeColor: control.sSelectedColor,
                                          inactiveColor: Colors.white,
                                          onChanged: (value) {
                                            control.seekToSec(value.toInt());
                                          },
                                        ),
                                      ),
                                    ),
                                    "${control.musicLength.inMinutes}:${control.musicLength.inSeconds.remainder(60)}"
                                        .text
                                        .white
                                        .make(),
                                  ],
                                ),
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child: Icon(
                                        CupertinoIcons.backward_fill,
                                        size: 40.0,
                                        color: Colors.white,
                                      ),
                                      onTap: () {
                                        control.previous();
                                      },
                                    ),
                                    InkWell(
                                      child: Icon(
                                        control.isPlaying.value
                                            ? CupertinoIcons.stop_circle
                                            : CupertinoIcons.play_circle,
                                        size: 70.0,
                                        color: Colors.white,
                                      ),
                                      onTap: () {
                                        if (control.isPlaying.value) {
                                          control.stopMusic();
                                        } else {
                                          control.playMusic(true);
                                        }
                                      },
                                    ),
                                    InkWell(
                                      child: Icon(
                                        CupertinoIcons.forward_fill,
                                        size: 40.0,
                                        color: Colors.white,
                                      ),
                                      onTap: () {
                                        control.next();
                                      },
                                    ),
                                  ]),
                              10.heightBox,
                            ].vStack(),
                          ).pOnly(bottom: context.percentHeight * 2),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
