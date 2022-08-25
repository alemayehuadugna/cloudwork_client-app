import 'package:clean_flutter/_core/router/go_router.dart';
import 'package:clean_flutter/modules/client-job/domain/entities/job.dart';
import 'package:clean_flutter/modules/client-job/domain/usecase/addMilestone.dart';
import 'package:clean_flutter/modules/client-job/views/job_detail/blocs/get_job_bloc.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../_core/cqrs.dart';
import '../../../../../_core/di/get_It.dart';
import '../../../../../_shared/interface/bloc/auth/auth_bloc.dart';
import '../../../../../_shared/interface/pages/widgets/show_top_flash.dart';
import '../../../../chat/views/bloc/conversation_bloc/conversation_bloc.dart';
import '../../../common/constant.dart';

class JobDetailDisplay extends StatefulWidget {
  String kind;
  String tabKind;
  JobDetailEntity job;

  JobDetailDisplay(
      {Key? key, required this.kind, required this.tabKind, required this.job})
      : super(key: key);

  @override
  State<JobDetailDisplay> createState() => _JobDetailDisplayState();
}

class _JobDetailDisplayState extends State<JobDetailDisplay>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String id = '';

  @override
  Widget build(BuildContext context) {
    const List<String> tabs = ['Overview', 'Milestones', 'Files', 'Payments'];

    int selectedTabIndex(String tabKind) {
      switch (tabKind) {
        case 'overview':
          return 0;

        case 'milestones':
          return 1;

        case 'files':
          return 2;

        case 'payments':
          return 3;

        default:
          return 0;
      }
    }

    _tabController.index = selectedTabIndex(widget.tabKind);
    return BlocConsumer<JobDetailBloc, JobDetailState>(
      listener: ((context, state) {
        if (state is JobDetailLoaded) {
          id = state.job.id;
        }
      }),
      builder: ((context, state) {
        return DefaultTabController(
          length: 4,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Scaffold(
                body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    title: Center(
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(scrollbars: false),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: TabBar(
                            controller: _tabController,
                            isScrollable: true,
                            onTap: _handleTabTapped,
                            tabs: [
                              for (String tab in tabs)
                                CustomTab(
                                  label: tab,
                                  width: ResponsiveValue<double>(context,
                                          defaultValue: 200,
                                          valueWhen: [
                                            const Condition.equals(
                                                name: MOBILE, value: 100),
                                            const Condition.largerThan(
                                                name: MOBILE, value: 200),
                                            const Condition.equals(
                                                name: DESKTOP, value: 300),
                                          ]).value ??
                                      200,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    pinned: true,
                    floating: true,
                    automaticallyImplyLeading: false,
                  ),
                ];
              },
              body: TabBarView(
                controller: _tabController,
                children: [
                  SingleChildScrollView(child: JobDetail(job: widget.job)),
                  Milestones(id: widget.job.id),
                  const Files(),
                  Payments(id: widget.job.id),
                ],
              ),
            )),
          ),
        );
      }),
    );
  }

  void _handleTabTapped(int index) {
    id = widget.job.id;
    switch (index) {
      case 0:
        context.go('/jobs/${widget.kind}/details/$id/overview');
        break;
      case 1:
        var _jobDetailBloc = BlocProvider.of<JobDetailBloc>(context);
        _jobDetailBloc.emit(MilestoneInitial());
        context.go('/jobs/${widget.kind}/details/$id/milestones');
        break;
      case 2:
        context.go('/jobs/${widget.kind}/details/$id/files');
        break;
      case 3:
        BlocProvider.of<JobDetailBloc>(context).add(ListMilestonesEvent(
            pagination: {'page': 1, 'limit': 10},
            jobId: id,
            type: 'completed'));
        context.go('/jobs/${widget.kind}/details/$id/payments');
        break;
    }
  }
}

class Milestones extends StatelessWidget {
  final String id;
  const Milestones({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MilestonesTitle(id: id),
        Expanded(child: MilestoneTable(id: id))
      ],
    );
  }
}

class MilestoneTable extends StatefulWidget {
  final String id;

