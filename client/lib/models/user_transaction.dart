// ignore_for_file: constant_identifier_names

import 'package:client/helpers/decimal_formatter.dart';
import 'package:client/models/admin.dart';
import 'package:client/models/user_detail_transaction.dart';
import 'package:client/providers/diohttp.dart';
import 'package:flutter/material.dart';

enum PaymentMethod { Cash, CreditCard, DebitCard }

enum Status { OnGoing, Pending, Rejected, Verified, Finished }

class UserTransaction {
  final String? id;
  final String userId;
  final PaymentMethod? paymentMethod;
  final String? paymentProof;
  final String? paymentDate;
  final num total;
  final Status status;
  final Admin? verifiedBy;
  final DateTime? verifiedAt;
  final DateTime createdAt;
  final String? deliveryAddress;
  final List<UserDetailTransaction>? detailTransactions;

  const UserTransaction({
    this.id,
    required this.userId,
    this.paymentMethod,
    this.paymentProof,
    this.paymentDate,
    required this.total,
    required this.status,
    this.verifiedBy,
    this.verifiedAt,
    required this.createdAt,
    this.deliveryAddress,
    this.detailTransactions = const [],
  });

  get transactionDate => createdAt.toString().split(' ')[0];
  get verifiedDate => verifiedAt.toString().split(' ')[0];
  get formattedTotal => formatNumber(total);

  String get imageUrl {
    // print(paymentProof.runtimeType);
    // print(paymentProof);
    if (paymentProof == null) {
      return '';
    }

    if (paymentProof!.startsWith('http')) {
      return paymentProof!;
    } else {
      return 'http://$ipv4/polinema-smt5-mobile-uas/server/public/storage/images/payment_proof/$paymentProof';
    }
  }

  ImageProvider get imageProviderWidget {
    if (paymentProof == null) {
      return const AssetImage('assets/images/car1_MustangGT.jpg');
    }
    return NetworkImage(imageUrl);
  }

  factory UserTransaction.fromJson(dynamic json) {
    try {
      final id = json['id'].toString();
      // print("id ${id}");
      final userId = json['user_id'].toString();
      // print("userId ${userId}");
      final paymentMethod = json['payment_method'] != null
          ? PaymentMethod.values.byName(
              json['payment_method'],
            )
          : null;
      // print("paymentMethod ${paymentMethod}");

      final paymentProof = json['payment_proof']?.toString() ?? '';
      // print("paymentProof ${paymentProof}");
      final paymentDate = json['payment_date']?.toString() ?? '';
      // print("paymentDate ${paymentDate}");
      final total = json['total'];
      // print("total ${total}");
      final status = Status.values.byName(
        json['status'],
      );
      // print("status ${status}");
      final verifiedBy = json['verified_by'] != null
          ? Admin.fromJson(json['verified_by'])
          : null;
      // print("verifiedBy ${verifiedBy}");
      final verifiedAt = DateTime.tryParse(json['verified_at'].toString());
      // print("verifiedAt ${verifiedAt}");
      final createdAt = DateTime.parse(json['created_at'].toString());
      // print("createdAt ${createdAt}");
      final detailTransactions = json['detail_transactions'] as List<dynamic>;
      // print("detailTransactions ${detailTransactions}");
      final deliveryAddress = json['delivery_address']?.toString() ?? '';
      // print("deliveryAddress ${deliveryAddress}");
      final userDetailTransactions = detailTransactions.map(
        (detailTransaction) {
          // print("detailTransaction ${detailTransaction}");
          return UserDetailTransaction.fromJson(detailTransaction);
        },
      ).toList();
      // print("userDetailTransactions ${userDetailTransactions}");
      final userTransaction = UserTransaction(
        id: id,
        userId: userId,
        paymentMethod: paymentMethod,
        paymentProof: paymentProof,
        paymentDate: paymentDate,
        total: total,
        status: status,
        verifiedBy: verifiedBy,
        verifiedAt: verifiedAt,
        createdAt: createdAt,
        deliveryAddress: deliveryAddress,
        detailTransactions: userDetailTransactions,
      );

      return userTransaction;
    } catch (e) {
      // print(e);
      throw Exception('Failed to parse UserTransaction from JSON');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'payment_method': paymentMethod?.name,
      'payment_proof': paymentProof,
      'payment_date': paymentDate,
      'total': total,
      'status': status.name,
      'verified_by': verifiedBy?.toJson(),
      'verified_at': verifiedAt.toString(),
      'created_at': createdAt.toString(),
      'delivery_address': deliveryAddress,
      'detail_transactions':
          detailTransactions?.map((e) => e.toJson()).toList(),
    };
  }

  // try {
  //   print('JSON');
  //   print(json);
  //   final id = json['id'].toString();
  //   final userId = json['user_id'].toString();
  //   final paymentMethod = PaymentMethod.values.byName(
  //     json['payment_method'].toString(),
  //   );
  //   final paymentProof = json['payment_proof'].toString();
  //   final paymentDate = json['payment_date'].toString();
  //   final total = json['total'].toString();
  //   final status = Status.values.byName(
  //     json['status'].toString(),
  //   );
  //   final verifiedBy = Admin.fromJson(json['verified_by']);
  //   final verifiedAt = DateTime.parse(json['status'].toString());
  //   final createdAt = DateTime.parse(json['created_at'].toString());

  //   final userTransaction = UserTransaction(
  //     id: id,
  //     userId: userId,
  //     paymentMethod: paymentMethod,
  //     paymentProof: paymentProof,
  //     paymentDate: paymentDate,
  //     total: total,
  //     status: status,
  //     verifiedBy: verifiedBy,
  //     verifiedAt: verifiedAt,
  //     createdAt: createdAt,
  //   );

  //   return userTransaction;
  // } catch (e) {
  //   print(e);
  // }
}
