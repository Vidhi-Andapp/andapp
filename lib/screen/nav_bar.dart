import 'package:andapp/common/app_theme.dart';
import 'package:andapp/common/custom_expansion.dart';
import 'package:andapp/common/custom_user_account_drawer_header.dart';
import 'package:andapp/common/image_utils.dart';
import 'package:andapp/common/network_image.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/di/app_component_base.dart';
import 'package:andapp/di/shared_preferences.dart';
import 'package:andapp/model/get_profile.dart';
import 'package:andapp/screen/dashboard/dashboard_bloc.dart';
import 'package:andapp/screen/profile/my_profile.dart';
import 'package:andapp/screen/support/support.dart';
import 'package:andapp/screen/training/training_dashboard_gi.dart';
import 'package:andapp/screen/training/training_dashboard_li.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final DashboardBloc bloc = DashboardBloc();
  List<Item>? _menu;
  String? pospId;

  List<Item> addItems() {
    List<Item> data = [];
    data.add(Item(
      index: 0,
      headerValue: StringUtils.menuProfile,
      leadingIcon: SvgImages.menuProfile,
      /*trailingIcon: const Icon(Icons.keyboard_arrow_down_outlined,size: 30,),*/
    ));
    data.add(Item(
      index: 1,
      leadingIcon: SvgImages.menuSupport,
      headerValue: StringUtils.menuSupport,
      //expandedValue: null,
    ));
    data.add(Item(
        index: 2,
        headerValue: StringUtils.menuReferral,
        leadingIcon: SvgImages.menuReferral,
        trailingIcon: const Icon(
          Icons.keyboard_arrow_down_outlined,
          size: 30,
        ),
        expandedValue: [StringUtils.menuMail, StringUtils.menuCopy],
        isExpanded: false));
    data.add(Item(
        index: 3,
        headerValue: StringUtils.training,
        leadingIcon: SvgImages.menuTraining,
        trailingIcon: const Icon(
          Icons.keyboard_arrow_down_outlined,
          size: 30,
        ),
        expandedValue: [
          StringUtils.generalInsurance,
          StringUtils.lifeInsurance
        ],
        isExpanded: false));
    data.add(Item(
      index: 4,
      headerValue: StringUtils.menuLogout,
      leadingIcon: SvgImages.menuLogout,
      /*trailingIcon: const Icon(Icons.keyboard_arrow_down_outlined,size: 30,),*/
    ));
    return data;
  }

  Widget _buildPanel() {
    return CustomExpansionPanelList(
      elevation: 0,
      key: const ValueKey<int>(1),
      expandedHeaderPadding: EdgeInsets.zero,
      dividerColor: Colors.transparent,
      expansionCallback: (int index, bool isExpanded) {
        expansionCallBack(index, isExpanded);
      },
      children: _menu!.map<CustomExpansionPanel>((Item item) {
        return CustomExpansionPanel(
          canTapOnHeader: true,
          backgroundColor: Theme
              .of(context)
              .scaffoldBackgroundColor,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              onTap: () {
                if (item.headerValue == StringUtils.menuProfile) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return MyProfile(pospId: pospId!);
                    }),
                  );
                } else if (item.headerValue == StringUtils.menuSupport) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const SupportPage();
                    }),
                  );
                }
                else {
                  expansionCallBack(item.index, !item.isExpanded);
                }
              },
              leading: SvgPicture.asset(
                item.leadingIcon,
                height: 22,
                width: 22,
                color: Colors.white,
              ),
              title: Text(
                item.headerValue ?? "",
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    fontFamily: "Poppins"),
              ),
              dense: true,
            );
          },
          hasIcon: item.trailingIcon == null ? false : true,
          body: (item.expandedValue != null)
              ? ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              itemBuilder: (context, index) =>
                  ListTile(
                    onTap: () {
                      if (item.expandedValue![index] ==
                          StringUtils.generalInsurance &&
                          pospId != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return TrainingDashboardGI(pospId: pospId!);
                          }),
                        );
                      } else if (item.expandedValue![index] ==
                          StringUtils.lifeInsurance &&
                          pospId != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return TrainingDashboardLI(pospId: pospId!);
                          }),
                        );
                      }
                      /* else if (item.expandedValue![index] ==
                          StringUtils.menuMail) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) {
                                return const TrainingDashboardLI();
                              }),
                        );
                      }
                      else if (item.expandedValue![index] ==
                          StringUtils.menuCopy) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) {
                                return const TrainingDashboardLI();
                              }),
                        );
                      }*/
                    },
                    tileColor: const Color(0x20DADADA),
                    leading: SvgPicture.asset(
                      item.leadingIcon,
                      height: 22,
                      width: 22,
                      color: Colors.transparent,
                    ),
                    title: Text(item.expandedValue![index]),
                    dense: true,
                    //trailing: item.trailingIcon,
                  ),
              itemCount: item.expandedValue?.length)
              : Container(),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

  @override
  void initState() {
    super.initState();
    AppComponentBase.getInstance()
        ?.getSharedPreference()
        .getUserDetail(key: SharedPreference().pospId)
        .then((value) {
      pospId = value;
      bloc.getProfile(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    _menu ??= addItems();
    return Drawer(
      width: 300,
      backgroundColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      child: SizedBox(
        child: StreamBuilder<ProfileData?>(
            stream: bloc.profileStream,
            builder:
                (BuildContext context, AsyncSnapshot<ProfileData?> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                var profileData = snapshot.data;
                return ListView(
                  // Remove padding
                  padding: EdgeInsets.zero,
                  children: [
                    CustomUserAccountsDrawerHeader(
                      accountName: Text(
                        profileData?.personalDetails?.pospName ?? "",
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            fontFamily: "Poppins"),
                      ),
                      accountEmail: Text(
                        profileData?.personalDetails?.pospCode ?? "",
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            fontFamily: "Poppins"),
                      ),
                      currentAccountPicture: CustomNetworkImage(
                        radius: 54, //as current picture size is 108
                        placeholderImage:
                        profileData?.personalDetails?.gender == "M"
                            ? AssetImages.profileAvatarMale
                            : AssetImages.profileAvatarFemale,
                        image: profileData?.personalDetails?.pospPhoto ?? "",
                      ),
                      /* CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 48,
                          backgroundColor: appTheme.primaryColor,
                          child: ClipOval(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Image.asset(AssetImages.profileAvatarFemale,
                                height: 100, width: 100),
                          ),
                        ),
                      ),*/
                      decoration: BoxDecoration(
                        color: appTheme.primaryColor,
                      ),
                    ),
                    _buildPanel(),
                  ],
                );
              }
              return Container();
            }),
      ),
    );
  }

  void expansionCallBack(int index, bool isExpanded) {
    setState(() {
      for (int i = 0; i < _menu!.length; i++) {
        if (i != index) {
          _menu![i].isExpanded = false;
        }
      }
      bool newValue = !_menu![index].isExpanded;
      _menu![index].isExpanded = newValue;
      isExpanded = newValue;
    });
  }
}

