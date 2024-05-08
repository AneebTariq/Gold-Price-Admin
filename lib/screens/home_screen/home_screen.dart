import 'package:admin_app/controller/product_editing_controller.dart';
import 'package:admin_app/screens/home_screen/ary_piece_edit_screen.dart';
import 'package:admin_app/screens/home_screen/tezabi_edit_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/auth_controller.dart';
import '../../models/response_models/gold_live_price_model.dart';
import '../../services/notification_services.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/image_assets.dart';
import '../../widgets/custom_appbar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductEditingController productEditingController=Get.put(ProductEditingController());
  AuthController authController = Get.put(AuthController());
  final aryRef=FirebaseDatabase.instance.ref('ary');
  final tezabiRef=FirebaseDatabase.instance.ref('tezabi');
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value){
      if (kDebugMode) {
        print('device token');
        print(value);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: AppColors.white,
      appBar: RoundedAppBar(
        height: 80.h,
        titleWidget: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('admin'.tr,style: AppTextStyles.font20TextStyle.copyWith(color: AppColors.white)),
            Container(
              width: 143.w,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppColors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(()=> InkWell(
                    onTap:(){
                      authController.isEnglish.value=true;
                      authController.isUrdu.value=false;
                      authController.onChangeLanguage('en');
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 8.h),
                      decoration: BoxDecoration(
                        color:authController.isEnglish.value?AppColors.primaryColor:AppColors.transparentColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(' English',style: AppTextStyles.font14_400TextStyle.copyWith(color:authController.isEnglish.value?AppColors.white:AppColors.black),),
                        ],
                      ),
                    ),
                  ),
                  ),
                  Obx(
                        ()=> InkWell(
                      onTap:(){
                        authController.isEnglish.value=false;
                        authController.isUrdu.value=true;
                        authController.onChangeLanguage('urdu');
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 8.h),
                        decoration: BoxDecoration(
                          color: authController.isUrdu.value?AppColors.primaryColor:AppColors.transparentColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(' Urdu',style: AppTextStyles.font14_400TextStyle.copyWith(color:authController.isUrdu.value?AppColors.white:AppColors.black),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 22.h,),
              Center(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),
                  decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [AppColors.buttonClr,AppColors.primaryColor],
                  begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                    borderRadius:  BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('today_price'.tr,style: AppTextStyles.font20TextStyle.copyWith(color: AppColors.white),),
                          Text('${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}',style: AppTextStyles.font20TextStyle.copyWith(color: AppColors.white),),
                        ],
                      ),
                      SizedBox(height: 30.h,),
                      StreamBuilder<GoldLivePriceModel>(
                      stream: productEditingController.goldPriceController.stream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else if (snapshot.hasData) {
                          return Center(
                            child: Text(
                              '\$ ${productEditingController.goldModel.price}',
                              style: AppTextStyles.font36TextStyle.copyWith(color: AppColors.white),
                            ),
                          );
                        } else {
                          return const Center(
                            child: Text('No data available'),
                          );
                        }
                      },
                    ),
                      SizedBox(height: 20.h,),
                       Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          productEditingController.goldModel.updatedAtReadable!=null? 'Updated ${productEditingController.goldModel.updatedAtReadable}':'Updated',
                          textAlign: TextAlign.right,
                          style: AppTextStyles.font16TextStyle
                              .copyWith(color: AppColors.white),
                        ),
                      ],
                    ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h,),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [AppColors.buttonClr,AppColors.primaryColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius:  const BorderRadius.only(topRight: Radius.circular(50),bottomLeft:Radius.circular(50) ),
                ),
                child: Center(child: Text('gold_rates'.tr,style: AppTextStyles.font24TextStyle.copyWith(color: AppColors.white),)),
              ),
              SizedBox(height: 20.h,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('ary_piece'.tr,style: AppTextStyles.font24TextStyle.copyWith(color: AppColors.buttonClr),),
                IconButton(
                    onPressed: (){
                      showDialog(
                          context: context,
                          builder: (context){
                        return  AryPieceEditScreen();
                      });
                    },
                    icon: Icon(Icons.edit,size: 20,color: AppColors.black,)),
              ],
            ),
              SizedBox(height: 10.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.primaryColor),
                    ),
                    child: Column(
                      children: [
                        Text('sell'.tr,style: AppTextStyles.font18_700TextStyle.copyWith(color: AppColors.primaryColor),),
                        SizedBox(height: 20.h,),
                        Image.asset(ImageAssets.splash,height: 80.h,width: 130.w,),
                        SizedBox(height: 20.h,),
                        StreamBuilder(
                          stream: aryRef.onValue,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator(); // Show loading indicator while data is loading
                            }
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            if (!snapshot.hasData || snapshot.data?.snapshot.value == null) {
                              return Text('No data available');
                            }
                            final Map<dynamic, dynamic>? rawData = snapshot.data?.snapshot.value as Map<dynamic, dynamic>?;

                            if (rawData == null) {
                              return Text('Data not available');
                            }
                            final Map<String, dynamic> data = rawData.cast<String, dynamic>();
                            List<dynamic> sellPrice=[];
                            sellPrice=data.values.toList();
                            return Text(
                              '\$ ${sellPrice.last['ary_sell_price']}', // Displaying 'ary_sell_price'
                              style: AppTextStyles.font18_700TextStyle.copyWith(color: AppColors.primaryColor),
                            );

                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.primaryColor),
                    ),
                    child: Column(
                      children: [
                        Text('buy'.tr,style: AppTextStyles.font18_700TextStyle.copyWith(color: AppColors.primaryColor),),
                        SizedBox(height: 20.h,),
                        Image.asset(ImageAssets.splash,height: 80.h,width: 130.w,),
                        SizedBox(height: 20.h,),
                        StreamBuilder(
                          stream: aryRef.onValue,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator(); // Show loading indicator while data is loading
                            }
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            if (!snapshot.hasData || snapshot.data?.snapshot.value == null) {
                              return Text('No data available');
                            }
                            final Map<dynamic, dynamic>? rawData = snapshot.data?.snapshot.value as Map<dynamic, dynamic>?;
                            if (rawData == null) {
                              return Text('Data not available');
                            }
                            final Map<String, dynamic> data = rawData.cast<String, dynamic>();
                            List<dynamic> sellPrice=[];
                            sellPrice=data.values.toList();
                            return Text(
                              '\$ ${sellPrice.last['ary_buy_price']}', // Displaying 'ary_sell_price'
                              style: AppTextStyles.font18_700TextStyle.copyWith(color: AppColors.primaryColor),
                            );

                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('tezabi'.tr,style: AppTextStyles.font24TextStyle.copyWith(color: AppColors.buttonClr),),
                  IconButton(
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (context){
                              return  TezabiPieceEditScreen();
                            });
                      },
                      icon: Icon(Icons.edit,size: 20,color: AppColors.black,)),
                ],
              ),
              SizedBox(height: 10.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.primaryColor),
                    ),
                    child: Column(
                      children: [
                        Text('sell'.tr,style: AppTextStyles.font18_700TextStyle.copyWith(color: AppColors.primaryColor),),
                        SizedBox(height: 20.h,),
                        Image.asset(ImageAssets.splash,height: 80.h,width: 130.w,),
                        SizedBox(height: 20.h,),
                        StreamBuilder(
                          stream: tezabiRef.onValue,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator(); // Show loading indicator while data is loading
                            }
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            if (!snapshot.hasData || snapshot.data?.snapshot.value == null) {
                              return Text('No data available');
                            }
                            final Map<dynamic, dynamic>? rawData = snapshot.data?.snapshot.value as Map<dynamic, dynamic>?;

                            if (rawData == null) {
                              return Text('Data not available');
                            }
                            final Map<String, dynamic> data = rawData.cast<String, dynamic>();
                            List<dynamic> sellPrice=[];
                            sellPrice=data.values.toList();
                            return Text(
                              '\$ ${sellPrice.last['tezabi_sell_price']}', // Displaying 'ary_sell_price'
                              style: AppTextStyles.font18_700TextStyle.copyWith(color: AppColors.primaryColor),
                            );

                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.primaryColor),
                    ),
                    child: Column(
                      children: [
                        Text('buy'.tr,style: AppTextStyles.font18_700TextStyle.copyWith(color: AppColors.primaryColor),),
                        SizedBox(height: 20.h,),
                        Image.asset(ImageAssets.splash,height: 80.h,width: 130.w,),
                        SizedBox(height: 20.h,),
                        StreamBuilder(
                          stream: tezabiRef.onValue,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator(); // Show loading indicator while data is loading
                            }
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            if (!snapshot.hasData || snapshot.data?.snapshot.value == null) {
                              return Text('No data available');
                            }
                            final Map<dynamic, dynamic>? rawData = snapshot.data?.snapshot.value as Map<dynamic, dynamic>?;

                            if (rawData == null) {
                              return Text('Data not available');
                            }
                            final Map<String, dynamic> data = rawData.cast<String, dynamic>();
                            List<dynamic> sellPrice=[];
                            sellPrice=data.values.toList();
                            return Text(
                              '\$ ${sellPrice.last['tezabi_buy_price']}', // Displaying 'ary_sell_price'
                              style: AppTextStyles.font18_700TextStyle.copyWith(color: AppColors.primaryColor),
                            );

                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h,),
            ],
          ),
        )
      ),
    );
  }
}
