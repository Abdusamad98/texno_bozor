import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:texno_bozor/data/models/order/order_model.dart';
import 'package:texno_bozor/data/models/universal_data.dart';

class OrderService {
  Future<UniversalData> addOrder({required OrderModel orderModel}) async {
    try {
      DocumentReference newCategory = await FirebaseFirestore.instance
          .collection("orders")
          .add(orderModel.toJson());

      await FirebaseFirestore.instance
          .collection("orders")
          .doc(newCategory.id)
          .update({"orderId": newCategory.id});

      return UniversalData(data: "Order added!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> updateOrder({required OrderModel orderModel}) async {
  print("INSIDE UPDATE: ${orderModel.orderId}");
   try {
      await FirebaseFirestore.instance
          .collection("orders")
          .doc(orderModel.orderId)
          .update(
            orderModel.toJson(),
          );

      return UniversalData(data: "Order updated!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> deleteOrder({required String orderId}) async {
    try {
      await FirebaseFirestore.instance
          .collection("orders")
          .doc(orderId)
          .delete();

      return UniversalData(data: "Order deleted!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }
}
