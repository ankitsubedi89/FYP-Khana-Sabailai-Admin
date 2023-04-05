import 'package:flutter/material.dart';
import 'package:khana_sabailai_admin/utils/status.dart';

getOrderStatus(status) {
  switch (status) {
    case OrderStatus.pending:
      return {'status': 'Pending', 'color': Colors.blue};
    case OrderStatus.preparing:
      return {'status': 'Preparing', 'color': Colors.amber};
    case OrderStatus.completed:
      return {'status': 'Completed', 'color': Colors.green};
    case OrderStatus.cancelled:
      return {'status': 'Cancelled', 'color': Colors.red};
    default:
      return {'status': 'Pending', 'color': Colors.blue};
  }
}
