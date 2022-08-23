import 'dart:math' as math;

import 'package:andapp/common/app_theme.dart';
import 'package:andapp/common/common_functions.dart';
import 'package:andapp/common/tooltip.dart';
import 'package:andapp/services/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/image_utils.dart';

class CustomSpeedDial extends StatefulWidget {
  const CustomSpeedDial({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CustomSpeedDialState();
}

class CustomSpeedDialState extends State<CustomSpeedDial>
    with SingleTickerProviderStateMixin {
  bool _isOpened = false;
  late AnimationController _animationController;
  late Animation<double> _animateIcon;
  Animation<double>? _translateButton;
  final Curve _curve = Curves.easeOut;

  // this is needed to know how much to "translate"
  // when the menu is closed, we remove elevation to prevent
  // stacking all elevations
  bool _shouldHaveElevation = false;

  @override
  initState() {
    // a bit faster animation, which looks better: 300
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    // this does the translation of menu items
    _translateButton = Tween<double>(
      begin: 300,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  void animate() {
    if (!_isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    _isOpened = !_isOpened;
    // here we update whether or not they FABs should have elevation
    _shouldHaveElevation = !_shouldHaveElevation;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget callButton() {
    return Tooltip(
        message: "Call",
        textStyle: const TextStyle(color: Colors.white, fontSize: 16),
        height: 24,
        verticalOffset: 24,
        preferBelow: false,
        showDuration: const Duration(seconds: 5),
        decoration: ShapeDecoration(
          color: _appTheme.speedDialLabelBgLT,
          shape: const MessageBorder(usePadding: true),
        ),
        child: SizedBox(
          height: 36,
          width: 36,
          child: FloatingActionButton(
            onPressed: () {
              _makePhoneCall();
            },
            heroTag: UniqueKey(),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor: _appTheme.primaryColor,
            foregroundColor: Colors.white,
            elevation: _shouldHaveElevation ? 6.0 : 0,
            // tooltip: '',
            child: Center(
                child: SvgPicture.asset(
              SvgImages.iconCall,
              height: 20,
            )),
          ),
        ));
  }

  Future<void> _makePhoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: "9081003001",
    );
    await launchUrl(launchUri);
  }

  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'hello@andapp.in',
    /*query: _encodeQueryParameters(<String, String>{
      'subject': 'Example Subject & Symbols are allowed!'
    }),*/
  );

  Widget callBackButton() {
    return Tooltip(
        message: "Request a CallBack",
        textStyle: const TextStyle(color: Colors.white, fontSize: 16),
        height: 24,
        verticalOffset: 24,
        preferBelow: false,
        showDuration: const Duration(seconds: 5),
        decoration: ShapeDecoration(
          color: _appTheme.speedDialLabelBgLT,
          shape: const MessageBorder(usePadding: true),
        ),
        child: SizedBox(
          height: 36,
          width: 36,
          child: FloatingActionButton(
            onPressed: () {},
            // tooltip: '',
            heroTag: UniqueKey(),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor: _appTheme.primaryColor,
            foregroundColor: Colors.white,
            elevation: _shouldHaveElevation ? 6.0 : 0,
            child: Center(
                child: SvgPicture.asset(
              SvgImages.iconCallBack,
              height: 20,
            )),
          ),
        ));
  }

  Widget emailButton() {
    return Tooltip(
        message: "Email",
        textStyle: const TextStyle(color: Colors.white, fontSize: 16),
        height: 24,
        verticalOffset: 24,
        preferBelow: false,
        showDuration: const Duration(seconds: 5),
        decoration: ShapeDecoration(
          color: _appTheme.speedDialLabelBgLT,
          shape: const MessageBorder(usePadding: true),
        ),
        child: SizedBox(
          height: 36,
          width: 36,
          child: FloatingActionButton(
            onPressed: () async {
              await launchUrl(emailLaunchUri);
            },
            // tooltip: '',
            heroTag: UniqueKey(),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor: _appTheme.primaryColor,
            foregroundColor: Colors.white,
            elevation: _shouldHaveElevation ? 6.0 : 0,
            child: Center(
                child: SvgPicture.asset(
              SvgImages.iconEmail,
              height: 20,
            )),
          ),
        ));
  }

  Widget raiseTicketButton() {
    return Tooltip(
        message: "Raise a Ticket",
        textStyle: const TextStyle(color: Colors.white, fontSize: 16),
        height: 24,
        verticalOffset: 24,
        preferBelow: false,
        showDuration: const Duration(seconds: 5),
        decoration: ShapeDecoration(
          color: _appTheme.speedDialLabelBgLT,
          shape: const MessageBorder(usePadding: true),
        ),
        child: SizedBox(
          height: 36,
          width: 36,
          child: FloatingActionButton(
            onPressed: () {
              if (ApiClient.userManualUrl.isNotEmpty) {
                CommonFunctions.getInstance()!
                    .launchInBrowser(ApiClient.freshDeskUrl);
              }
            },
            // tooltip: '',
            heroTag: UniqueKey(),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor: _appTheme.primaryColor,
            foregroundColor: Colors.white,
            elevation: _shouldHaveElevation ? 6.0 : 0,
            child: Center(
                child: SvgPicture.asset(
              SvgImages.iconRaiseTicket,
              height: 20,
            )),
          ),
        ));
  }

  Widget userManualButton() {
    return Tooltip(
        message: "User Manual",
        textStyle: const TextStyle(color: Colors.white, fontSize: 16),
        height: 24,
        verticalOffset: 24,
        preferBelow: false,
        showDuration: const Duration(seconds: 5),
        decoration: ShapeDecoration(
          color: _appTheme.speedDialLabelBgLT,
          shape: const MessageBorder(usePadding: true),
        ),
        child: SizedBox(
          height: 36,
          width: 36,
          child: FloatingActionButton(
            onPressed: () {
              if (ApiClient.userManualUrl.isNotEmpty) {
                CommonFunctions.getInstance()!
                    .launchInBrowser(ApiClient.userManualUrl);
              }
            },
            // tooltip: '',
            heroTag: UniqueKey(),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor: _appTheme.primaryColor,
            foregroundColor: Colors.white,
            elevation: _shouldHaveElevation ? 6.0 : 0,
            child: Center(
                child: SvgPicture.asset(
              SvgImages.iconUserManual,
              height: 20,
            )),
          ),
        ));
  }

  Widget menuButton() {
    return
        /*Container(
      height: 36,
      width:36,
      margin: const EdgeInsets.only(bottom: 16),
      child: FloatingActionButton(
        //backgroundColor: _buttonColor?.value,
        backgroundColor: _appTheme.primaryColor,
        foregroundColor: Colors.white,
        onPressed: animate,
        tooltip: 'Toggle menu',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          size: 20,
          progress: _animateIcon,
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );*/

        Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: SizedBox(
        height: 36,
        width: 36,
        child: FloatingActionButton(
          onPressed: animate,
          backgroundColor: _appTheme.primaryColor,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0))),
          child: Transform.rotate(
            origin: Offset(_animateIcon.value, 0),
            angle: (1 - _animateIcon.value) * math.pi / 15,
            child: Center(
                child: !_isOpened
                    ? SvgPicture.asset(SvgImages.iconCall)
                    : const Icon(
                        Icons.clear,
                        color: Colors.white,
                        //size: 20.0,
                      )),
          ),
        ),
      ),
    );
  }

  final AppThemeState _appTheme = AppThemeState();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _isOpened ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Transform.translate(
                offset: Offset((_translateButton?.value ?? 1), 0),
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: _appTheme.greyBorderColor,
                      ),
                      color: _appTheme.supportFABBgColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      callButton(),
                      const SizedBox(width: 24),
                      callBackButton(),
                      const SizedBox(width: 24),
                      emailButton(),
                      const SizedBox(width: 24),
                      raiseTicketButton(),
                      const SizedBox(width: 24),
                      userManualButton(),
                    ],
                  ),
                ),
              ),
            ),
            menuButton(),
          ],
        ),
      ],
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class SupportFAB extends StatefulWidget {
  final ValueNotifier<ThemeMode> theme;
  const SupportFAB({Key? key, required this.theme}) : super(key: key);
  @override
  _SupportFABState createState() => _SupportFABState();
}

