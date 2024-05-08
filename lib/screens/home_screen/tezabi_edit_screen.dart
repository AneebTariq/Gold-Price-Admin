import 'package:admin_app/controller/product_editing_controller.dart';
import 'package:admin_app/widgets/custom_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';

// ignore: must_be_immutable
class TezabiPieceEditScreen extends StatelessWidget {
  TezabiPieceEditScreen({super.key});
  ProductEditingController productController=Get.put(ProductEditingController());
  final database=FirebaseDatabase.instance.ref('tezabi');

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  Text('tezabi'.tr,style: AppTextStyles.font24TextStyle.copyWith(color: AppColors.buttonClr),),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: productController.tSellController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'sell'.tr,
            ),
          ),
          TextField(
            controller: productController.tBuyController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'buy'.tr,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            productController.dispose();
          },
          child: Text('cancel'.tr,style: AppTextStyles.font14_600TextStyle.copyWith(color: AppColors.black),),
        ),
        SizedBox(
          width: 130.w,
          child: CustomButton(
            text: 'save'.tr,
            buttonColor: AppColors.buttonClr,
            onTap: (){
              String id=DateTime.now().millisecondsSinceEpoch.toString();
              database.child(id).set({
                'id':id,
                'date':'${DateTime.now()}',
                'tezabi_sell_price': productController.tSellController.text,
                'tezabi_buy_price': productController.tBuyController.text,
              }).then((value) {
                Get.snackbar('Sucess', 'Data Added Sucessfuly');
              }).onError((error, stackTrace) {
                print("this is exception in tezabi::: $error,$stackTrace");
              });
              productController.sendNotifications('Tezabi Pieces','check New Price for Tezabi');
              Get.back();
            },
          ),
        ),
      ],
    );
  }
}
