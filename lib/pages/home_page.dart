import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:radio/Controller/home_controller.dart';
import 'package:velocity_x/velocity_x.dart';

import 'current_play.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (value) => Scaffold(
        drawer: controller.drawer(),
        body: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.antiAlias,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    controller.sSelectedColor,
                    controller.fSelectedColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment(1.0, 1.0),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  title: "Music".text.xl4.bold.white.make().shimmer(
                      primaryColor: Vx.purple300, secondaryColor: Colors.white),
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  centerTitle: true,
                ).h(60),
                VxSwiper.builder(
                  itemCount: controller.suggestion.length,
                  aspectRatio: 1.0,
                  height: 70.0,
                  viewportFraction: 0.40,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayAnimationDuration: 3.seconds,
                  autoPlayCurve: Curves.linear,
                  enableInfiniteScroll: true,
                  itemBuilder: (context, index) {
                    final s = controller.suggestion[index];
                    return Chip(
                      label: s.text.make(),
                      backgroundColor: Vx.randomColor,
                    );
                  },
                ),
                10.heightBox,
                controller.radios != null
                    ? InkWell(
                        child: VxSwiper.builder(
                          itemCount: controller.radios!.length,
                          // ignore: unrelated_type_equality_checks
                          aspectRatio: context.mdWindowSize ==
                                  MobileDeviceSize.small
                              ? 2.5
                              // ignore: unrelated_type_equality_checks
                              : context.mdWindowSize == MobileDeviceSize.medium
                                  ? 2.0
                                  : 1.5,
                          enlargeCenterPage: true,
                          onPageChanged: (index) {
                            controller.changeColour(index);
                          },
                          itemBuilder: (context, index) {
                            final rad = controller.radios![index];
                            return VxBox(
                              child: InkWell(
                                child: ZStack(
                                  [
                                    Positioned(
                                        top: 0.0,
                                        right: 0.0,
                                        child: VxBox(
                                          child: rad.category.text.white
                                              .make()
                                              .px16(),
                                        )
                                            .height(40)
                                            .black
                                            .alignCenter
                                            .withRounded(value: 10.0)
                                            .make()),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: VStack(
                                        [
                                          rad.name.text.xl3.white.bold.make(),
                                          // rad.tagline.text.sm.white.semiBold
                                          //     .make(),
                                          5.heightBox,
                                        ],
                                        crossAlignment:
                                            CrossAxisAlignment.center,
                                      ),
                                    ),
                                    Align(
                                        alignment: Alignment.center,
                                        child: [
                                          Icon(
                                            CupertinoIcons.play_circle,
                                            color: Colors.white,
                                          ),
                                        ].vStack()),
                                  ],
                                ),
                                onTap: () {
                                  Get.to(CurrentPlay());
                                  controller.play(rad.url);
                                },
                              ),
                            )
                                .clip(Clip.antiAlias)
                                .bgImage(DecorationImage(
                                  image: NetworkImage(rad.image),
                                  fit: BoxFit.cover,
                                  /*colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.3),
                                  BlendMode.darken),*/
                                ))
                                .border(color: Colors.black, width: 3.0)
                                .withRounded(value: 50.0)
                                .make()
                                .px8();
                          },
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(color: Colors.white)),
                10.heightBox,
                "Popular Tracks".text.xl3.bold.white.make().px16(),
                controller.radios != null
                    ? Expanded(
                        child: ListView.builder(
                            itemCount: controller.radios!.length,
                            // shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              final list = controller.radios![index];
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(list.image),
                                ),
                                title: list.tagline.text.white.bold.make(),
                                subtitle: list.artist.text.white.make(),
                                /*trailing: IconButton(
                                  icon: control.isPlaying.value
                                      ? Icon(
                                          CupertinoIcons.stop_circle,
                                          size: 30,
                                        )
                                      : Icon(
                                          CupertinoIcons.play_circle,
                                          size: 30,
                                        ),
                                  onPressed: () {
                                    control.play(list.url);
                                  },
                                ),*/
                                onTap: () {
                                  Get.to(CurrentPlay());
                                  controller.play(list.url);
                                },
                              );
                            }),
                      )
                    : Center(
                        child: CircularProgressIndicator(color: Colors.white)),
                controller.selectedRadio != null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.09,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ListTile(
                            onTap: () {
                              Get.to(CurrentPlay());
                            },
                            leading: CircleAvatar(
                              maxRadius: 30.0,
                              backgroundImage:
                                  NetworkImage(controller.selectedRadio!.image),
                            ),
                            title: "${controller.selectedRadio!.name}"
                                .text
                                .xl2
                                .make(),
                            subtitle: "${controller.selectedRadio!.artist}"
                                .text
                                .xl
                                .make(),
                            trailing: IconButton(
                              icon: controller.isPlaying.value
                                  ? Icon(
                                      CupertinoIcons.stop_circle,
                                      size: 40,
                                    )
                                  : Icon(
                                      CupertinoIcons.play_circle,
                                      size: 40,
                                    ),
                              onPressed: () {
                                if (controller.isPlaying.value) {
                                  controller.stopMusic();
                                } else {
                                  controller.playMusic(true);
                                }
                              },
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