  const MilestoneTable({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<MilestoneTable> createState() => _MilestoneTableState();
}

class _MilestoneTableState extends State<MilestoneTable> {
  List<DataColumn> columns = const [
    DataColumn(
      label: Text(
        'Name',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    DataColumn(
      label: Text(
        'Budget',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    DataColumn(
      label: Text(
        'Start Date',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    DataColumn(
      label: Text(
        'End Date',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    DataColumn(
        label: Text('Paid', style: TextStyle(fontWeight: FontWeight.bold))),
    DataColumn(
        label: Text('Action', style: TextStyle(fontWeight: FontWeight.bold))),
  ];

  final PaginatorController _controller = PaginatorController();
  int _limit = PaginatedDataTable.defaultRowsPerPage;
  int _page = 1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobDetailBloc, JobDetailState>(
      builder: (context, state) {
        if (state is MilestoneInitial) {
          BlocProvider.of<JobDetailBloc>(context).add(ListMilestonesEvent(
              pagination: {'page': _page, 'limit': _limit},
              jobId: widget.id,
              type: 'all'));
        } else if (state is ErrorLoadingMilestones) {
          showTopSnackBar(
              title: const Text('Error'),
              content: Text(state.message),
              icon: const Icon(Icons.error),
              context: context);
          context.loaderOverlay.hide();
        }
        if (state is MilestoneLoaded) {
          context.loaderOverlay.hide();
          return SizedBox(
            width: double.infinity,
            child: AsyncPaginatedDataTable2(
              minWidth: 900,
              columnSpacing: 15,
              showCheckboxColumn: false,
              autoRowsToHeight: true,
              columns: columns,
              rowsPerPage: _limit,
              controller: _controller,
              initialFirstRowIndex:
                  (state.milestones.page.current - 1) * _limit,
              onRowsPerPageChanged: (value) {
                if (value != _limit) {
                  BlocProvider.of<JobDetailBloc>(context).add(
                    ListMilestonesEvent(
                        pagination: {'page': _page, 'limit': value},
                        jobId: widget.id,
                        type: 'all'),
                  );
                }
                _limit = value!;
              },
              onPageChanged: (value) {
                _page = ((value / _limit) + 1).toInt();
                BlocProvider.of<JobDetailBloc>(context).add(
                  ListMilestonesEvent(
                      pagination: {'page': _page, 'limit': _limit},
                      jobId: widget.id,
                      type: 'all'),
                );
              },
              source: MilestoneDataSourceAsync(
                  context: context, result: state.milestones, id: widget.id),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class MilestoneDataSourceAsync extends AsyncDataTableSource {
  final PaginatedQueryResult<List<MilestoneEntity>> result;
  final BuildContext context;
  final String id;

  MilestoneDataSourceAsync({
    required this.context,
    required this.result,
    required this.id,
  });

  @override
  Future<AsyncRowsResponse> getRows(int start, int end) async {
    var row = AsyncRowsResponse(
      result.page.totalElements,
      result.data!.map(
        (milestones) {
          return DataRow(
            onSelectChanged: (value) {
              // if (value != null) {
              //   setRowSelection(ValueKey<String>(transaction.tnxId), value);
              // }
            },
            cells: [
              DataCell(Text(milestones.name)),
              DataCell(Text(
                milestones.budget.toString(),
                // overflow: TextOverflow.ellipsis,
              )),
              DataCell(Text(
                milestones.startDate.year.toString() +
                    "-" +
                    milestones.startDate.month.toString() +
                    "-" +
                    milestones.startDate.day.toString(),
              )),
              DataCell(
                Text(
                  milestones.endDate.year.toString() +
                      "-" +
                      milestones.endDate.month.toString() +
                      "-" +
                      milestones.endDate.day.toString(),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 108,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: Text(milestones.state),
                    ),
                  ),
                ),
              ),
              DataCell(
                ElevatedButton(
                  onPressed: milestones.state == 'Paid'
                      ? null
                      : () {
                          BlocProvider.of<JobDetailBloc>(context).add(
                            PayFreelancerEvent(
                                milestoneId: milestones.milestoneId,
                                jobId: id,
                                freelancerId:
                                    permanentJob!.freelancerId![0].freelancerId,
                                clientId: permanentJob!.clientId,
                                amount: milestones.budget),
                          );
                        },
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                    child: Text(
                      "Pay Now",
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ).toList(),
    );

    return row;
  }
}

class RecentTransactionTable extends StatefulWidget {
  final String id;

  const RecentTransactionTable({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<RecentTransactionTable> createState() => _RecentTransactionTableState();
}

class _RecentTransactionTableState extends State<RecentTransactionTable> {
  List<DataColumn> columns = const [
    DataColumn(
      label: Text(
        'Name',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    DataColumn(
      label: Text(
        'Types of Payment',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    DataColumn(
      label: Text(
        'Payment',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    DataColumn(
      label: Text(
        'Status',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    DataColumn(
      label: Text(
        'Date Paid',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  ];

  final PaginatorController _controller = PaginatorController();
  int _limit = PaginatedDataTable.defaultRowsPerPage;
  int _page = 1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobDetailBloc, JobDetailState>(
      builder: (context, state) {
        if (state is MilestoneInitial) {
          BlocProvider.of<JobDetailBloc>(context).add(ListMilestonesEvent(
              pagination: {'page': _page, 'limit': _limit},
              jobId: widget.id,
              type: 'completed'));
        } else if (state is ErrorLoadingMilestones) {
          showTopSnackBar(
              title: const Text('Error'),
              content: Text(state.message),
              icon: const Icon(Icons.error),
              context: context);
          context.loaderOverlay.hide();
        }
        if (state is MilestoneLoaded) {
          context.loaderOverlay.hide();
          return SizedBox(
            width: double.infinity,
            child: AsyncPaginatedDataTable2(
              minWidth: 600,
              columnSpacing: 15,
              showCheckboxColumn: false,
              autoRowsToHeight: true,
              columns: columns,
              rowsPerPage: _limit,
              controller: _controller,
              initialFirstRowIndex:
                  (state.milestones.page.current - 1) * _limit,
              onRowsPerPageChanged: (value) {
                if (value != _limit) {
                  BlocProvider.of<JobDetailBloc>(context).add(
                    ListMilestonesEvent(
                        pagination: {'page': _page, 'limit': value},
                        jobId: widget.id,
                        type: 'completed'),
                  );
                }
                _limit = value!;
              },
              onPageChanged: (value) {
                _page = ((value / _limit) + 1).toInt();
                BlocProvider.of<JobDetailBloc>(context).add(
                  ListMilestonesEvent(
                      pagination: {'page': _page, 'limit': _limit},
                      jobId: widget.id,
                      type: 'completed'),
                );
              },
              source: TransactionDataSourceAsync(
                  context: context, result: state.milestones),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class TransactionDataSourceAsync extends AsyncDataTableSource {
  final PaginatedQueryResult<List<MilestoneEntity>> result;
  final BuildContext context;

  TransactionDataSourceAsync({
    required this.context,
    required this.result,
  });

  @override
  Future<AsyncRowsResponse> getRows(int start, int end) async {
    var row = AsyncRowsResponse(
      result.page.totalElements,
      result.data!.map(
        (milestones) {
          return DataRow(
            onSelectChanged: (value) {
              // if (value != null) {
              //   setRowSelection(ValueKey<String>(transaction.tnxId), value);
              // }
            },
            cells: [
              DataCell(Text(milestones.name)),
              const DataCell(Text("Milestone")),
              DataCell(Text(
                milestones.budget.toString(),
              )),
              DataCell(Text(milestones.state)),
              DataCell(
                Text(
                  milestones.datePaid!.year.toString() +
                      "-" +
                      milestones.datePaid!.month.toString() +
                      "-" +
                      milestones.datePaid!.day.toString(),
                ),
              ),
            ],
          );
        },
      ).toList(),
    );

    return row;
  }
}

class MilestonesTitle extends StatelessWidget {
  final String id;

  const MilestonesTitle({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Milestones"),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.primary),
              ),
              onPressed: () {
                if (ResponsiveWrapper.of(context).isLargerThan(MOBILE)) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        child: SizedBox(
                            // height: 200,
                            width: 750,
                            child: proposal_widget(id: id)),
                      );
                    },
                  );
                } else {
                  showGeneralDialog(
                      context: context,
                      transitionBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(0.0, 1.0);
                        const end = Offset.zero;
                        const curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                      pageBuilder: (context, anim, anis) {
                        return SafeArea(
                          child: SizedBox.expand(
                            child: Scaffold(
                              body: proposal_widget(id: id),
                            ),
                          ),
                        );
                      });
                }
              },
              child: const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text(
                  "Add Milestones",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Files extends StatelessWidget {
  const Files({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        FilesTitle(),
        FilesTableHeader(),
      ],
    );
  }
}

class FilesTitle extends StatelessWidget {
  const FilesTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Files"),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.primary),
              ),
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text(
                  "Add Files",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilesTableHeader extends StatelessWidget {
  const FilesTableHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: PaginatedDataTable(
        rowsPerPage: 4,
        columns: const [
          DataColumn(label: Text('Title')),
          DataColumn(label: Text('Description')),
          DataColumn(label: Text('Type')),
          DataColumn(label: Text('Size')),
          DataColumn(label: Text('Action')),
        ],
        source: _FileDataSource(context),
      ),
    );
  }
}

class _FileRow {
  _FileRow(this.title, this.description, this.type, this.size, this.action);

  final String title;
  final String description;
  final String type;
  final int size;
  final Padding action;

  bool selected = false;
}

class _FileDataSource extends DataTableSource {
  _FileDataSource(this.context) {
    _rows = <_FileRow>[
      for (var i = 0; i < 4; i++)
        _FileRow(
          'Image for Section background',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
          'jpg',
          200,
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Text(
              "icon",
            ),
          ),
        ),
    ];
  }

  final BuildContext context;
  late List<_FileRow> _rows;

  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null;
    final row = _rows[index];
    return DataRow.byIndex(
      index: index,
      // selected: row.selected,
      // onSelectChanged: (value) {
      //   if (row.selected != value) {
      //     _selectedCount += value! ? 1 : -1;
      //     assert(_selectedCount >= 0);
      //     row.selected = value;
      //     notifyListeners();
      //   }
      // },
      cells: [
        DataCell(Text(row.title)),
        DataCell(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(row.description),
            const SizedBox(height: 5),
            Text(
              'Readmore',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        )),
        DataCell(Text(row.type)),
        DataCell(Text(row.size.toString())),
        DataCell(
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.flight),
              ),
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.directions_car),
              ),
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.directions_bike),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

class Payments extends StatelessWidget {
  final String id;

  const Payments({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: RecentTransactionTable(id: id)),
      ],
    );
  }
}

class JobDetail extends StatelessWidget {
  const JobDetail({Key? key, required this.job}) : super(key: key);

  final JobDetailEntity job;

  @override
  Widget build(BuildContext context) {
    List<String> list = [];
    list = job.skills;
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            JobTitle(job: job),
            Card(
              elevation: 2,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                      child: Text(
                        "Overview",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                    child: Divider(
                      thickness: 1,
                      endIndent: 20,
                    ),
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                          child: Text("Senior Animator",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Text(
                            job.description,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Card(
              elevation: 2,
              child: Column(children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
                    child: Text(
                      "Skills Required",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                  child: Divider(
                    thickness: 2,
                    endIndent: 20,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 20),
                    child: Wrap(
                      children: [
                        for (int i = 0; i < list.length; i++)
                          Wrap(
                            children: [
                              Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Wrap(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          30, 10, 30, 10),
                                      child: Text(
                                        list[i].toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class JobTitle extends StatelessWidget {
  const JobTitle({
    Key? key,
    required this.job,
  }) : super(key: key);

  final JobDetailEntity job;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(26, 20, 10, 20),
        child: ResponsiveRowColumn(
          rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
          rowCrossAxisAlignment: CrossAxisAlignment.center,
          columnVerticalDirection: VerticalDirection.up,
          rowSpacing: 15,
          columnSpacing: 15,
          layout: ResponsiveWrapper.of(context).isSmallerThan(TABLET)
              ? ResponsiveRowColumnType.COLUMN
              : ResponsiveRowColumnType.ROW,
          children: [
            ResponsiveRowColumnItem(
              rowFlex: 5,
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Title(title: job.title),
                    const SizedBox(height: 10),
                    ResponsiveRowColumn(
                      rowCrossAxisAlignment: CrossAxisAlignment.center,
                      rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                      rowSpacing: 15,
                      columnSpacing: 30,
                      layout:
                          ResponsiveWrapper.of(context).isSmallerThan(TABLET)
                              ? ResponsiveRowColumnType.COLUMN
                              : ResponsiveRowColumnType.ROW,
                      children: [
                        ResponsiveRowColumnItem(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LanguageWidget(language: job.language),
                              const SizedBox(width: 30),
                              ExpiryWidget(expiry: job.expiry),
                            ],
                          ),
                        ),
                        ResponsiveRowColumnItem(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BudgetWidget(
                                  budget: job.budget, duration: job.duration),
                              const SizedBox(width: 20),
                              ActionWidget(job: job),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            ResponsiveRowColumnItem(
              rowFlex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                            job.freelancerId!.first.profilePicture),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    job.freelancerId == null
                        ? "No Freelancer Assigned"
                        : job.freelancerId!.first.firstName +
                            " " +
                            job.freelancerId!.first.lastName,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.secondary),
                    ),
                    onPressed: () {
                      print(
                          "members: ${job.freelancerId!.first.freelancerId} ${job.clientId!}");
                      BlocProvider.of<ConversationBloc>(context)
                          .add(StartConversationEvent(
                        job.freelancerId!.first.freelancerId,
                        job.clientId!,
                      ));
                      context.goNamed(chatRouteName);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: SizedBox(
                        height: 32,
                        width: 83,
                        child: Center(
                          child: Text(
                            "Chat Now",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomTab extends StatelessWidget {
  const CustomTab({
    Key? key,
    required this.width,
    required this.label,
  }) : super(key: key);

  final double width;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Tab(text: label),
    );
  }
}

class Title extends StatelessWidget {
  const Title({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: ResponsiveValue<TextStyle?>(context,
              defaultValue: Theme.of(context).textTheme.headline4,
              valueWhen: [
                Condition.equals(
                    name: TABLET, value: Theme.of(context).textTheme.headline5),
                Condition.smallerThan(
                    name: TABLET, value: Theme.of(context).textTheme.headline6)
              ]).value ??
          Theme.of(context).textTheme.headline4,
    );
  }
}

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({Key? key, required this.language}) : super(key: key);

  final String? language;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Language",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          language == null ? 'No Language' : language.toString(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}

class ExpiryWidget extends StatelessWidget {
  const ExpiryWidget({Key? key, required this.expiry}) : super(key: key);

  final String? expiry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Expiry",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          expiry == null
              ? 'Not Specified'
              : "${expiry!.split('::')[0]} Days Left",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}

class BudgetWidget extends StatelessWidget {
  const BudgetWidget({Key? key, required this.budget, required this.duration})
      : super(key: key);

  final double? budget;
  final int? duration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$budget ETB",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 10),
        Text(
          "in $duration Days",
          style: Theme.of(context).textTheme.bodyLarge?.merge(
                TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
        )
      ],
    );
  }
}

class ActionWidget extends StatefulWidget {
  const ActionWidget({
    Key? key,
    required this.job,
  }) : super(key: key);

  final JobDetailEntity job;

  @override
  State<ActionWidget> createState() => _ActionWidgetState();
}

class _ActionWidgetState extends State<ActionWidget> {
  final List<String> _progressItems = ['Cancel', 'Complete'];

  @override
  Widget build(BuildContext context) {
    BuildContext tempContext = context;
    String progress = '';
    return Column(
      children: [
        Text(
          widget.job.expiry == null
              ? "Not Hired"
              : "Hired on ${widget.job.expiry!.split('::')[1].split(':')[0].split('-')[2].split('T')[0]} ${widget.job.expiry!.split('::')[1].split('-')[1]} ${widget.job.expiry!.split('::')[1].split('-')[0]}",
          style: Theme.of(context).textTheme.bodyMedium?.merge(
                TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 180,
          child: DropdownSearch<String>(
            dropdownSearchDecoration: const InputDecoration(
              labelText: 'Progress',
              contentPadding: EdgeInsets.fromLTRB(30, 12, 12, 12),
              border: OutlineInputBorder(),
            ),
            popupProps: const PopupProps.menu(
              menuProps: MenuProps(
                constraints: BoxConstraints(maxHeight: 100),
              ),
            ),
            items: _progressItems,
            onChanged: (String? data) {
              progress = data!;
              if (data == 'Cancel') {
                progress = 'CANCELLED';
              } else if (data == 'Complete') {
                progress = 'COMPLETED';
              }
              showDialog<void>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Changing Job Status'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: const [
                          Text("Are you sure?"),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text(
                          'Approve',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          context.loaderOverlay.hide();
                          BlocProvider.of<JobDetailBloc>(tempContext).add(
                            GetJobProgressEvent(
                              id: widget.job.id,
                              progress: progress,
                              freelancerId:
                                  widget.job.freelancerId!.first.freelancerId,
                              clientId: widget.job.clientId!,
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
            selectedItem: progress == '' ? widget.job.progress : progress,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class proposal_widget extends StatelessWidget {
  final String id;

  proposal_widget({
    Key? key,
    required this.id,
  }) : super(key: key);

  bool check = false;
  final _milestoneNameController = TextEditingController();
  final _budgetController = TextEditingController();
  final _startDatePickerController = TextEditingController();
  final _endDatePickerController = TextEditingController();
  final _descriptionController = TextEditingController();
  late DateTime initial = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var isMobile = ResponsiveWrapper.of(context).equals(MOBILE);
    var height = MediaQuery.of(context).size.height;
    final _formKey = GlobalKey<FormState>();
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Add Milestone",
                      style: ResponsiveValue<TextStyle?>(context,
                              defaultValue:
                                  Theme.of(context).textTheme.headline4,
                              valueWhen: [
                                Condition.equals(
                                    name: TABLET,
                                    value:
                                        Theme.of(context).textTheme.headline5),
                                Condition.smallerThan(
                                    name: TABLET,
                                    value:
                                        Theme.of(context).textTheme.headline6)
                              ]).value ??
                          Theme.of(context).textTheme.headline4,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      icon: const Icon(Icons.close),
                      splashRadius: 25,
                      padding: EdgeInsets.zero,
                    )
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: ResponsiveValue<EdgeInsets>(context,
                      defaultValue: const EdgeInsets.all(30),
                      valueWhen: [
                        const Condition.equals(
                            name: DESKTOP, value: EdgeInsets.all(30)),
                        const Condition.largerThan(
                            name: TABLET,
                            value: EdgeInsets.fromLTRB(20, 30, 20, 30)),
                        const Condition.equals(
                            name: TABLET,
                            value: EdgeInsets.fromLTRB(20, 30, 20, 30)),
                        const Condition.smallerThan(
                            name: TABLET,
                            value: EdgeInsets.fromLTRB(0, 30, 0, 30)),
                      ]).value!,
                  child: Container(
                    color: Theme.of(context).cardTheme.color,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 7),
                                MilestoneNameFormWidget(
                                    controller: _milestoneNameController),
                                const SizedBox(height: 30),
                                BudgetFormWidget(controller: _budgetController),
                                const SizedBox(height: 30),
                                StartDatePickerTextField(
                                    date: initial,
                                    initial: initial,
                                    controller: _startDatePickerController),
                                const SizedBox(height: 30),
                                EndDatePickerTextField(
                                    date: initial,
                                    initial: initial,
                                    controller: _endDatePickerController),
                                const SizedBox(height: 30),
                                DescriptionFormWidget(
                                    controller: _descriptionController),
                                const SizedBox(height: 30),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: BlocProvider(
                                create: (BuildContext context) =>
                                    container<JobDetailBloc>(),
                                child: ActionButton(
                                  id: id,
                                  formKey: _formKey,
                                  titleController: _milestoneNameController,
                                  budgetController: _budgetController,
                                  startDatePickerController:
                                      _startDatePickerController,
                                  endDatePickerController:
                                      _endDatePickerController,
                                  descriptionController: _descriptionController,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class MilestoneNameFormWidget extends StatefulWidget {
  MilestoneNameFormWidget({Key? key, required this.controller})
      : super(key: key);

  late TextEditingController controller;

  @override
  State<MilestoneNameFormWidget> createState() =>
      _MilestoneNameFormWidgetState();
}

class _MilestoneNameFormWidgetState extends State<MilestoneNameFormWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: (String value) {
        var temp = TextEditingValue(
          text: widget.controller.text,
        );
      },
      decoration: const InputDecoration(
        label: Text('Milestone Name'),
        isDense: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Milestone Name is required.";
        }
        return null;
      },
    );
  }
}

class StartDatePickerTextField extends StatefulWidget {
  StartDatePickerTextField(
      {Key? key,
      required this.initial,
      required this.date,
      required this.controller})
      : super(key: key);

  late TextEditingController controller =
      TextEditingController(text: "${date.year}-${date.month}-${date.day}");
  DateTime date;
  DateTime initial;

  @override
  State<StartDatePickerTextField> createState() =>
      _StartDatePickerTextFieldState();
}

class _StartDatePickerTextFieldState extends State<StartDatePickerTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: const InputDecoration(
        isDense: true,
        label: Text("Enter Start Date"),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      onTap: () async {
        final DateTime? newDate = await showDatePicker(
          context: context,
          initialDate: widget.initial,
          firstDate: widget.initial,
          lastDate: DateTime(2030, 7),
          helpText: 'Select a date',
        ) as DateTime;

        if (newDate != null && newDate != DateTime.now()) {
          setState(() {
            holdStartDate = newDate;
            widget.date = newDate;
            widget.controller.value = TextEditingValue(
              text: newDate.year.toString() +
                  "-" +
                  newDate.month.toString() +
                  "-" +
                  newDate.day.toString(),
            );
          });
        }
      },
    );
  }
}

class EndDatePickerTextField extends StatefulWidget {
  EndDatePickerTextField(
      {Key? key,
      required this.initial,
      required this.date,
      required this.controller})
      : super(key: key);

  late TextEditingController controller =
      TextEditingController(text: "${date.year}-${date.month}-${date.day}");
  DateTime date;
  DateTime initial;

  @override
  State<EndDatePickerTextField> createState() => _EndDatePickerTextFieldState();
}

class _EndDatePickerTextFieldState extends State<EndDatePickerTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: const InputDecoration(
        isDense: true,
        label: Text("Enter End Date"),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      onTap: () async {
        final DateTime? newDate = await showDatePicker(
          context: context,
          initialDate: holdStartDate!,
          firstDate: holdStartDate!,
          lastDate: DateTime(2030, 7),
          helpText: 'Select a date',
        ) as DateTime;

        if (newDate != null && newDate != DateTime.now()) {
          setState(() {
            widget.date = newDate;
            widget.controller.value = TextEditingValue(
              text: newDate.year.toString() +
                  "-" +
                  newDate.month.toString() +
                  "-" +
                  newDate.day.toString(),
            );
          });
        }
      },
    );
  }
}

class BudgetFormWidget extends StatefulWidget {
  BudgetFormWidget({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  State<BudgetFormWidget> createState() => _BudgetFormWidgetState();
}

class _BudgetFormWidgetState extends State<BudgetFormWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
      ],
      controller: widget.controller,
      onChanged: (String value) {
        var temp = TextEditingValue(
          text: widget.controller.text,
        );
      },
      decoration: const InputDecoration(
        isDense: true,
        label: Text("Budget"),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty || double.parse(value) < 50) {
          return "Incorrect Budget. hint: greater than 50.";
        }
        return null;
      },
    );
  }
}

class ActionButton extends StatelessWidget {
  ActionButton({
    Key? key,
    required this.id,
    required this.titleController,
    required this.budgetController,
    required this.startDatePickerController,
    required this.endDatePickerController,
    required this.descriptionController,
    required this.formKey,
  }) : super(key: key);

  final String id;
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController budgetController;
  final TextEditingController startDatePickerController;
  final TextEditingController endDatePickerController;
  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobDetailBloc, JobDetailState>(
      listener: (context, state) {
        if (state is ErrorLoadingAddMilestone) {
          showTopSnackBar(
              title: const Text('Error'),
              content: Text(state.message),
              icon: const Icon(Icons.error),
              context: context);
          context.loaderOverlay.hide();
        } else if (state is AddMilestoneLoaded) {
          Navigator.of(context).pop();
          context.loaderOverlay.hide();
          context.go('/jobs/all/details/$id/overview');
        }
      },
      builder: (context, state) {
        return Align(
          alignment: Alignment.bottomRight,
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.secondary),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // getting tittle
                    var name = TextEditingValue(
                      text: titleController.text,
                    );

                    // getting budget
                    var budget = TextEditingValue(
                      text: budgetController.text,
                    );

                    // getting date
                    var startDate = TextEditingValue(
                      text: startDatePickerController.text.isEmpty
                          ? ''
                          : startDatePickerController.text,
                    );

                    // getting date
                    var endDate = TextEditingValue(
                      text: endDatePickerController.text.isEmpty
                          ? ''
                          : endDatePickerController.text,
                    );

                    // getting description
                    var description = TextEditingValue(
                      text: descriptionController.text,
                    );

                    final payload = AddMilestoneParams(
                        id,
                        name.text,
                        double.parse(budget.text),
                        startDate.text,
                        endDate.text,
                        description.text);

                    BlocProvider.of<JobDetailBloc>(context)
                        .add(AddMilestoneEvent(payload: payload));
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "SUBMIT",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );

    // return BlocConsumer<JobDetailBloc, JobDetailState>(
    //   listener: (context, state) {
    //     if (state is ErrorLoadingJobDetail) {
    //       showTopSnackBar(
    //           title: const Text('Error'),
    //           content: Text(state.message),
    //           icon: const Icon(Icons.error),
    //           context: context);
    //       context.loaderOverlay.hide();
    //     } else if (state is JobDetailLoaded) {
    //       context.loaderOverlay.hide();
    //       context.pop();
    //     }
    //   },
    //   builder: (context, state) {
    //     return
    //     Align(
    //       alignment: Alignment.bottomRight,
    //       child: BlocBuilder<AuthBloc, AuthState>(
    //         builder: (context, state) {
    //           return ElevatedButton(
    //             style: ButtonStyle(
    //               backgroundColor: MaterialStateProperty.all(
    //                   Theme.of(context).colorScheme.secondary),
    //             ),
    //             onPressed: () {
    //               if (formKey.currentState!.validate()) {
    //                 // getting tittle
    //                 var title = TextEditingValue(
    //                   text: titleController.text,
    //                 );

    //                 // getting budget
    //                 var budget = TextEditingValue(
    //                   text: budgetController.text,
    //                 );

    //                 // getting date
    //                 var date = TextEditingValue(
    //                   text: datePickerController.text.isEmpty
    //                       ? ''
    //                       : datePickerController.text,
    //                 );

    //                 // BlocProvider.of<JobPostBloc>(context).add(PostJobEvent(
    //                 //   payload: JobDetailEntity.create(
    //                 //     id: '',
    //                 //     clientId: state is Authenticated ? state.user.id : null,
    //                 //     title: title.text,
    //                 //     skills: ListOfSkills,
    //                 //     budget: double.parse(budget.text),
    //                 //     duration: int.parse(duration.text),
    //                 //     expiry: date.text,
    //                 //     category: category,
    //                 //     language: language,
    //                 //     links: links,
    //                 //     description: description.text,
    //                 //     files: files,
    //                 //   ),
    //                 // ));
    //               }
    //             },
    //             child: Padding(
    //               padding: const EdgeInsets.all(10),
    //               child: Text(
    //                 "SUBMIT",
    //                 style: TextStyle(
    //                   color: Theme.of(context).colorScheme.primary,
    //                 ),
    //               ),
    //             ),
    //           );
    //         },
    //       ),
    //     );

    //   },
    // );
  }
}

class DescriptionFormWidget extends StatefulWidget {
  DescriptionFormWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  State<DescriptionFormWidget> createState() => _DescriptionFormWidgetState();
}

class _DescriptionFormWidgetState extends State<DescriptionFormWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 7,
      maxLines: 7,
      controller: widget.controller,
      onChanged: (String value) {
        var temp = TextEditingValue(
          text: widget.controller.text,
        );
      },
      decoration: const InputDecoration(
        isDense: true,
        hintText: "Add Description",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Description is required.";
        }
        return null;
      },
    );
  }
}
