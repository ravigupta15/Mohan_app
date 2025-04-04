import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mohan_impex/core/widget/app_search_bar.dart';
import 'package:mohan_impex/core/widget/app_text_button.dart';
import 'package:mohan_impex/core/widget/custom_app_bar.dart';
import 'package:mohan_impex/data/datasources/local_share_preference.dart';
import 'package:mohan_impex/features/home_module/digital_marking_collaterals/riverpod/digital_marking_state.dart';
import 'package:mohan_impex/res/app_asset_paths.dart';
import 'package:mohan_impex/res/app_cashed_network.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:mohan_impex/res/loader/show_loader.dart';
import 'package:mohan_impex/res/no_data_found_widget.dart';
import 'package:mohan_impex/utils/message_helper.dart';
import 'package:open_file/open_file.dart';
import 'package:share_plus/share_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:pdfx/pdfx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;


class DigitalMarkingCollateralsScreen extends ConsumerStatefulWidget {
  const DigitalMarkingCollateralsScreen({super.key});

  @override
  ConsumerState<DigitalMarkingCollateralsScreen> createState() => _DigitalMarkingCollateralsScreenState();
}

class _DigitalMarkingCollateralsScreenState extends ConsumerState<DigitalMarkingCollateralsScreen> {
  PdfDocument? pdfDocument;
  // String fileUrl = "";
  ImageProvider? pdfImage;
   ScrollController _scrollController = ScrollController();
@override
  void initState() {
    Future.microtask((){
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction(){
    final refNotifier = ref.read(digitalMarkingProvider.notifier);
    refNotifier.resetValues();
       _scrollController.addListener(_scrollListener);
    refNotifier.digitalMarkingApiFunction();
  }
 
 @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final state = ref.watch(digitalMarkingProvider);
    final notifier = ref.read(digitalMarkingProvider.notifier);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Trigger the API to fetch the next page of data
      if ((state.digitalMarkingModel?.data?[0].records?.length ?? 0) <
          int.parse(
              (state.digitalMarkingModel?.data?[0].totalCount ?? 0).toString())) {
        notifier.digitalMarkingApiFunction(isLoadMore: true);
      }
    }
  }

ReceivePort port = ReceivePort();
String downloadStatus = '';
   callDownloaderFunction() {
     IsolateNameServer.registerPortWithName(
         port.sendPort, 'downloader_send_port');
         port.listen((dynamic data) {
       int progress = data[2];
       print("progress...$progress");
       if (progress < 99 && progress > 1) {
         downloadStatus = 'running';
       } else if (progress > 99) {
         downloadStatus = 'completed';
         MessageHelper.showToast('downloading finished...',);
         // Platform.isAndroid?
         // FlutterDownloader.open(taskId: tas);
         // launchURL(pdfUrl.value);
       } else {
         downloadStatus = '';
       }
       setState(() {});
     });
     FlutterDownloader.registerCallback(downloadCallback);
   }

   @pragma('vm:entry-point')
   static void downloadCallback(String id, int status, int progress) {
     final SendPort? send =
     IsolateNameServer.lookupPortByName('downloader_send_port');
     send!.send([id, status, progress]);
   }

 @override
  Widget build(BuildContext context) {
    final refState = ref.watch(digitalMarkingProvider);
    final refNotifier = ref.read(digitalMarkingProvider.notifier);
    return Scaffold(
    appBar: customAppBar(title: "Marketing Collaterals"),
     body: Padding(
      padding: const EdgeInsets.only(top: 14),
     child: Column(
      children: [
          Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: AppSearchBar(
                  hintText: "Search by collateral name",
                  onChanged: refNotifier.onChangedSearch,
                  suffixWidget: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: SvgPicture.asset(AppAssetPaths.searchIcon),
                  ),
                ),
              ),
              Expanded(
                child:  refState.isLoading?
              shimmerList(): (refState.digitalMarkingModel?.data?[0].records?.length??0)>0?
                 ListView.separated(
                  separatorBuilder: (ctx,sb){
                    return const SizedBox(height: 15,);
                  },
                   controller: _scrollController,
                itemCount: (refState.digitalMarkingModel?.data?[0].records?.length??0),
                padding: EdgeInsets.all(16),
                shrinkWrap: true,
                itemBuilder: (context,index){
                  var model =refState.digitalMarkingModel?.data?[0].records?[index];
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 0),
                              color: AppColors.black.withValues(alpha: .2),
                              blurRadius: 2
                            )
                          ]
                        ),
                        // padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15,top: 15,right: 15),
                              child: 
                              AppNetworkImage(imgUrl:model?.thumbnailImage??'',
                              boxFit: BoxFit.cover,borderRadius: 10,
                              ),),
                            const SizedBox(height: 12,),
                            Container(
                              height: 1,
                              width: double.infinity,
                              color: AppColors.edColor,
                            ),
                            const SizedBox(height: 7,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(model?.name??"",
                                  style: TextStyle(
                                    fontSize: 14,fontFamily: AppFontfamily.poppinsMedium,
                                  ),
                                  ),
                                  Container(
                                    height: 17,width: 40,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.greenColor,width: .5
                                      ),
                                      borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Text(model?.fileType??'',style: TextStyle(
                                      fontFamily: AppFontfamily.poppinsMedium, fontSize: 10
                                    ),),
                                  )
                                ],
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(15),
                            child: buttonWidget(
                              shareTap: (){
                                print('object');
                                downloadAndShareImage(model?.productAttachment ?? '',model?.fileType ??'').then((val){
                                  if(val!=null){
                                    Share.shareXFiles([XFile(val)]);
                                  }
                                });
                              },
                              downloadTap: ()async
                            {
                              downloadAndShareImage(model?.productAttachment ?? '', model?.fileType ??'').then((val)async{
                                if(val!=null){
                                  final result = await OpenFile.open(val);
                                }
                              });
                              //  downloadAndShareImage(model?.productAttachment ?? '', model?.fileType ??'');
                              // MessageHelper.showToast("Not implemented");
                              //  downloadImageCount = imgIndex;
                                // String dir = (await getApplicationDocumentsDirectory()).path;
                                // await FlutterDownloader.enqueue(
                                //   url: ("${model?.productAttachment??''}?token=${LocalSharePreference.token}"),
                                //   headers: {}, // optional: header send with url (auth token etc)
                                //   savedDir: Platform.isAndroid
                                //       ? '/storage/emulated/0/Download/'
                                //       : "$dir/",
                                //   showNotification: true,
                                //   openFileFromNotification: true,
                                //   saveInPublicStorage: true,
                                // );
                               
                      
                            }),
                            ),
                          ],
                        ),
                      ),
                      index ==
                                  (refState.digitalMarkingModel?.data?[0].records
                                              ?.length ??
                                          0) -
                                      1 &&
                              refState.isLoadingMore
                          ? Container(
                              padding: const EdgeInsets.all(4),
                              width: 37,
                              height: 37,
                              child: const CircularProgressIndicator(
                                strokeWidth: 3,
                              ),
                            )
                          : SizedBox.fromSize()
                    ],
                  );
              }): NoDataFound(title: "No marking collaterals found"))
      ],
     ),
     ),

    );
  }

  shimmerList(){
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        separatorBuilder: (ctx,sb){
          return const SizedBox(height: 15,);
        },
        itemCount: 4,
        shrinkWrap: true,
        itemBuilder: (context,index){
        return Container(
           decoration: BoxDecoration(
            color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 0),
                          color: AppColors.black.withValues(alpha: .2),
                          blurRadius: 2
                        )
                      ]
                    ),
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Image.asset('assets/dummy/slider.png'),
                        const SizedBox(height: 10,),
                        Container(
                          height: 1,
                          width: double.infinity,
                          color: AppColors.edColor,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("product"),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.greenColor,width: .5
                                ),
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Text("Jpg"),
                            )
                          ],
                        ),
                        const SizedBox(height: 15,),
                        buttonWidget(
                          shareTap: (){
                        
                          }
                        )
                      ],
                    ),
        );
      }),
    );
  }

  buttonWidget({Function()?downloadTap,Function()?shareTap,}){
    return        Row(
                          children: [
                            Expanded(child:
                            AppTextButton(title: "Download",color: AppColors.arcticBreeze, height: 28,width: double.infinity,onTap: downloadTap,)),
                            const SizedBox(width: 6,),
                            AppTextButton(title: "Share",color: AppColors.arcticBreeze,
                            width: 90,onTap: shareTap,height: 28,
                            )
                          ],
                        );
  }

