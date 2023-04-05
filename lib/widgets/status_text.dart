import 'package:flutter/cupertino.dart';
import 'package:khana_sabailai_admin/utils/getOrderStatus.dart';

class StatusText extends StatelessWidget {
  const StatusText({super.key, this.status = 'Pending'});

  final String status;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            color: getOrderStatus(status)['color'],
            borderRadius:
                const BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          getOrderStatus(status)['status'],
          style: const TextStyle(
            fontSize: 14,
          ),
        )
      ],
    );
  }
}
