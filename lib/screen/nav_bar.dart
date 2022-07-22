import 'package:andapp/common/app_theme.dart';
import 'package:andapp/common/custom_user_account_drawer_header.dart';
import 'package:andapp/common/image_utils.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  get _menu => addItems();

  List<Item> addItems() {
    List<Item> data = [];
    data.add(Item(
      headerValue: StringUtils.menuProfile,
      leadingIcon: SvgImages.menuProfile,
      /*trailingIcon: const Icon(Icons.keyboard_arrow_down_outlined,size: 30,),*/
    ));
    data.add(Item(
      leadingIcon: SvgImages.menuSupport,
      headerValue: StringUtils.menuSupport,
      //expandedValue: null,
    ));
    data.add(Item(
        headerValue: StringUtils.menuReferral,
        leadingIcon: SvgImages.menuReferral,
        trailingIcon: const Icon(Icons.keyboard_arrow_down_outlined, size: 30,),
        expandedValue: [StringUtils.menuMail, StringUtils.menuCopy],
        isExpanded: true
    ));
    data.add(Item(
        headerValue: StringUtils.training,
        leadingIcon: SvgImages.menuTraining,
        trailingIcon: const Icon(Icons.keyboard_arrow_down_outlined, size: 30,),
        expandedValue: [
          StringUtils.generalInsurance,
          StringUtils.lifeInsurance
        ],
        isExpanded: true
    ));
    data.add(Item(
      headerValue: StringUtils.menuLogout,
      leadingIcon: SvgImages.menuLogout,
      /*trailingIcon: const Icon(Icons.keyboard_arrow_down_outlined,size: 30,),*/
    ));
    return data;
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expandedHeaderPadding: const EdgeInsets.all(2),
      dividerColor : Colors.transparent,
      expansionCallback: (int index, bool isExpanded) {
        /*for (int i = 0; i < _menu.length; i++) {
          if (i == index) {
            _menu[index].isExpanded = !isExpanded;
          } else {
            _menu[index].isExpanded = false;
          }
        }
        setState(() {});*/
        bool newValue = !_menu[index].isExpanded;
        _menu[index].isExpanded = newValue;
        setState(() {
          isExpanded = newValue;
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
              /* tileColor : Theme
                          .of(context)
                          .scaffoldBackgroundColor,*/
              leading: SvgPicture.asset(
                item.leadingIcon, height: 22, width: 22,color: Colors.white,),
              title: Text(item.headerValue ?? "",style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 14,fontFamily: "Poppins"),),
              //trailing: item.trailingIcon,
              selected: isExpanded,
              dense: true,
            );
          },
          body: (item.expandedValue != null)?
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) =>
                  ListTile(
                    onTap: (){},
                    tileColor: const Color(0x20DADADA),
                    leading: SvgPicture.asset(
                      item.leadingIcon, height: 22, width: 22,color: Colors.transparent,),
                    title: Text(item.expandedValue![index]),
                    dense: true,
                    //trailing: item.trailingIcon,
                  ),
              itemCount: item.expandedValue?.length)
              :
          Container(),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Drawer(
      width: 300,
      backgroundColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      child:
      SizedBox(
        child:
        ListView(
          // Remove padding
          padding: EdgeInsets.zero,
          children: [
            CustomUserAccountsDrawerHeader(
              accountName: const Text('Vidhi Shah',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16,fontFamily: "Poppins"),),
              accountEmail: const Text('P123456789',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,fontFamily: "Poppins"),),
              currentAccountPicture: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: appTheme.primaryColor,
                  child: ClipOval(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.asset(
                      AssetImages.profileAvatarFemale, height: 100, width:100),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: appTheme.primaryColor,
              ),
            ),
            _buildPanel(),
          ],
        ),),
    );
  }
}

// stores ExpansionPanel state information
class Item {
  Item({
    this.expandedValue,
    required this.leadingIcon,
    this.trailingIcon,
    this.headerValue,
    this.isExpanded = false,
  });

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