Future downloadAndShareImage(String imgUrl,String filetype) async {
  print("imafe...$imgUrl");
    try {
      ShowLoader.loader(context);
      final response = await http.get(Uri.parse(imgUrl),headers: {
    'Authorization':"Bearer ${LocalSharePreference.token}"  
  });
  ShowLoader.hideLoader();
      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();
        if(filetype.toLowerCase() == 'pdf'){
          final imagePath = '${directory.path}/downloaded_image.pdf';
        final file = File(imagePath);
        await file.writeAsBytes(response.bodyBytes);
        return imagePath;
        }
        else if(filetype.toLowerCase() == 'video'){
          final imagePath = '${directory.path}/downloaded_image.mp4';
        final file = File(imagePath);
        await file.writeAsBytes(response.bodyBytes);
        return imagePath;
        }
        else if(filetype.toLowerCase() == 'mp3'){
          final imagePath = '${directory.path}/downloaded_image.mp3';
        final file = File(imagePath);
        await file.writeAsBytes(response.bodyBytes);
        return imagePath;
        }
        else{
          final imagePath = '${directory.path}/downloaded_image.png';
        final file = File(imagePath);
        await file.writeAsBytes(response.bodyBytes);
        return imagePath;
        }
      } else {
        print('Failed to download image.');
      }
    } catch (e) {
      ShowLoader.hideLoader();
      print('Error: $e');
    }
  }

}