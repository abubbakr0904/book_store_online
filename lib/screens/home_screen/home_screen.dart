import 'package:book_store_online/screens/detail_screen/dateil_screen.dart';
import 'package:book_store_online/utils/images/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/file_bloc.dart';
import '../../bloc/file_state.dart';
import '../../data/models/file_model/file_model.dart';
import '../../data/models/repository/file_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            margin : EdgeInsets.only(top: 64 , left: 32 , bottom : 24),
            child : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome" , style: TextStyle(
                  color : Colors.black.withOpacity(0.8),
                  fontSize: 14,
                  fontFamily: AppImages.fontPoppins,
                  fontWeight: FontWeight.w500
                ),),
                const Text("imyour_universe" , style: TextStyle(
                  color : Colors.black,
                  fontSize: 18,
                  fontFamily: AppImages.fontPoppins,
                  fontWeight: FontWeight.w700
                ),),
              ],
            ),
          ),
          SizedBox(
            child : TextField(
              decoration: InputDecoration(
                hintText: "Search for books...",
                hintStyle: const TextStyle(
                  color : Color(0xFF979797),
                  fontFamily: AppImages.fontPoppins,
                  fontWeight: FontWeight.w400,
                  fontSize: 18
                ),
                prefixIcon: IconButton(onPressed: (){}, icon: Icon(
                  Icons.search,
                  color : const Color(0xFF29BB89)
                )),
                focusedBorder: OutlineInputBorder(
                  borderSide : const BorderSide(
                    width: 0.5,
                    color : Colors.black
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide : BorderSide(
                        width: 0.5,
                        color : Colors.black
                    ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            )
          ),
          const SizedBox(height: 32,),
          const Text("Category" , style: TextStyle(
              color : Colors.black,
              fontSize: 18,
              fontFamily: AppImages.fontPoppins,
              fontWeight: FontWeight.w700
          ),),
          Wrap(
            children: [
               ...List.generate(categories.length, (index) => Container(
                 padding: const EdgeInsets.symmetric(vertical: 13 , horizontal: 9),
                 margin: EdgeInsets.only(right: 5 , bottom: 5),
                 decoration: BoxDecoration(
                   color : const Color(0xFFF1F1F1),
                   borderRadius: BorderRadius.circular(20)
                 ),
                 child: Text(categories[index] , style: const TextStyle(
                   color : Colors.black,
                   fontSize: 14,
                   fontWeight: FontWeight.w400,
                   fontFamily: AppImages.fontPoppins,
                 ),),
               ))
            ],
          ),
          const SizedBox(height: 33,),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Kitoblar" , style: TextStyle(
                color : Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontFamily: AppImages.fontPoppins,
              ),),
              Text("View all" , style: TextStyle(
                color : Color(0xFF29BB89),
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontFamily: AppImages.fontPoppins,
              ),),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  context.read<FileRepository>().files.length,
                      (index) {
                    FileDataModel fileDataModel =
                    context.read<FileRepository>().files[index];
            
                    FileManagerBloc fileManagerBloc = FileManagerBloc();
            
                    return BlocProvider.value(
                      value: fileManagerBloc,
                      child: BlocBuilder<FileManagerBloc, FileManagerState>(
                        builder: (context, state) {
                          debugPrint("CURRENT MB: ${state.progress}");
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, CupertinoPageRoute(builder: (context)=>DetailScreen(fileDataModel: FileDataModel(fileName: fileDataModel.fileName , fileUrl: fileDataModel.fileUrl , iconPath: fileDataModel.iconPath))));
                            },
                            child: Container(
                              width: 125,
                              height: 210,
                              child: Stack(
                                children: [
                                  Padding(
                                    padding:EdgeInsets.only(right: 20 , top: 10),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                            child: Image.network(fileDataModel.iconPath , width: 120, height: 140, fit : BoxFit.cover),
                                            borderRadius: BorderRadius.circular(10),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          width : 120,
                                          child: Text(fileDataModel.fileName , style: const TextStyle(
                                            color : Colors.black,
                                            fontFamily: AppImages.fontPoppins,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14
                                          ),
                                          maxLines: 2,
                                          textAlign: TextAlign.center,),
                                        )
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible:  state.newFileLocation.isEmpty
                                        ? true
                                        : false,
                                    child: Container(
                                      width: 105,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color : Colors.white.withOpacity(0.6)
                                      ),
                                      child : const Center(
                                        child: Icon(
                                          Icons.download_for_offline_outlined,
                                          color : Colors.white,
                                          size: 80,
                                        ),
                                      )
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          const SizedBox(height: 33,),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Kitoblar" , style: TextStyle(
                color : Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontFamily: AppImages.fontPoppins,
              ),),
              Text("View all" , style: TextStyle(
                color : Color(0xFF29BB89),
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontFamily: AppImages.fontPoppins,
              ),),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  context.read<FileRepository>().files.length,
                      (index) {
                    FileDataModel fileDataModel =
                    context.read<FileRepository>().files[index];

                    FileManagerBloc fileManagerBloc = FileManagerBloc();

                    return BlocProvider.value(
                      value: fileManagerBloc,
                      child: BlocBuilder<FileManagerBloc, FileManagerState>(
                        builder: (context, state) {
                          debugPrint("CURRENT MB: ${state.progress}");
                          return GestureDetector(
                            child: Container(
                              width: 125,
                              height: 210,
                              child: Stack(
                                children: [
                                  Padding(
                                    padding:EdgeInsets.only(right: 20 , top: 10),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          child: Image.network(fileDataModel.iconPath , width: 120, height: 140, fit : BoxFit.cover),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          width : 120,
                                          child: Text(fileDataModel.fileName , style: const TextStyle(
                                              color : Colors.black,
                                              fontFamily: AppImages.fontPoppins,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14
                                          ),
                                            maxLines: 2,
                                            textAlign: TextAlign.center,),
                                        )
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible:  state.newFileLocation.isEmpty
                                        ? true
                                        : false,
                                    child: Container(
                                        width: 105,
                                        height: 150,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color : Colors.white.withOpacity(0.6)
                                        ),
                                        child : const Center(
                                          child: Icon(
                                            Icons.download_for_offline_outlined,
                                            color : Colors.white,
                                            size: 80,
                                          ),
                                        )
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          )


        ],
      ),
    );
  }
}
List<String> categories = [
  "Motivation & Inspiration",
  "Sains",
  "Fantasi",
  "Kesehatan& Nutrisi",
  "Komik & Grafis",
  "Horror",
  "Psikologi",
  "Edukasi",
  "Uang & Investasi"
];