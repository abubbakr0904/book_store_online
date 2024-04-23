import 'dart:io';

import 'package:book_store_online/data/models/file_model/file_model.dart';
import 'package:book_store_online/utils/images/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_filex/open_filex.dart';

import '../../bloc/file_bloc.dart';
import '../../bloc/file_event.dart';
import '../../bloc/file_state.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.fileDataModel});

  final FileDataModel fileDataModel;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  FileManagerBloc fileManagerBloc = FileManagerBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<FileManagerBloc, FileManagerState>(
          builder: (context, state) {
            return Stack(
              children: [
                Image.network(widget.fileDataModel.iconPath , width: double.infinity,height: MediaQuery.of(context).size.height,fit : BoxFit.cover),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  color : Colors.white.withOpacity(0.8),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Back",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                fontFamily: AppImages.fontPoppins,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        ClipRRect(
                          child: Image.network(widget.fileDataModel.iconPath,
                              width: 250, height: 300, fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        SizedBox(height: 20),
                        Text(
                          widget.fileDataModel.fileName,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.w400,
                            fontFamily: AppImages.fontPoppins,
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                              5,
                              (index) => const Icon(
                                    Icons.star,
                                    color: Color(0xFF29BB89),
                                    size: 20,
                                  )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 200,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xFF29BB89)),
                              onPressed: () async{
                                if (state.newFileLocation.isEmpty) {
                                  print("mana");
                                  print(state.progress);
                                  fileManagerBloc.add(
                                    DownloadFileEvent(
                                      fileDataModel: widget.fileDataModel,
                                    ),
                                  );
                                } else {
                                  await OpenFilex.open(state.newFileLocation);
                                }
                              },
                              child: const Text(
                                "Save",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: AppImages.fontPoppins,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 30),
                              )),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Visibility(
                          visible: state.newFileLocation.isEmpty
                              ? false
                              : true,
                          child: LinearProgressIndicator(
                            borderRadius: BorderRadius.circular(50),
                            value: state.progress,
                            backgroundColor: const Color(0xFF29BB89).withOpacity(0.4),
                            color: const Color(0xFF29BB89),
                          ),
                        ),
                        SizedBox(height: 50,)
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
