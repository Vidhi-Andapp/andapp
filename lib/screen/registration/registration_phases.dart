import 'package:andapp/common/app_theme.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/common/tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;
import '../../common/image_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class RegistrationPhases extends StatefulWidget {
  final int? index;
  const RegistrationPhases({Key? key,@required this.index}) : super(key: key);

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

  Widget kycButton() {
    return Card(
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
    width: (MediaQuery.of(context).size.width - 80) / 4,
    height: ((MediaQuery.of(context).size.width - 80) / 4) - 8,
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
    );
  }

  Widget accountButton() {
    return Card(
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
          width: (MediaQuery.of(context).size.width - 80) / 4,
          height: ((MediaQuery.of(context).size.width - 80) / 4) - 8,
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
    );
  }

  Widget bankButton() {
    return Card(
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
          width: (MediaQuery.of(context).size.width - 80) / 4,
          height: ((MediaQuery.of(context).size.width - 80) / 4) - 8,
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
    );
  }

  Widget academicButton() {
    return Card(
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
          width: (MediaQuery.of(context).size.width - 80) / 4,
          height: ((MediaQuery.of(context).size.width - 80) / 4) - 8,
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
    );
  }

  final AppThemeState _appTheme = AppThemeState();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 8, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap : (){
                  setState(() { currIndex = 1; });
                },
                  child: kycButton()),
              SizedBox(width: 12,height: 2,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: _appTheme.separatorColor
                  ),
                ),),
              GestureDetector(
                  onTap : (){
                    setState(() { currIndex = 2; });
                  },
                  child: accountButton()),
              SizedBox(width: 12,height: 2,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: _appTheme.separatorColor
                  ),
                ),),
              GestureDetector(
                  onTap : (){
                    setState(() { currIndex = 3; });
                  },
                  child: bankButton()),
              SizedBox(width: 12,height: 2,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: _appTheme.separatorColor
                  ),
                ),),
              GestureDetector(
                  onTap : (){
                    setState(() { currIndex = 4; });
                  },
                  child: academicButton()),
            ],
          ),
        ),
      ],
    );
  }
}