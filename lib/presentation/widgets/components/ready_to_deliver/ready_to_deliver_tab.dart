import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/service/print.dart';
import 'package:general/widgets/text.dart';

import '../../../../domain/entity/booking_entity.dart';
import '../../../cubits/bookings/bookings_cubit.dart';
import '../../custom/custom_datatable.dart';
import '../../custom/custom_dialog.dart';
import '../../custom/custom_empty_container.dart';
import '../../custom/custom_selection_button.dart';
import '../main/mainscreen_label_container.dart';
import '../tabs/pickup_tab.dart';

class ReadyToDeliverTab extends StatefulWidget {
  final TextEditingController searchProductController;

  const ReadyToDeliverTab({
    super.key,
    required this.searchProductController,
  });

  @override
  State<ReadyToDeliverTab> createState() => _ReadyToDeliverTabState();
}

class _ReadyToDeliverTabState extends State<ReadyToDeliverTab> {
  int loads = 0;
  int kg = 0;
  int qty = 0;
  List<String> bookingUids = [];
  @override
  Widget build(BuildContext context) {
    return PickUpTab(
      title: 'WASH IN PROGRESS',
      subTitle: 'Wash in progress items here',
      loads: loads,
      kg: kg,
      qty: qty,
      searchProductController: widget.searchProductController,
      bookingUids: bookingUids,
      dataTable: BlocBuilder<BookingCubit, BookingsState>(
        builder: (context, state) {
          if (state is BookingsLoaded) {
            final bookings =
                state.bookings.where((element) => element.bookingStatus == 4);
            return bookings.isNotEmpty
                ? Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: bookings.map((e) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {});
                                      e.isSelected = !e.isSelected!;
                                      if (e.isSelected ?? false) {
                                        bookingUids.add(e.uid ?? '');
                                        kg += e.kg ?? 0;
                                        qty += e.quantity ?? 0;
                                        loads += e.load;
                                        e.isSelected = true;
                                      } else if (!e.isSelected!) {
                                        bookingUids.remove(e.uid);
                                        loads -= e.load;
                                        kg -= e.kg ?? 0;
                                        qty -= e.quantity ?? 0;
                                      }
                                    },
                                    splashColor: Theme.of(context).primaryColor,
                                    child: CustomDataTable(
                                      e: e,
                                      isSelected: !e.isSelected!,
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const MainScreenLabelContainer(),
                    ],
                  )
                : const CustomEmptyContainer();
          } else if (state is BookingsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BookingsEmpty) {
            return const CustomEmptyContainer();
          } else {
            return const SizedBox();
          }
        },
      ),
      builder: (BuildContext context) {
        List<BookingEntity> bookings = [];
        final bookingState = context.watch<BookingCubit>().state;
        if (bookingState is BookingsLoaded) {
          bookings.addAll(bookingState.bookings);
        }
        return CustomSelectionButton(
          successTitle: 'COMPLETE & READY TO DELIVER',
          successColor: Colors.green.shade400,
          onClear: () {
            bookingUids.isEmpty
                ? ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).primaryColor,
                      content: const CustomText(
                        'Nothing to clear in this area',
                        color: Colors.white,
                      ),
                    ),
                  )
                : showDialog(
                    context: context,
                    builder: (ctx) {
                      return CustomDialog(
                        title: 'Are you sure?',
                        cancelTitle: 'Cancel',
                        successTitle: 'Clear all',
                        onTap: () {
                          for (var element in bookings) {
                            if (element.isSelected!) {
                              element.isSelected = false;
                              setState(() {});
                              kg = 0;
                              qty = 0;
                              loads = 0;
                              bookingUids.clear();
                            }
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                          }
                        },
                        content:
                            'Make sure to check double before\nclicking the clear all button.',
                      );
                    },
                  );
          },
          onTap: () {
            show('bookingUids: $bookingUids');
            bookingUids.isEmpty
                ? ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).primaryColor,
                      content: const CustomText(
                        'Nothing to complete in this area',
                        color: Colors.white,
                      ),
                    ),
                  )
                : showDialog(
                    context: context,
                    builder: (ctx) {
                      return CustomDialog(
                        title: 'Are you sure',
                        cancelTitle: 'Cancel',
                        successTitle: 'Proceed',
                        onTap: () {
                          context
                              .read<BookingCubit>()
                              .updateBookingStatus(bookingUids, 5);
                          for (var element in bookings) {
                            if (element.isSelected!) {
                              element.isSelected = false;
                              setState(() {});
                              kg = 0;
                              qty = 0;
                              loads = 0;
                              bookingUids.clear();
                            }
                          }
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                        },
                        content:
                            'Make sure to check double before\nclicking the button',
                      );
                    },
                  );
          },
        );
      },
    );
  }
}
