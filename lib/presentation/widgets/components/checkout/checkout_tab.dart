import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_washer/presentation/cubits/rider/rider_cubit.dart';
import 'package:laundry_washer/presentation/screens/extension/check_out_verification_screen.dart';

import '../../../../dependency.dart';
import '../../../cubits/bookings/bookings_cubit.dart';
import '../../custom/custom_empty_container.dart';
import '../../custom/custom_table_header.dart';
import 'checkout_dataheader.dart';
import 'checkout_datatable.dart';

class CheckoutTab extends StatefulWidget {
  const CheckoutTab({super.key});

  @override
  State<CheckoutTab> createState() => _CheckoutTabState();
}

class _CheckoutTabState extends State<CheckoutTab> {
  int loads = 0;
  int kg = 0;
  int qty = 0;
  List<String> bookingUids = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingsState>(
      builder: (context, state) {
        if (state is BookingsLoaded) {
          final bookings =
              state.bookings.where((element) => element.bookingStatus == 5);
          return bookings.isNotEmpty
              ? Column(
                  children: [
                    const CustomTableHeader(
                      title: 'CHECK OUT',
                      subTitle: 'Check out list here',
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: bookings.map(
                            (e) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (ctx) => MultiBlocProvider(
                                            providers: [
                                              BlocProvider<RiderCubit>(
                                                create: (context) =>
                                                    sl<RiderCubit>()
                                                      ..streamRiders(),
                                              ),
                                              BlocProvider.value(
                                                value: context
                                                    .read<BookingCubit>(),
                                              )
                                            ],
                                            child: CheckOutVerificationScreen(
                                              e: e,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    splashColor: Theme.of(context).primaryColor,
                                    child: CheckoutDataTable(
                                      e: e,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                    const CheckoutDataHeader(),
                  ],
                )
              : const CustomEmptyContainer();
        } else if (state is BookingsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is BookingsEmpty) {
          return const CustomEmptyContainer();
        }
        return const SizedBox();
      },
    );
  }
}
