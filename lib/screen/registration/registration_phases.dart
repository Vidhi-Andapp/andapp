import 'package:andapp/common/app_theme.dart';
import 'package:andapp/common/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegistrationPhases extends StatefulWidget {
  final int? index;
  final Function refresh;

  const RegistrationPhases(
      {Key? key, @required this.index, required this.refresh})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => RegistrationPhasesState();
}

class RegistrationPhasesState extends State<RegistrationPhases>
    with SingleTickerProviderStateMixin {
  int? currIndex = 1;

  @override
  initState() {
    // a bit faster animation, which looks better: 300
    currIndex = widget.index;
    super.initState();
  }

  methodInChild(int index) {
    currIndex = index;
    // setState(() {});
  }

  void _itemTapped(int index) {
    /*  currIndex = index;
    widget.refresh(index);
    setState(() {});*/
  }

  Widget kycButton() {
    return SvgPicture.asset(
        currIndex == 1 ? SvgImages.kycSelected : SvgImages.kycUnSelected,
        height: (MediaQuery.of(context).size.width - 100) / 4,
        width: (MediaQuery.of(context).size.width - 100) / 4);
    /*return Card(
        margin: const EdgeInsets.all(0),
        elevation: 2,
        color: currIndex == 1 ? _appTheme.primaryColor : Theme
            .of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
    side: BorderSide(
    color: currIndex == 1 ? _appTheme.primaryColor : _appTheme.separatorColor, width: 0.8),
    borderRadius: BorderRadius.circular(
        16),
    ),
    //Wrap with IntrinsicHeight
    child:
    SizedBox(
    width: (MediaQuery.of(context).size.width - 100) / 4,
    height: ((MediaQuery.of(context).size.width - 100) / 4) - 8,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child:  Center(
        child: Text(StringUtils.kycDetails,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14,
        fontWeight: FontWeight.w700,color: currIndex == 1 ? Colors.white : _appTheme.separatorColor),),
      ),
    ),
    )
    );*/
  }

  Widget accountButton() {
    return SvgPicture.asset(
      currIndex == 2 ? SvgImages.accountSelected : SvgImages.accountUnSelected,
      height: (MediaQuery.of(context).size.width - 100) / 4,
      width: (MediaQuery.of(context).size.width - 100) / 4,
    );
    /*return Card(
        margin: const EdgeInsets.all(0),
        elevation: 2,
        color: currIndex == 2 ? _appTheme.primaryColor : Theme
            .of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: currIndex == 2 ? _appTheme.primaryColor : _appTheme.separatorColor, width: 0.8),
          borderRadius: BorderRadius.circular(
              16),
        ),
        //Wrap with IntrinsicHeight
        child:
        SizedBox(
          width: (MediaQuery.of(context).size.width - 100) / 4,
          height: ((MediaQuery.of(context).size.width - 100) / 4) - 8,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child:  Center(
              child: Text(StringUtils.acDetails,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14,
                    fontWeight: FontWeight.w700,color:currIndex == 2 ? Colors.white : _appTheme.separatorColor),),
            ),
          ),
        )
    );*/
  }

  Widget bankButton() {
    return SvgPicture.asset(
        currIndex == 3 ? SvgImages.bankSelected : SvgImages.bankUnSelected,
        height: (MediaQuery.of(context).size.width - 100) / 4,
        width: (MediaQuery.of(context).size.width - 100) / 4);
    /*return Card(
        margin: const EdgeInsets.all(0),
        elevation: 2,
        color: currIndex == 3 ? _appTheme.primaryColor : Theme
            .of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: currIndex == 3 ? _appTheme.primaryColor :_appTheme.separatorColor, width: 0.8),
          borderRadius: BorderRadius.circular(
              16),
        ),
        //Wrap with IntrinsicHeight
        child:
        SizedBox(
          width: (MediaQuery.of(context).size.width - 100) / 4,
          height: ((MediaQuery.of(context).size.width - 100) / 4) - 8,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child:  Center(
              child: Text(StringUtils.bankDetails,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14,
                    fontWeight: FontWeight.w700,color: currIndex == 3 ? Colors.white :_appTheme.separatorColor),),
            ),
          ),
        )
    );*/
  }

  Widget academicButton() {
    return SvgPicture.asset(
        currIndex == 4
            ? SvgImages.academicSelected
            : SvgImages.academicUnSelected,
        height: (MediaQuery.of(context).size.width - 100) / 4,
        width: (MediaQuery.of(context).size.width - 100) / 4);
    /* Card(
        margin: const EdgeInsets.all(0),
        elevation: 2,
        color: currIndex == 4 ? _appTheme.primaryColor : Theme
            .of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: currIndex == 4 ? _appTheme.primaryColor : _appTheme.separatorColor, width: 0.8),
          borderRadius: BorderRadius.circular(
              16),
        ),
        //Wrap with IntrinsicHeight
        child:
        SizedBox(
          width: (MediaQuery.of(context).size.width - 100) / 4,
          height: ((MediaQuery.of(context).size.width - 100) / 4) - 8,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
              child: Text(StringUtils.academicDetails,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14,
                    fontWeight: FontWeight.w700,color: currIndex == 4 ? Colors.white :_appTheme.separatorColor),),
            ),
          ),
        )
    );*/
  }

  final AppThemeState _appTheme = AppThemeState();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    _itemTapped(1);
                  },
                  child: kycButton()),
              SizedBox(
                width: 10,
                height: 2,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: _appTheme.separatorColor),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    _itemTapped(2);
                  },
                  child: accountButton()),
              SizedBox(
                width: 10,
                height: 2,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: _appTheme.separatorColor),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    _itemTapped(3);
                  },
                  child: bankButton()),
              SizedBox(
                width: 10,
                height: 2,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: _appTheme.separatorColor),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    _itemTapped(4);
                  },
                  child: academicButton()),
            ],
          ),
        ),
      ],
    );
  }
}