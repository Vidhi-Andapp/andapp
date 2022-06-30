import 'package:andapp/common/app_theme.dart';
import 'package:andapp/common/pink_border_button.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/screen/dashboard/document_bloc.dart';
import 'package:andapp/screen/registration/posp_registration.dart';
import 'package:flutter/material.dart';
import 'package:andapp/common/image_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';


class DocumentPage extends StatefulWidget {
  const DocumentPage({Key? key}) : super(key: key);

  @override
  State<DocumentPage> createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  final DocumentBloc _bloc = DocumentBloc();
  int _selectedTile = 1;

  @override
  initState() {
    _bloc.mainStreamController.sink.add(
        _selectedTile);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _appTheme = AppTheme.of(context);
    return SafeArea(
      child: Scaffold(
        //appBar: AppBar(),
        //backgroundColor: const Color(0xff222222),
        body: SingleChildScrollView(
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 48, bottom: 32.0),
                        child: Center(child: Column(
                          children: const [
                            Text(
                                StringUtils.getReady,
                                style: TextStyle(fontSize: 24)),
                            Text(
                                StringUtils.withDoc,
                                style: TextStyle(fontSize: 24)),
                          ],
                        ),
                        )
                    ),

                    Expanded(
                      child: StreamBuilder(
                          stream: _bloc.mainStream,
                          builder: (context, snapshot) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              //Add CrossAxisAlignment.stretch
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8),
                                  child: Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.white, width: 0.8),
                                        borderRadius: BorderRadius.circular(
                                            8)),
                                    //Wrap with IntrinsicHeight
                                    child:
                                    ListTile(
                                      onTap: () {
                                        _selectedTile = 1;
                                        _bloc.mainStreamController.sink.add(
                                            _selectedTile);
                                      },
                                      leading: Container(
                                        height: 48,
                                        width: 48,
                                        decoration: ShapeDecoration(
                                            shape: CircleBorder(
                                                side: BorderSide(
                                                    color: (_selectedTile == 1
                                                        ? _appTheme
                                                        .primaryColor
                                                        : Colors.white))),
                                            color: (_selectedTile == 1
                                                ? _appTheme.primaryColor
                                                : Colors.white)),
                                        child: SvgPicture.asset(
                                          SvgImages.iconKYCDetails,
                                          color: _selectedTile == 1 ? Colors
                                              .white : _appTheme
                                              .primaryColor,),
                                        padding: const EdgeInsets.all(10),
                                      ),
                                      contentPadding: const EdgeInsets.all(
                                          10),
                                      horizontalTitleGap: 12,
                                      title: const Padding(
                                        padding: EdgeInsets.only(bottom: 4.0),
                                        child: Text(StringUtils.kycDetails,
                                          style: TextStyle(fontSize: 16,
                                              fontWeight: FontWeight.w700),),
                                      ),
                                      subtitle: const Text(
                                        StringUtils.kycDetailsDes,
                                        style: TextStyle(fontSize: 14,
                                            fontWeight: FontWeight.w400),),
                                      trailing: _selectedTile == 1
                                          ? SizedBox(
                                          height: double.infinity,
                                          child: SvgPicture.asset(
                                            SvgImages.iconApprove, height: 20,
                                            width: 20,
                                            alignment: Alignment.topRight,))
                                          : const SizedBox(width: 20,),
                                    ),

                                    /*Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: Column(
                                                children: const [
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                    child: Text("KYC Details",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                    child: Text("Share your Aadhaar Details as address proof.",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            */
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8),
                                  child: Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.white, width: 0.8),
                                        borderRadius: BorderRadius.circular(
                                            8)),
                                    //Wrap with IntrinsicHeight
                                    child:
                                    ListTile(
                                      onTap: () {
                                        _selectedTile = 2;
                                        _bloc.mainStreamController.sink.add(
                                            _selectedTile);
                                      },
                                      leading: Container(
                                        height: 48,
                                        width: 48,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: (_selectedTile == 2
                                                ? _appTheme.primaryColor
                                                : Colors.white)),
                                        //ShapeDecoration(shape: CircleBorder(side: BorderSide(color: (selectedTile == 1 ? _appTheme.primaryColor : Colors.white))),color: (selectedTile == 1 ? _appTheme.primaryColor : Colors.white)),
                                        child: SvgPicture.asset(
                                          SvgImages.iconAcDetails,
                                          color: _selectedTile == 2 ? Colors
                                              .white : _appTheme
                                              .primaryColor,),
                                        padding: const EdgeInsets.all(10),
                                      ),
                                      contentPadding: const EdgeInsets.all(
                                          10),
                                      horizontalTitleGap: 12,
                                      title: const Padding(
                                        padding: EdgeInsets.only(bottom: 4.0),
                                        child: Text(StringUtils.acDetails,
                                          style: TextStyle(fontSize: 16,
                                              fontWeight: FontWeight.w700),),
                                      ),
                                      subtitle: const Text(
                                        StringUtils.acDetailsDes,
                                        style: TextStyle(fontSize: 14,
                                            fontWeight: FontWeight.w400),),
                                      trailing: _selectedTile == 2
                                          ? SizedBox(
                                          height: double.infinity,
                                          child: SvgPicture.asset(
                                            SvgImages.iconApprove, height: 20,
                                            width: 20,
                                            alignment: Alignment.topRight,))
                                          : const SizedBox(width: 20,),
                                    ),

                                    /*Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: Column(
                                                children: const [
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                    child: Text("KYC Details",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                    child: Text("Share your Aadhaar Details as address proof.",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            */
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8),
                                  child: Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.white, width: 0.8),
                                        borderRadius: BorderRadius.circular(
                                            8)),
                                    //Wrap with IntrinsicHeight
                                    child:
                                    ListTile(
                                      onTap: () {
                                        _selectedTile = 3;
                                        _bloc.mainStreamController.sink.add(
                                            _selectedTile);
                                      },
                                      leading: Container(
                                        height: 48,
                                        width: 48,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: (_selectedTile == 3
                                                ? _appTheme.primaryColor
                                                : Colors.white)),
                                        //ShapeDecoration(shape: CircleBorder(side: BorderSide(color: (selectedTile == 1 ? _appTheme.primaryColor : Colors.white))),color: (selectedTile == 1 ? _appTheme.primaryColor : Colors.white)),
                                        child: SvgPicture.asset(
                                          SvgImages.iconBankDetails,
                                          color: _selectedTile == 3 ? Colors
                                              .white : _appTheme
                                              .primaryColor,),
                                        padding: const EdgeInsets.all(10),
                                      ),
                                      contentPadding: const EdgeInsets.all(
                                          10),
                                      horizontalTitleGap: 12,
                                      title: const Padding(
                                        padding: EdgeInsets.only(bottom: 4.0),
                                        child: Text(StringUtils.bankDetails,
                                          style: TextStyle(fontSize: 16,
                                              fontWeight: FontWeight.w700),),
                                      ),
                                      subtitle: const Text(
                                        StringUtils.bankDetailsDes,
                                        style: TextStyle(fontSize: 14,
                                            fontWeight: FontWeight.w400),),
                                      trailing: _selectedTile == 3
                                          ? SizedBox(
                                          height: double.infinity,
                                          child: SvgPicture.asset(
                                            SvgImages.iconApprove, height: 20,
                                            width: 20,
                                            alignment: Alignment.topRight,))
                                          : const SizedBox(width: 20,),
                                    ),

                                    /*Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: Column(
                                                children: const [
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                    child: Text("KYC Details",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                    child: Text("Share your Aadhaar Details as address proof.",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            */
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8),
                                  child: Card(
                                    elevation: 2,

                                    //Wrap with IntrinsicHeight
                                    child:
                                    ListTile(
                                      onTap: () {
                                        _selectedTile = 4;
                                        _bloc.mainStreamController.sink.add(
                                            _selectedTile);
                                      },
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: _selectedTile == 4
                                                  ? Colors.white
                                                  : Colors.white, width: 0.8),
                                          borderRadius: BorderRadius.circular(
                                              8)),
                                      leading: Container(
                                        height: 48,
                                        width: 48,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: (_selectedTile == 4
                                                ? _appTheme.primaryColor
                                                : Colors.white)),
                                        //ShapeDecoration(shape: CircleBorder(side: BorderSide(color: (selectedTile == 1 ? _appTheme.primaryColor : Colors.white))),color: (selectedTile == 1 ? _appTheme.primaryColor : Colors.white)),
                                        child: SvgPicture.asset(
                                          SvgImages.iconAcademicDetails,
                                          color: _selectedTile == 4 ? Colors
                                              .white : _appTheme
                                              .primaryColor,),
                                        padding: const EdgeInsets.all(10),
                                      ),
                                      contentPadding: const EdgeInsets.all(
                                          10),
                                      horizontalTitleGap: 12,
                                      title: const Padding(
                                        padding: EdgeInsets.only(bottom: 4.0),
                                        child: Text(
                                          StringUtils.academicDetails,
                                          style: TextStyle(fontSize: 16,
                                              fontWeight: FontWeight.w700),),
                                      ),
                                      subtitle: const Text(
                                        StringUtils.academicDetailsDes,
                                        style: TextStyle(fontSize: 14,
                                            fontWeight: FontWeight.w400),),
                                      trailing: _selectedTile == 4
                                          ? SizedBox(
                                          height: double.infinity,
                                          child: SvgPicture.asset(
                                            SvgImages.iconApprove, height: 20,
                                            width: 20,
                                            alignment: Alignment.topRight,))
                                          : const SizedBox(width: 20,),
                                    ),

                                    /*Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: Column(
                                                children: const [
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                    child: Text("KYC Details",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                    child: Text("Share your Aadhaar Details as address proof.",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            */
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),

                    Row(
                      children: [
                        SvgPicture.asset(
                          SvgImages.iconSecurity, height: 25,
                          width: 20,),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0),
                            child: Text(
                              "IRDAI requires above details to register. This details are secured and will be used for application process only.",
                              style: TextStyle(fontSize: 11,
                                  fontWeight: FontWeight.w400),
                              maxLines: 3,),
                          ),
                        ),
                      ],
                    ),

                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 12.0),
                        child: PinkBorderButton(
                          isEnabled: true,
                          content: "Next",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return const PoSPRegistration();
                              }),
                            );
                          },)
                    ),
                  ]
              ),
            ),
          ),
        ),
        /*StreamBuilder(
          stream: _bloc.mainStream,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return Container();
          },
        ),*/
      ),
    );
  }
}
