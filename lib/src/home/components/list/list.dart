import 'package:cloudwalknasa/components/animations/load.dart';
import 'package:cloudwalknasa/components/apod_card.dart';
import 'package:cloudwalknasa/components/pagination.dart';
import 'package:cloudwalknasa/models/apod.dart';
import 'package:flutter/material.dart';

import 'bloc.dart';

import 'package:intl/intl.dart';

extension DateTimeRangeFormatter on DateTimeRange {
  String formatDates() {
    final dateFormat = DateFormat('d MMM. yy', 'pt_BR');
    final startDate = dateFormat.format(start);
    final endDate = dateFormat.format(end);
    return '$startDate - $endDate';
  }
}

class ListViewPage extends StatefulWidget {
  const ListViewPage({super.key});

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  BlocListImages bloc = BlocListImages();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: bloc.refreshFetchActual,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                SearchBar(
                    onChanged: bloc.updateSearchQuery,
                    leading: const Icon(Icons.search, color: Colors.white70),
                    hintText: "Search for a title",
                    hintStyle: MaterialStateProperty.all(
                        const TextStyle(color: Colors.white54)),
                    trailing: [
                      IconButton(
                        icon: const Icon(Icons.calendar_month,
                            color: Colors.white),
                        onPressed: () {
                          // show a date picker where user will need to pick 2 dates, initial and final
                          // the final can be null, if user wants to search for a single date
                          // after user picks the dates, the bloc will update the list
                          showDateRangePicker(
                            context: context,
                            // first image from APOD
                            firstDate: DateTime(1995, 6, 16),
                            lastDate: DateTime.now(),
                          ).then(bloc.fetchListImages);
                        },
                      )
                    ]),
                const SizedBox(height: 8),
                Expanded(
                  child: StreamBuilder<bool>(
                    stream: bloc.isLoading,
                    builder: (context, snapshot) {
                      if (!(snapshot.data ?? false)) {
                        return StreamBuilder<List<Apod?>?>(
                            stream: bloc.pagedImages,
                            builder: (context, snapshot) {
                              return ListView.builder(
                                itemCount: snapshot.data?.length ?? 0,
                                itemBuilder: (context, index) {
                                  Apod apod = snapshot.data![index]!;
                                  final date = DateFormat('dd/MM/yyyy')
                                      .format(DateTime.parse(apod.date));
                                  return ApodCard(apod: apod, date: date);
                                },
                              );
                            });
                      } else {
                        return const Center(child: Loader());
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10),
                StreamBuilder<int>(
                    stream: bloc.paginationStream,
                    builder: (context, snapshot) {
                      return PaginationWidget(
                        currentPage: snapshot.data ?? 0,
                        totalPages: bloc.totalPages,
                        onNext: bloc.nextPage,
                        onPrevious: bloc.previousPage,
                      );
                    }),
                if (bloc.dateRange != null) ...[
                  const SizedBox(height: 8),
                  Text("Date Range: ${bloc.dateRange!.formatDates()}",
                      style: const TextStyle(color: Colors.white70)),
                  const SizedBox(height: 20)
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
