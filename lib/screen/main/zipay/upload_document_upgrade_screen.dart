import 'dart:convert';

import 'package:alhikmah_app/bloc/util/bloc.dart';
import 'package:alhikmah_app/data/constants.dart';
import 'package:alhikmah_app/util/image_util.dart';
import 'package:alhikmah_app/util/screen_util.dart';
import 'package:alhikmah_app/util/validate_helper.dart';
import 'package:alhikmah_app/widget/custom_appbar_detail.dart';
import 'package:alhikmah_app/widget/custom_button_outline.dart';
import 'package:alhikmah_app/widget/custom_button_raised.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class UploadDocumentUpgradeScreen extends StatefulWidget {
  UploadDocumentUpgradeScreen({Key key}) : super(key: key);

  @override
  _UploadDocumentUpgradeScreenState createState() =>
      _UploadDocumentUpgradeScreenState();
}

class _UploadDocumentUpgradeScreenState
    extends State<UploadDocumentUpgradeScreen> {
  final _screen = ScreenUtil();
  UtilBloc _utilBloc;
  String _photo = '';
  String base64 = '';
  UploadDocumentArguments args;

  @override
  void initState() {
    super.initState();
    _utilBloc = BlocProvider.of<UtilBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    return BlocListener<UtilBloc, UtilState>(
      listener: (context, state) {
        if (state is UploadConvertSuccessState) {
          base64 = state.data.data.base64WithoutType;
          EasyLoading.dismiss();
        } else if (state is UploadConvertFailedState) {
          EasyLoading.dismiss();
        }
      },
      child: BlocBuilder<UtilBloc, UtilState>(
        builder: (context, state) {
          return CustomAppBarDetail(
            title: 'Upload Dokumen',
            body: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: _screen.widthDefault(context) / 16),
              child: ListView(
                children: [
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  Container(
                    height: _screen.heightDefault(context) / 3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        image: DecorationImage(
                            image: !ValidateHelper.isEmpty(_photo)
                                ? MemoryImage(base64Decode(_photo))
                                : AssetImage(Images.PLACEHOLDER),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(height: _screen.heightDefault(context) / 40),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButtonOutline(
                            title: 'Upload',
                            onTap: () {
                              ImageUtil().postImageCamera((file) {
                                // Navigator.pop(context);
                                setState(() {
                                  _photo = base64Encode(file.readAsBytesSync());
                                });
                                EasyLoading.show(
                                  status: 'Loading...',
                                  maskType: EasyLoadingMaskType.black,
                                );
                                _utilBloc.add(UploadConvertEvent(
                                    file: file));
                                return;
                              });
                            }
                            // _showOptionsUpload(context, args.category),
                            ),
                      ),
                      SizedBox(width: _screen.widthDefault(context) / 16),
                      Expanded(
                        child: CustomButtonRaised(
                          title: 'Simpan',
                          isCompleted: this.base64.isNotEmpty,
                          onTap: () => Navigator.pop(context, base64),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showOptionsUpload(BuildContext context, String category) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              height: _screen.heightDefault(context) / 5.5,
              child: Column(children: <Widget>[
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Take a picture from camera'),
                  onTap: () {
                    ImageUtil().postImageCamera((file) {
                      Navigator.pop(context);
                      setState(() {
                        _photo = base64Encode(file.readAsBytesSync());
                      });
                      _utilBloc.add(
                          UploadPrivateEvent(file: file, category: category));
                      return;
                    });
                  },
                ),
                ListTile(
                    onTap: () {
                      ImageUtil().postImageGallery((file) {
                        Navigator.pop(context);
                        setState(() {
                          _photo = base64Encode(file.readAsBytesSync());
                        });
                        _utilBloc.add(
                            UploadPrivateEvent(file: file, category: category));
                        return;
                      });
                    },
                    leading: Icon(Icons.photo_library),
                    title: Text('Choose from photo library'))
              ]));
        });
  }
}

class UploadDocumentArguments {
  final String category;

  UploadDocumentArguments(this.category);
}
