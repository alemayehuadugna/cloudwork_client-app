import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../_core/di/get_It.dart';
import '../../../../../_shared/interface/pages/widgets/show_top_flash.dart';
import '../../../../review/views/bloc/give_review_bloc/give_review_bloc.dart';
import '../../../common/constant.dart';
import '../../../common/pagination.dart';
import '../../../domain/entities/job.dart';
import '../../../router.dart';
import '../../job_detail/blocs/get_job_bloc.dart';
import '../bloc/list_job_bloc.dart';
import 'widgets.dart';

class ListJobDisplay extends StatefulWidget {
  String kind;

  ListJobDisplay({
    required this.kind,
    Key? key,
  }) : super(key: key);

  @override
  State<ListJobDisplay> createState() => _ListJobDisplayState();
}

class _ListJobDisplayState extends State<ListJobDisplay>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const List<String> tabs = [
      'All',
      'Pending',
      'Ongoing',
      'Completed',
      'Canceled'
    ];

    int selectedTabIndex(String kind) {
      switch (kind) {
        case 'all':
          return 0;

        case 'pending':
          return 1;

        case 'ongoing':
          return 2;

        case 'completed':
          return 3;

        case 'canceled':
          return 4;
        default:
          return 0;
      }
    }

    _tabController.index = selectedTabIndex(widget.kind);

    return DefaultTabController(
      length: 5,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(right: 20.0, bottom: 20.0),
              child: FloatingActionButton.extended(
                icon: const Icon(Icons.add),
                onPressed: () {
                  context.goNamed(
                    jobPostRouteName,
                    params: {"kind": "all"},
                  );
                },
                label: const Text("POST"),
              ),
            ),
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    title: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
                      child: Text(
                        "Manage Projects",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.background,
                    elevation: 2,
                    pinned: true,
                    floating: true,
                    bottom: TabBar(
                      indicatorColor: Theme.of(context).colorScheme.primary,
                      labelColor: Theme.of(context).colorScheme.primary,
                      labelStyle: Theme.of(context)
                          .tabBarTheme
                          .labelStyle!
                          .copyWith(fontWeight: FontWeight.bold),
                      unselectedLabelColor:
                          Theme.of(context).colorScheme.onBackground,
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
                                    ]).value ??
                                200,
                          ),
                      ],
                    ),
                  ),
                ];
              },
              body: TabBarView(
                controller: _tabController,
                children: [
                  CustomCard(kind: widget.kind),
                  CustomCard(kind: widget.kind),
                  CustomCard(kind: widget.kind),
                  CustomCard(kind: widget.kind),
                  CustomCard(kind: widget.kind),
                ],
              ),
            )),
      ),
    );
  }

  void _handleTabTapped(int index) {
    switch (index) {
      case 0:
        context.go('/jobs/all');
        break;
      case 1:
        context.go('/jobs/pending');
        break;
      case 2:
        context.go('/jobs/ongoing');
        break;
      case 3:
        context.go('/jobs/completed');
        break;
      case 4:
        context.go('/jobs/canceled');
        break;
    }
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

class CustomCard extends StatefulWidget {
  const CustomCard({Key? key, required this.kind}) : super(key: key);

  final String kind;

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  ScrollController? _scrollController;

  double offset = 0.0;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController() //keepScrollOffset: false removed
      ..addListener(() {
        setState(() {
          offset = _scrollController!.offset;
        });
      });
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: PagedListView(
            pagingController: pagingController,
            scrollController: _scrollController,
            builderDelegate: PagedChildBuilderDelegate<JobEntity>(
              itemBuilder: (context, item, index) => JobTile(job: item),
            ),
          )),
    );
  }
}

class JobTile extends StatelessWidget {
  const JobTile({Key? key, required this.job}) : super(key: key);

  final JobEntity job;