class _SupportFABState extends State<SupportFAB> with TickerProviderStateMixin {
  var renderOverlay = true;
  var visible = true;
  var switchLabelPosition = false;
  var extend = false;
  var rmicons = false;
  var customDialRoot = false;
  var closeManually = false;
  var useRAnimation = true;
  var isDialOpen = ValueNotifier<bool>(false);
  var speedDialDirection = SpeedDialDirection.up;
  var buttonSize = const Size(56.0, 56.0);
  var childrenButtonSize = const Size(56.0, 56.0);
  var selectedfABLocation = FloatingActionButtonLocation.endDocked;
  var items = [
    FloatingActionButtonLocation.startFloat,
    FloatingActionButtonLocation.startDocked,
    FloatingActionButtonLocation.centerFloat,
    FloatingActionButtonLocation.endFloat,
    FloatingActionButtonLocation.endDocked,
    FloatingActionButtonLocation.startTop,
    FloatingActionButtonLocation.centerTop,
    FloatingActionButtonLocation.endTop,
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isDialOpen.value) {
          isDialOpen.value = false;
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Speed Dial Example"),
        ),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("SpeedDial Location",
                                style: Theme.of(context).textTheme.bodyText1),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).brightness ==
                                      Brightness.dark
                                      ? Colors.grey[800]
                                      : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10)),
                              child:
                              DropdownButton<FloatingActionButtonLocation>(
                                value: selectedfABLocation,
                                isExpanded: true,
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 20,
                                underline: const SizedBox(),
                                onChanged: (fABLocation) => setState(
                                        () => selectedfABLocation = fABLocation!),
                                selectedItemBuilder: (BuildContext context) {
                                  return items.map<Widget>((item) {
                                    return Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4, horizontal: 10),
                                            child: Text(item.value)));
                                  }).toList();
                                },
                                items: items.map((item) {
                                  return DropdownMenuItem<
                                      FloatingActionButtonLocation>(
                                    child: Text(
                                      item.value,
                                    ),
                                    value: item,
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("SpeedDial Direction",
                                style: Theme.of(context).textTheme.bodyText1),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).brightness ==
                                      Brightness.dark
                                      ? Colors.grey[800]
                                      : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButton<SpeedDialDirection>(
                                value: speedDialDirection,
                                isExpanded: true,
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 20,
                                underline: const SizedBox(),
                                onChanged: (sdo) {
                                  setState(() {
                                    speedDialDirection = sdo!;
                                    selectedfABLocation = (sdo.isUp &&
                                        selectedfABLocation.value
                                            .contains("Top")) ||
                                        (sdo.isLeft &&
                                            selectedfABLocation.value
                                                .contains("start"))
                                        ? FloatingActionButtonLocation.endDocked
                                        : sdo.isDown &&
                                        !selectedfABLocation.value
                                            .contains("Top")
                                        ? FloatingActionButtonLocation
                                        .endTop
                                        : sdo.isRight &&
                                        selectedfABLocation.value
                                            .contains("end")
                                        ? FloatingActionButtonLocation
                                        .startDocked
                                        : selectedfABLocation;
                                  });
                                },
                                selectedItemBuilder: (BuildContext context) {
                                  return SpeedDialDirection.values
                                      .toList()
                                      .map<Widget>((item) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 10),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(describeEnum(item)
                                              .toUpperCase())),
                                    );
                                  }).toList();
                                },
                                items: SpeedDialDirection.values
                                    .toList()
                                    .map((item) {
                                  return DropdownMenuItem<SpeedDialDirection>(
                                    child:
                                    Text(describeEnum(item).toUpperCase()),
                                    value: item,
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!customDialRoot)
                        SwitchListTile(
                            contentPadding: const EdgeInsets.all(15),
                            value: extend,
                            title: const Text("Extend Speed Dial"),
                            onChanged: (val) {
                              setState(() {
                                extend = val;
                              });
                            }),
                      SwitchListTile(
                          contentPadding: const EdgeInsets.all(15),
                          value: visible,
                          title: const Text("Visible"),
                          onChanged: (val) {
                            setState(() {
                              visible = val;
                            });
                          }),
                      SwitchListTile(
                          contentPadding: const EdgeInsets.all(15),
                          value: customDialRoot,
                          title: const Text("Custom dialRoot"),
                          onChanged: (val) {
                            setState(() {
                              customDialRoot = val;
                            });
                          }),
                      SwitchListTile(
                          contentPadding: const EdgeInsets.all(15),
                          value: renderOverlay,
                          title: const Text("Render Overlay"),
                          onChanged: (val) {
                            setState(() {
                              renderOverlay = val;
                            });
                          }),
                      SwitchListTile(
                          contentPadding: const EdgeInsets.all(15),
                          value: closeManually,
                          title: const Text("Close Manually"),
                          onChanged: (val) {
                            setState(() {
                              closeManually = val;
                            });
                          }),
                      SwitchListTile(
                          contentPadding: const EdgeInsets.all(15),
                          value: rmicons,
                          title: const Text("Remove Icons (for children)"),
                          onChanged: (val) {
                            setState(() {
                              rmicons = val;
                            });
                          }),
                      if (!customDialRoot)
                        SwitchListTile(
                            contentPadding: const EdgeInsets.all(15),
                            value: useRAnimation,
                            title: const Text("Use Rotation Animation"),
                            onChanged: (val) {
                              setState(() {
                                useRAnimation = val;
                              });
                            }),
                      SwitchListTile(
                          contentPadding: const EdgeInsets.all(15),
                          value: switchLabelPosition,
                          title: const Text("Switch Label Position"),
                          onChanged: (val) {
                            setState(() {
                              switchLabelPosition = val;
                              if (val) {
                                if ((selectedfABLocation.value
                                    .contains("end") ||
                                    selectedfABLocation.value
                                        .toLowerCase()
                                        .contains("top")) &&
                                    speedDialDirection.isUp) {
                                  selectedfABLocation =
                                      FloatingActionButtonLocation.startDocked;
                                } else if ((selectedfABLocation.value
                                    .contains("end") ||
                                    !selectedfABLocation.value
                                        .toLowerCase()
                                        .contains("top")) &&
                                    speedDialDirection.isDown) {
                                  selectedfABLocation =
                                      FloatingActionButtonLocation.startTop;
                                }
                              }
                            });
                          }),
                      const Text("Button Size"),
                      Slider(
                        value: buttonSize.width,
                        min: 50,
                        max: 500,
                        label: "Button Size",
                        onChanged: (val) {
                          setState(() {
                            buttonSize = Size(val, val);
                          });
                        },
                      ),
                      const Text("Children Button Size"),
                      Slider(
                        value: childrenButtonSize.height,
                        min: 50,
                        max: 500,
                        onChanged: (val) {
                          setState(() {
                            childrenButtonSize = Size(val, val);
                          });
                        },
                      )
                    ]),
              ),
            )),
        floatingActionButtonLocation: selectedfABLocation,
        floatingActionButton: SpeedDial(
          // animatedIcon: AnimatedIcons.menu_close,
          // animatedIconTheme: IconThemeData(size: 22.0),
          // / This is ignored if animatedIcon is non null
          // child: Text("open"),
          // activeChild: Text("close"),
          icon: Icons.add,
          activeIcon: Icons.close,
          spacing: 3,
          openCloseDial: isDialOpen,
          childPadding: const EdgeInsets.all(5),
          spaceBetweenChildren: 4,
          dialRoot: customDialRoot
              ? (ctx, open, toggleChildren) {
            return ElevatedButton(
              onPressed: toggleChildren,
              style: ElevatedButton.styleFrom(
                primary: Colors.blue[900],
                padding: const EdgeInsets.symmetric(
                    horizontal: 22, vertical: 18),
              ),
              child: const Text(
                "Custom Dial Root",
                style: TextStyle(fontSize: 17),
              ),
            );
          }
              : null,
          buttonSize:
          buttonSize, // it's the SpeedDial size which defaults to 56 itself
          // iconTheme: IconThemeData(size: 22),
          label: extend
              ? const Text("Open")
              : null, // The label of the main button.
          /// The active label of the main button, Defaults to label if not specified.
          activeLabel: extend ? const Text("Close") : null,

          /// Transition Builder between label and activeLabel, defaults to FadeTransition.
          // labelTransitionBuilder: (widget, animation) => ScaleTransition(scale: animation,child: widget),
          /// The below button size defaults to 56 itself, its the SpeedDial childrens size
          childrenButtonSize: childrenButtonSize,
          visible: visible,
          direction: speedDialDirection,
          switchLabelPosition: switchLabelPosition,

          /// If true user is forced to close dial manually
          closeManually: closeManually,

          /// If false, backgroundOverlay will not be rendered.
          renderOverlay: renderOverlay,
          // overlayColor: Colors.black,
          // overlayOpacity: 0.5,
          onOpen: () => debugPrint('OPENING DIAL'),
          onClose: () => debugPrint('DIAL CLOSED'),
          useRotationAnimation: useRAnimation,
          tooltip: 'Open Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          // foregroundColor: Colors.black,
          // backgroundColor: Colors.white,
          // activeForegroundColor: Colors.red,
          // activeBackgroundColor: Colors.blue,
          elevation: 8.0,
          animationCurve: Curves.elasticInOut,
          isOpenOnStart: false,
          animationDuration: const Duration(milliseconds: 1500),
          shape: customDialRoot
              ? const RoundedRectangleBorder()
              : const StadiumBorder(),
          // childMargin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          children: [
            SpeedDialChild(
              child: !rmicons ? const Icon(Icons.accessibility) : null,
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              label: 'First',
              onTap: () => setState(() => rmicons = !rmicons),
              onLongPress: () => debugPrint('FIRST CHILD LONG PRESS'),
            ),
            SpeedDialChild(
              child: !rmicons ? const Icon(Icons.brush) : null,
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
              label: 'Second',
              onTap: () => debugPrint('SECOND CHILD'),
            ),
            SpeedDialChild(
              child: !rmicons ? const Icon(Icons.margin) : null,
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              label: 'Show Snackbar',
              visible: true,
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text(("Third Child Pressed")))),
              onLongPress: () => debugPrint('THIRD CHILD LONG PRESS'),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: Row(
            mainAxisAlignment: selectedfABLocation ==
                FloatingActionButtonLocation.startDocked
                ? MainAxisAlignment.end
                : selectedfABLocation == FloatingActionButtonLocation.endDocked
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                icon: const Icon(Icons.nightlight_round),
                tooltip: "Switch Theme",
                onPressed: () => {
                  widget.theme.value = widget.theme.value.index == 2
                      ? ThemeMode.light
                      : ThemeMode.dark
                },
              ),
              ValueListenableBuilder<bool>(
                  valueListenable: isDialOpen,
                  builder: (ctx, value, _) => IconButton(
                    icon: const Icon(Icons.open_in_browser),
                    tooltip: (!value ? "Open" : "Close") + " Speed Dial",
                    onPressed: () => {isDialOpen.value = !isDialOpen.value},
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

extension EnumExt on FloatingActionButtonLocation {
  /// Get Value of The SpeedDialDirection Enum like Up, Down, etc. in String format
  String get value => toString().split(".")[1];
}*/