// stores ExpansionPanel state information
class Item {
  Item({
    required this.index,
    this.expandedValue,
    required this.leadingIcon,
    this.trailingIcon,
    this.headerValue,
    this.isExpanded = false,
  });

  int index;
  String leadingIcon;
  Widget? trailingIcon;
  String? headerValue;
  List<String>? expandedValue;
  bool isExpanded;
}

/*


Widget _buildPanel() {
  return ExpansionPanelList(
    expansionCallback: (int index, bool isExpanded) {
      setState(() {
        _menu[index].isExpanded = !isExpanded;
      });
    },
    children: _menu.map<ExpansionPanel>((Item item) {
      return ExpansionPanel(
        canTapOnHeader: true,
        backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
        headerBuilder: (BuildContext context, bool isExpanded) {
          return ListTile(
            leading: item.leadingIcon,
            title: Text(item.headerValue ?? ""),
            //trailing: item.trailingIcon,
          );
        },
        body: Column(
          children: [
            ListTile(
                title: Text(item.expandedValue?.first ?? ""),
                onTap: () {
                  setState(() {
                    _menu.removeWhere((currentItem) => item == currentItem);
                  });
                }
            ),
            ListTile(
                title: Text(item.expandedValue?.last ?? ""),
                onTap: () {
                  setState(() {
                    _menu.removeWhere((currentItem) => item == currentItem);
                  });
                }
            ),
          ],
        ),
        isExpanded: item.isExpanded,
      );
    }).toList(),
  );
}
*/