  @override
  Widget build(BuildContext context) {
    BuildContext tempContext = context;
    return job.progress == 'DELETED'
        ? const Center(child: Text("No Data To Show"))
        : Card(
            elevation: 0.7,
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
                            rowMainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            rowSpacing: 15,
                            columnSpacing: 30,
                            layout: ResponsiveWrapper.of(context)
                                    .isSmallerThan(TABLET)
                                ? ResponsiveRowColumnType.COLUMN
                                : ResponsiveRowColumnType.ROW,
                            children: [
                              ResponsiveRowColumnItem(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    LanguageWidget(language: job.language),
                                    const SizedBox(width: 30),
                                    ExpiryWidget(expiry: job.expiry),
                                  ],
                                ),
                              ),
                              ResponsiveRowColumnItem(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BudgetWidget(
                                        budget: job.budget,
                                        duration: job.duration),
                                    const SizedBox(width: 20),
                                    const VerticalDivider(),
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
                        if (job.progress == 'COMPLETED' ||
                            job.progress == 'ACTIVE') ...[
                          Text(
                            "Hired",
                            style: Theme.of(context).textTheme.bodyLarge?.merge(
                                  TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                          ),
                          const SizedBox(height: 10),
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
                        ],
                        if (identical(job.progress, 'INACTIVE')) ...[
                          Column(
                            crossAxisAlignment: ResponsiveWrapper.of(context)
                                    .isSmallerThan(TABLET)
                                ? CrossAxisAlignment.center
                                : CrossAxisAlignment.end,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/agreement-bro.svg",
                                height: 100,
                              ),
                              Row(
                                mainAxisAlignment: ResponsiveWrapper.of(context)
                                        .isSmallerThan(TABLET)
                                    ? MainAxisAlignment.center
                                    : MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      "Proposals",
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ),
                                  Text(
                                    job.proposals.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        ?.merge(
                                          TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                        if (job.progress == 'CANCELLED') ...[
                          SizedBox(
                            width: 169,
                            child: BlocConsumer<JobDetailBloc, JobDetailState>(
                              listener: ((context, state) {
                                if (state is ChangeJobProgressLoaded) {
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Posting Job Again'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 10, 0, 10),
                                                child: SizedBox(
                                                  height: 200,
                                                  width:
                                                      ResponsiveValue<double>(
                                                              context,
                                                              defaultValue: 400,
                                                              valueWhen: const [
                                                                Condition
                                                                    .smallerThan(
                                                                        name:
                                                                            TABLET,
                                                                        value:
                                                                            300)
                                                              ]).value ??
                                                          400,
                                                  child: SvgPicture.asset(
                                                    "assets/icons/completed.svg",
                                                  ),
                                                ),
                                              ),
                                              const Text(
                                                  "You Posted Job Again SuccessFully"),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('Approve'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              context.loaderOverlay.hide();
                                              pagingController.itemList = null;
                                              BlocProvider.of<ListJobBloc>(
                                                      tempContext)
                                                  .add(
                                                ListJobInSubmitted(
                                                  pageKey: 0,
                                                  pageSize: 10,
                                                  clientId: clientId!,
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else if (state
                                    is ErrorLoadingChangeJobProgress) {
                                  showTopSnackBar(
                                      title: const Text('Error'),
                                      content: Text(state.message),
                                      icon: const Icon(Icons.error),
                                      context: context);
                                  context.loaderOverlay.hide();
                                }
                              }),
                              builder: ((context, state) {
                                return ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                  ),
                                  onPressed: () {
                                    showDialog<void>(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title:
                                              const Text('Posting Job Again'),
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
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                context.loaderOverlay.hide();
                                                BlocProvider.of<JobDetailBloc>(
                                                        tempContext)
                                                    .add(
                                                  GetJobProgressEvent(
                                                      id: job.id,
                                                      progress: 'INACTIVE',
                                                      freelancerId: job
                                                          .freelancerId!
                                                          .first
                                                          .freelancerId,
                                                      clientId: job.clientId!),
                                                );
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Text(
                                      "Repost",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          SvgPicture.asset(
                            "assets/icons/inbox-cleanup-amico.svg",
                            height: 100,
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog<void>(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Deleting Job'),
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
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          context.loaderOverlay.hide();
                                          BlocProvider.of<ListJobBloc>(
                                                  tempContext)
                                              .add(
                                            DeleteJobEvent(
                                                id: job.id,
                                                freelancerId: job.freelancerId!
                                                    .first.freelancerId,
                                                clientId: job.clientId!),
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text(
                              "Delete Project",
                              style:
                                  Theme.of(context).textTheme.bodyLarge?.merge(
                                        TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}

class ExpiryWidget extends StatelessWidget {
  const ExpiryWidget({
    Key? key,
    required this.expiry,
  }) : super(key: key);

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

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({
    Key? key,
    required this.language,
  }) : super(key: key);

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

class BudgetWidget extends StatelessWidget {
  const BudgetWidget({
    Key? key,
    required this.budget,
    required this.duration,
  }) : super(key: key);

  final double? budget;
  final int? duration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$budget ETB",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
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

class ActionWidget extends StatelessWidget {
  const ActionWidget({
    Key? key,
    required this.job,
  }) : super(key: key);

  final JobEntity job;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (job.progress == 'ACTIVE' || job.progress == 'COMPLETED') ...[
          SizedBox(
            width: 169,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.secondary),
              ),
              onPressed: () {
                context.goNamed(jobDetailRouteName, params: {
                  "kind": "all",
                  "id": job.id,
                  "tabKind": 'overview'
                });
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text(
                  "View Details",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
        if (job.progress == 'INACTIVE') ...[
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.secondary),
            ),
            onPressed: () {
              context.goNamed(jobProposalRouteName,
                  params: {"kind": "all", "id": job.id});
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                "View proposals",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
        if (job.progress == 'INACTIVE') ...[
          SizedBox(
            width: 169,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.secondary),
              ),
              onPressed: () {
                context.goNamed(jobEditRouteName,
                    params: {"kind": "all", "id": job.id});
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text(
                  "Edit Jobs",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
        if (job.progress == 'ACTIVE') ...[
          Text(
            job.expiry == null
                ? "Not Hired"
                : "Hired on ${job.expiry!.split('::')[1].split(':')[0].split('-')[2].split('T')[0]} ${job.expiry!.split('::')[1].split('-')[1]} ${job.expiry!.split('::')[1].split('-')[0]}",
            style: Theme.of(context).textTheme.bodyMedium?.merge(
                  TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
          ),
          const SizedBox(height: 10),
        ],
        if ('COMPLETED' == job.progress) ...[
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 5),
                child: Icon(Icons.done_all),
              ),
              Text(
                "Completed",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              var jobId = job.id;
              var reviewerId = job.clientId;
              var reviewedId = job.freelancerId!.first.freelancerId;
              ResponsiveWrapper.of(context).isMobile
                  ? _showGeneralDialog(
                      context,
                      ReviewForm(
                        jobId: jobId,
                        reviewerId: reviewedId,
                        reviewedId: reviewerId!,
                      ),
                      "Write Review")
                  : _showDialog(
                      context,
                      ReviewForm(
                          jobId: jobId,
                          reviewerId: reviewedId,
                          reviewedId: reviewerId!),
                      "Write Review");
            },
            child: const Text("Write Review"),
          )
        ],
      ],
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    Key? key,
    required this.title,
  }) : super(key: key);

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

void _showDialog(BuildContext context, Widget body, String title) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            height: 600,
            width: 750,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.background,
                title: Text(
                  title,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                leading: IconButton(
                  color: Theme.of(context).colorScheme.onBackground,
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
              body: BlocProvider(
                create: (context) => container<GiveReviewBloc>(),
                child: body,
              ),
            ),
          ),
        );
      });
}

void _showGeneralDialog(BuildContext context, Widget body, String title) {
  showGeneralDialog(
    context: context,
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
    pageBuilder: (context, anim, anis) {
      return SafeArea(
        child: SizedBox.expand(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.background,
              title: Text(
                title,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              leading: IconButton(
                color: Theme.of(context).colorScheme.onBackground,
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                icon: const Icon(Icons.close),
              ),
            ),
            body: BlocProvider(
              create: (context) => container<GiveReviewBloc>(),
              child: body,
            ),
          ),
        ),
      );
    },
  );
}
