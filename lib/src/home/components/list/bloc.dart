import 'dart:async';

import 'package:cloudwalknasa/models/apod.dart';
import 'package:cloudwalknasa/services/api.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

extension on String {
  bool search(String query) => toLowerCase().contains(query.toLowerCase());
}

mixin PaginationMixin {
  final BehaviorSubject<int> _currentPage = BehaviorSubject<int>.seeded(1);
  final BehaviorSubject<int> _totalPages = BehaviorSubject<int>.seeded(1);
  final int itemsPerPage = 10;

  Stream<int> get currentPage => _currentPage.stream;

  int get _currentValue => _currentPage.value;

  void jumpToPage(int page) {
    _currentPage.sink.add(page);
  }

  void nextPage() {
    _currentPage.sink.add(_currentValue + 1);
  }

  void previousPage() {
    if (_currentValue > 1) _currentPage.sink.add(_currentValue - 1);
  }

  void disposePagination() {
    _currentPage.close();
  }

  get totalPages => _totalPages.stream.value;

  get paginationStream => Rx.combineLatest2(
        _currentPage.stream,
        _totalPages.stream,
        (int page, int total) => page,
      );
}

// Been a mixin, it can be used in others blocs
mixin SearchMixin {
  final BehaviorSubject<String> _searchQuery =
      BehaviorSubject<String>.seeded('');

  Function(String) get updateSearchQuery => _searchQuery.sink.add;

  Stream<String> get searchQuery => _searchQuery.stream;

  Stream<String> get searchQueryDebounced => _searchQuery.stream.debounceTime(
        const Duration(milliseconds: 500),
      );

  void dispose() {
    _searchQuery.close();
  }
}

class BlocListImages with SearchMixin, PaginationMixin {
  final BehaviorSubject<List<Apod?>> _listImages =
      BehaviorSubject<List<Apod?>>();

  // isLoading BehaviorSubject
  final BehaviorSubject<bool> _isLoading = BehaviorSubject<bool>.seeded(true);

  DateTimeRange? dateRange;

  BlocListImages() {
    dateRange = DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 30)),
      end: DateTime.now(),
    );
    fetchListImages(dateRange);
  }

  Stream<List<Apod?>> get listImages => _listImages.stream;

  Function(List<Apod?>) get addListImages => _listImages.sink.add;

  Stream<bool> get isLoading => _isLoading.stream;

  Stream<List<Apod?>?> get listImagesFiltered => Rx.combineLatest2(
        _listImages.stream,
        _searchQuery.stream,
        (List<Apod?> list, String query) {
          return query.isEmpty
              ? list
              : list
                  .where((item) => item?.title.search(query) ?? false)
                  .toList();
        },
      );

  Stream<List<Apod?>?> get pagedImages => Rx.combineLatest2(
        listImagesFiltered,
        currentPage,
        (List<Apod?>? list, int page) {
          int start = (page - 1) * itemsPerPage;
          int end = (page * itemsPerPage).clamp(0, list?.length ?? 0);
          _totalPages.sink.add(((list?.length ?? 0) / itemsPerPage).ceil());
          return list?.sublist(start, end);
        },
      );

  @override
  void dispose() {
    _listImages.close();
    _searchQuery.close();
  }

  Future refreshFetchActual() async {
    fetchListImages(dateRange);
  }

  fetchListImages(DateTimeRange? date) async {
    try {
      _isLoading.sink.add(true);
      dateRange = date;
      var list = await NasaApi.instance.getApodList(
        startDate: date?.start,
        endDate: date?.end,
      );
      var listSorted = [...list]..sort(
          (a, b) => DateTime.parse(b!.date).compareTo(DateTime.parse(a!.date)));
      addListImages(listSorted);
      _isLoading.sink.add(false);
    } catch (e, stack) {
      Logger().e("Houve um erro", error: e, stackTrace: stack);
    }
  }
}
