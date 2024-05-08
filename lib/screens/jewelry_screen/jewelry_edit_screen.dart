import 'package:admin_app/utils/image_assets.dart';
import 'package:admin_app/widgets/custom_appbar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/product_editing_controller.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_button.dart';

// ignore: must_be_immutable
class JewelryEditScreen extends StatefulWidget {
   const JewelryEditScreen({
    super.key,
    required this.edit,
    this.images,
    this.name,
    this.weight,
     this.crt,
     this.id,
  });
  final bool edit;
  final List? images;
  final String? name;
  final String? weight;
  final String? crt;
  final String? id;

  @override
  State<JewelryEditScreen> createState() => _JewelryEditScreenState();
}

class _JewelryEditScreenState extends State<JewelryEditScreen> {
  ProductEditingController productController = Get.put(ProductEditingController());

  final jewelryRef = FirebaseDatabase.instance.ref('Jewelry');

  @override
  Widget build(BuildContext context) {
    if(widget.edit){
      productController.savedImages=widget.images!;
    }
    return WillPopScope(
      onWillPop: ()async {
       productController.savedImages.clear();
       return true ;
      },
      child: Scaffold(
        appBar: RoundedAppBar(
          title: widget.edit ? 'edit_jewelry'.tr : 'add_jewelry'.tr,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 200.h,
                  width: 400.w,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: productController.savedImages.length,
                      itemBuilder: (context,index){
                    return Padding(
                      padding:  EdgeInsets.only(right: 10.w),
                      child: SizedBox(
                          height: 200.h,
                          width: 400.w,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network('${productController.savedImages[index]}',fit: BoxFit.cover,))),
                    );
                  }),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomButton(
                  text: 'add_image'.tr,
                  buttonColor: AppColors.buttonClr,
                  onTap: () {
                    showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                        ),
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10.h,
                                ),
                                Center(
                                  child: Container(
                                    height: 3.h,
                                    width: 47.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text(
                                  'Upload Image',
                                  style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryColor),
                                ),
                                SizedBox(
                                  height: 28.h,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    productController.pickImage();
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 82.h,
                                    width: double.infinity,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      border: Border.all(
                                        color: AppColors.buttonClr,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 50.h,
                                          width: 50.w,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.primaryColor,
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: const Offset(1, 10),
                                                  blurRadius: 0,
                                                  spreadRadius: 0,
                                                  color: AppColors.black
                                                      .withOpacity(0.1),
                                                )
                                              ]),
                                          child: Center(
                                              child: Image.asset(
                                            ImageAssets.uploadIcon,
                                            height: 23.h,
                                            width: 26.w,
                                            color: AppColors.white,
                                          )),
                                        ),
                                        SizedBox(
                                          width: 16.w,
                                        ),
                                        Text(
                                          'Upload from your mobile',
                                          style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 22.h,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    productController.takeImage();
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 82.h,
                                    width: double.infinity,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      border: Border.all(
                                        color: AppColors.buttonClr,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 50.h,
                                          width: 50.w,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.primaryColor,
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: const Offset(1, 10),
                                                  blurRadius: 0,
                                                  spreadRadius: 0,
                                                  color: AppColors.black
                                                      .withOpacity(0.1),
                                                )
                                              ]),
                                          child: Center(
                                              child: Image.asset(
                                                ImageAssets.uploadIcon,
                                            height: 20.h,
                                            width: 26.w,
                                                color: AppColors.white,
                                          )),
                                        ),
                                        SizedBox(
                                          width: 16.w,
                                        ),
                                        Text(
                                          'Take a picture, use camera',
                                          style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                ),
                SizedBox(
                  height: 16.h,
                ),
                TextField(
                  controller: productController.nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'product_name'.tr,
                    hintText: widget.edit ? "${widget.name}" : 'neckless',
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextField(
                  controller: productController.crtController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'carat_gold'.tr,
                    hintText: widget.edit ? "${widget.crt}" : '18',
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextField(
                  controller: productController.weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'weight'.tr,
                    hintText: widget.edit ? "${widget.weight}" : '18g',
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                widget.edit==false?
                CustomButton(
                  text:'save'.tr,
                  buttonColor: AppColors.buttonClr,
                  onTap: () {
                    String id=DateTime.now().millisecondsSinceEpoch.toString();
                    jewelryRef.child(id).set({
                      'id':id,
                      'imageUrls': productController.savedImages,
                      'name': productController.nameController.text,
                      'crt':productController.crtController.text,
                      'weight': productController.weightController.text,
                    });
                    Get.snackbar('success','jewelry added successfully');
                    productController.sendNotifications('Jewelry Update','check out our New Jewelry ${productController.nameController.text}');
                    productController.savedImages.clear();
                    productController.dispose();
                    setState(() {});
                  },
                )
                :CustomButton(
                  text:'update'.tr,
                  buttonColor: AppColors.buttonClr,
                  onTap: () {
                    jewelryRef.child('${widget.id}').set({
                      'id':widget.id,
                      'imageUrls': productController.savedImages==widget.images?widget.images:productController.savedImages,
                      'name': productController.nameController.text==widget.name?widget.name:productController.nameController.text,
                      'crt':productController.crtController.text==widget.crt?widget.crt:productController.crtController.text,
                      'weight': productController.weightController.text==widget.weight?widget.weight:productController.weightController.text,
                    });
                    Get.snackbar('Updated','jewelry Updated successfully');
                    productController.savedImages.clear();
                    productController.dispose();
                    productController.sendNotifications('Jewelry Update','check New Update for ${widget.name}');
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
