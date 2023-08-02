import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:texno_bozor/data/firebase/orders_service.dart';
import 'package:texno_bozor/data/models/order/order_model.dart';
import 'package:texno_bozor/data/models/universal_data.dart';
import 'package:texno_bozor/utils/ui_utils/loading_dialog.dart';

class OrderProvider with ChangeNotifier {
  OrderProvider({required this.orderService}) {
    listenOrders(FirebaseAuth.instance.currentUser!.uid);
  }

  final OrderService orderService;
  List<OrderModel> userOrders = [];

  Future<void> addOrder({
    required BuildContext context,
    required OrderModel orderModel,
  }) async {
    List<OrderModel> exists = userOrders
        .where((element) => element.productId == orderModel.productId)
        .toList();

    OrderModel? oldOrderModel;
    if (exists.isNotEmpty) {
      oldOrderModel = exists.first;
      oldOrderModel = oldOrderModel.copWith(
          count: orderModel.count + oldOrderModel.count,
          totalPrice:
              (orderModel.count + oldOrderModel.count) * orderModel.totalPrice);
    }

    showLoading(context: context);
    UniversalData universalData = exists.isNotEmpty
        ? await orderService.updateOrder(orderModel: oldOrderModel!)
        : await orderService.addOrder(orderModel: orderModel);

    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, universalData.data as String);
        Navigator.pop(context);
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  Future<void> updateOrder({
    required BuildContext context,
    required OrderModel orderModel,
  }) async {
    showLoading(context: context);

    UniversalData universalData =
        await orderService.updateOrder(orderModel: orderModel);

    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, universalData.data as String);
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  Future<void> deleteOrder({
    required BuildContext context,
    required String orderId,
  }) async {
    showLoading(context: context);
    UniversalData universalData =
        await orderService.deleteOrder(orderId: orderId);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, universalData.data as String);
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  Stream<List<OrderModel>> listenOrdersList(String? uid) async* {
    if (uid == null) {
      yield* FirebaseFirestore.instance.collection("orders").snapshots().map(
            (event1) => event1.docs
                .map((doc) => OrderModel.fromJson(doc.data()))
                .toList(),
          );
    } else {
      yield* FirebaseFirestore.instance
          .collection("orders")
          .where("userId", isEqualTo: uid)
          .snapshots()
          .map(
            (event1) => event1.docs
                .map((doc) => OrderModel.fromJson(doc.data()))
                .toList(),
          );
    }
  }

  listenOrders(String userId) async {
    listenOrdersList(userId).listen((List<OrderModel> orders) {
      userOrders = orders;
      debugPrint("CURRENT USER ORDERS LENGTH:${userOrders.length}");
      notifyListeners();
    });
  }

  showMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    notifyListeners();
  }
}
