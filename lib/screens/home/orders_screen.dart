import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:khana_sabailai_admin/controllers/order_controller.dart';
import 'package:khana_sabailai_admin/models/order.dart';
import 'package:khana_sabailai_admin/utils/decoration.dart';
import 'package:khana_sabailai_admin/utils/status.dart';
import 'package:khana_sabailai_admin/widgets/order_row.dart';
import 'package:khana_sabailai_admin/widgets/status_text.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  alertEvent(onConfirm, context, onCancel, title, content) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              ElevatedButton(
                child: const Text('Yes'),
                onPressed: () {
                  onConfirm();
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  onCancel();
                },
                child: const Text('No', style: TextStyle(color: Colors.white)),
              )
            ],
          );
        });
  }

  SlidableAction customActionPane(
      {onPressed,
      icon,
      label,
      backgroundColor,
      foregroundColor = Colors.black}) {
    return SlidableAction(
      onPressed: (a) {
        onPressed();
      },
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      icon: icon,
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Orders'),
          actions: [
            IconButton(
              onPressed: () {
                controller.fetchOrders();
              },
              icon: const Icon(Icons.refresh),
            )
          ],
        ),
        body: DefaultTabController(
          length: 2,
          child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TabBar(
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Color(0xff020578),
                          tabs: [
                            Tab(text: 'Today'),
                            Tab(text: 'All Orders'),
                          ],
                        ),
                        Expanded(
                            child: TabBarView(
                          children: [true, false]
                              .map((e) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      if (e == false)
                                        SingleChildScrollView(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              DropdownWidget(
                                                  label: 'Restaurant',
                                                  value: controller
                                                      .restaurantStatus,
                                                  items: controller
                                                      .getAllRestaurantNames(),
                                                  onChanged: (val) {
                                                    controller
                                                            .restaurantStatus =
                                                        val.toString();
                                                    controller.update();
                                                  }),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              DropdownWidget(
                                                  label: 'Status',
                                                  value: controller.orderStatus,
                                                  items: controller
                                                      .getAllOrderStatus(),
                                                  onChanged: (val) {
                                                    controller.orderStatus =
                                                        val.toString();
                                                    controller.update();
                                                  }),
                                            ],
                                          ),
                                        ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children:
                                                controller
                                                        .getTodayOrders(e)
                                                        .isEmpty
                                                    ? [
                                                        const SizedBox(
                                                          height: 400,
                                                          child: Center(
                                                            child: Text(
                                                                'No orders found'),
                                                          ),
                                                        )
                                                      ]
                                                    : controller
                                                        .getTodayOrders(e)
                                                        .map((e) => Slidable(
                                                              direction: Axis
                                                                  .horizontal,
                                                              endActionPane:
                                                                  ActionPane(
                                                                      extentRatio:
                                                                          0.8,
                                                                      motion:
                                                                          const ScrollMotion(),
                                                                      children: [
                                                                    if (e.status ==
                                                                        OrderStatus
                                                                            .pending)
                                                                      customActionPane(
                                                                          onPressed:
                                                                              () {
                                                                            alertEvent(
                                                                                () {
                                                                              controller.changeOrderStatus(OrderStatus.cancelled, e.id);
                                                                              Navigator.pop(context);
                                                                            },
                                                                                context,
                                                                                () {},
                                                                                'Cancel Order',
                                                                                'Are you sure you want to cancel this order?\n You won\'t be refunded.');
                                                                          },
                                                                          icon: Icons
                                                                              .cancel,
                                                                          label:
                                                                              'Cancel',
                                                                          foregroundColor: Colors
                                                                              .white,
                                                                          backgroundColor:
                                                                              Colors.red),
                                                                    if (e.status ==
                                                                        OrderStatus
                                                                            .pending)
                                                                      customActionPane(
                                                                          onPressed:
                                                                              () {
                                                                            alertEvent(
                                                                                () {
                                                                              controller.changeOrderStatus(OrderStatus.preparing, e.id);
                                                                              Navigator.pop(context);
                                                                            },
                                                                                context,
                                                                                () {},
                                                                                'Preparing Order',
                                                                                'Change order status to preparing?');
                                                                          },
                                                                          icon: Icons
                                                                              .check,
                                                                          label:
                                                                              'Preparing',
                                                                          foregroundColor: Colors
                                                                              .white,
                                                                          backgroundColor:
                                                                              Colors.green),
                                                                    if (e.status ==
                                                                        OrderStatus
                                                                            .preparing)
                                                                      customActionPane(
                                                                          onPressed:
                                                                              () {
                                                                            alertEvent(
                                                                                () {
                                                                              controller.changeOrderStatus(OrderStatus.completed, e.id);
                                                                              Navigator.pop(context);
                                                                            },
                                                                                context,
                                                                                () {},
                                                                                'Complete Order',
                                                                                'Change order status to completed?');
                                                                          },
                                                                          icon: Icons
                                                                              .check,
                                                                          label:
                                                                              'Completed',
                                                                          foregroundColor: Colors
                                                                              .white,
                                                                          backgroundColor:
                                                                              Colors.green),
                                                                  ]),
                                                              child: OrderCard(
                                                                  order: e),
                                                            ))
                                                        .toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                              .toList(),
                        ))
                      ],
                    )),
        ),
      );
    });
  }
}

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order: #${order.id}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    order.date!,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Total: Rs. ${order.totalCost}',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  StatusText(
                    status: order.status!,
                  ),
                  Text(
                    'Paid: ${order.isPaid == '1' ? 'Yes' : 'No'}',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: Color(0xff000000),
                    ),
                    softWrap: false,
                  ),
                ],
              ),
            ],
          ),
          const Text(
            'Restaurant: Almonds',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ...order.orderLines!
              .map((e) => OrderRow(
                    orderLines: e,
                  ))
              .toList()
        ],
      ),
    );
  }
}

class DropdownWidget extends StatelessWidget {
  const DropdownWidget(
      {super.key,
      required this.label,
      required this.value,
      required this.items,
      required this.onChanged});

  final String label;
  final String value;
  final List<LabelValue> items;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: const Color(0xffffffff),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: Color(0x29000000),
                offset: Offset(0, 3),
                blurRadius: 6,
              ),
            ],
          ),
          child: DropdownButton(
            underline: Container(),
            value: value,
            items: items
                .map((e) => DropdownMenuItem(
                      value: e.value,
                      child: Text(e.label),
                    ))
                .toList(),
            onChanged: (value) {
              onChanged(value);
            },
          ),
        ),
      ],
    );
  }
}
