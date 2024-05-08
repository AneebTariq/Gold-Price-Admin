import 'package:admin_app/controller/product_editing_controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../models/response_models/jewelry_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_appbar.dart';
import 'jewelry_edit_screen.dart';

class JewelryScreen extends StatelessWidget {
  JewelryScreen({super.key});
  ProductEditingController productController = Get.put(ProductEditingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.buttonClr,
        onPressed: () {
          Get.to(() => const JewelryEditScreen(
                edit: false,
              ));
        },
        child: Icon(
          Icons.add,
          size: 20,
          color: AppColors.white,
        ),
      ),
      appBar: RoundedAppBar(
        height: 80.h,
        title: 'jewelry'.tr,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 22.h,
              ),
              StreamBuilder(
                stream: FirebaseDatabase.instance
                    .reference()
                    .child('Jewelry')
                    .onValue,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    // Extract data from the snapshot
                    Map<dynamic, dynamic>? jewelryData =
                        snapshot.data?.snapshot.value;
                    if (jewelryData != null) {
                      // Convert the map to a list of jewelry items
                      List<JewelryItem> jewelryList = jewelryData.entries
                          .map((entry) =>
                              JewelryItem.fromMap(entry.key, entry.value))
                          .toList();

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: jewelryList.length,
                        itemBuilder: (BuildContext context, int index) {
                          // Build your UI using the jewelry items
                          return Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: Container(
                              // padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                border:
                                    Border.all(color: AppColors.primaryColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 200.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          jewelryList[index].imageUrls?.first??'',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              Get.to(()=>  JewelryEditScreen(
                                                edit: true,
                                                id: jewelryList[index].id,
                                                images:  jewelryList[index].imageUrls,
                                                crt:  jewelryList[index].crt,
                                                weight:  jewelryList[index].weight,
                                                name:  jewelryList[index].name,
                                              ));
                                            },
                                            icon: Icon(
                                              Icons.edit,
                                              size: 20,
                                              color: AppColors.red,
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              productController.deleteItem('${jewelryList[index].id}');
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              size: 20,
                                              color: AppColors.red,
                                            )),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Center(
                                    child: Text(
                                      jewelryList[index].name??'name',
                                      style: AppTextStyles.font14_600TextStyle
                                          .copyWith(
                                              color: AppColors.primaryColor),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    child: Text(
                                      '${jewelryList[index].crt}ct Gold',
                                      style: AppTextStyles.font14_600TextStyle
                                          .copyWith(
                                              color: AppColors.primaryColor),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'weight'.tr,
                                        style: AppTextStyles.font16TextStyle.copyWith(color: AppColors.primaryColor),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: ': ${jewelryList[index].weight}g',
                                            style: AppTextStyles.font16TextStyle,
                                          ),
                                        ],
                                      ),
                                    ),

                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }
                  // Show loading indicator or error message if data is not available
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
