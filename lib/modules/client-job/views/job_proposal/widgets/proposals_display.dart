import 'package:clean_flutter/modules/client-job/router.dart';
import 'package:clean_flutter/modules/client-job/views/job_list/widgets/list_job_display.dart';
import 'package:clean_flutter/modules/client-job/views/job_proposal/bloc/proposal_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:readmore/readmore.dart';

import '../../../../../_shared/interface/bloc/auth/auth_bloc.dart';
import '../../../domain/entities/job.dart';

class ProposalDisplay extends StatefulWidget {
  ProposalDisplay({
    Key? key,
    required this.job,
  }) : super(key: key);

  final JobProposalEntity? job;

  @override
  State<ProposalDisplay> createState() => _ProposalDisplayState();
}

class _ProposalDisplayState extends State<ProposalDisplay> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            JobCard(job: widget.job),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 12, 0),
              child: Text("Proposals By Freelancer",
                  style: Theme.of(context).textTheme.headline6),
            ),
            widget.job!.bid.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(child: Text("No Proposal Found")),
                  )
                : Column(
                    children: [
                      for (var i = 0; i < widget.job!.bid.length; i++)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                          child: FreelancersCard(
                              bid: widget.job!.bid[i], id: widget.job!.id),
                        ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

class FreelancersCard extends StatelessWidget {
  const FreelancersCard({Key? key, required this.bid, required this.id})
      : super(key: key);

  final BidEntity bid;
  final String id;

  @override
  Widget build(BuildContext context) {
    return FreelancerInfo(bid: bid, id: id);
  }
}

class FreelancerInfo extends StatelessWidget {
  const FreelancerInfo({Key? key, required this.bid, required this.id})
      : super(key: key);

  final BidEntity bid;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(26, 5, 10, 20),
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
                    const SizedBox(height: 10),
                    ResponsiveRowColumn(
                      rowCrossAxisAlignment: CrossAxisAlignment.center,
                      rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                      rowSpacing: 15,
                      columnSpacing: 30,
                      layout: ResponsiveWrapper.of(context)
                                  .isLargerThan(TABLET) ||
                              ResponsiveWrapper.of(context).equals(TABLET) ||
                              (MediaQuery.of(context).size.width > 671 &&
                                  MediaQuery.of(context).size.width < 843)
                          ? ResponsiveRowColumnType.ROW
                          : ResponsiveRowColumnType.COLUMN,

                      // ResponsiveValue(
                      //   context,
                      //   defaultValue: ResponsiveRowColumnType.COLUMN,
                      //   valueWhen: [
                      //     Condition.equals(name: TABLET, value: ResponsiveRowColumnType.COLUMN )
                      //   ]
                      // ).value ??
                      // ResponsiveRowColumnType.COLUMN,

                      children: [
                        ResponsiveRowColumnItem(child: UserInfo(bid: bid)),
                        const ResponsiveRowColumnItem(
                            child: SizedBox(width: 30)),
                        if (ResponsiveWrapper.of(context)
                            .isSmallerThan(TABLET)) ...[
                          ResponsiveRowColumnItem(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BidBudgetWidget(
                                    budget: bid.budget, hours: bid.hours),
                                const SizedBox(width: 20),
                                BlocBuilder<AuthBloc, AuthState>(
                                  builder: (context, state) {
                                    return ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
                                      ),
                                      onPressed: () {
                                        BlocProvider.of<ProposalsBloc>(context)
                                            .add(
                                          HireFreelancerEvent(
                                            id: id,
                                            freelancerId: bid.freelancerId,
                                            clientId: state is Authenticated
                                                ? state.user.id
                                                : null,
                                            amount: bid.budget,
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 0, 20, 0),
                                        child: Text(
                                          "Hire Now",
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          )
                        ] else ...[
                          ResponsiveRowColumnItem(
                              child: BidBudgetWidget(
                                  budget: bid.budget, hours: bid.hours)),
                          const ResponsiveRowColumnItem(
                            child: SizedBox(width: 20),
                          ),
                          ResponsiveRowColumnItem(
                            child: BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                return ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                  ),
                                  onPressed: () {
                                    BlocProvider.of<ProposalsBloc>(context).add(
                                      HireFreelancerEvent(
                                        id: id,
                                        freelancerId: bid.freelancerId,
                                        clientId: state is Authenticated
                                            ? state.user.id
                                            : null,
                                        amount: bid.budget,
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Text(
                                      "Hire Now",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ]
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 12, 20, 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text("Description",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: 
                                  ReadMoreText(
                                    bid.coverLetter,
                                    trimLines: 2,
                                    colorClickableText: Colors.pink,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: 'Show more',
                                    trimExpandedText: 'Show less',
                                    moreStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                    lessStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                               
                                ),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  const JobCard({
    Key? key,
    required this.job,
  }) : super(key: key);

  final JobProposalEntity? job;

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
                    Title(title: job!.title),
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
                              LanguageWidget(language: job!.language),
                              const SizedBox(width: 30),
                              ExpiryWidget(expiry: job!.expiry),
                            ],
                          ),
                        ),
                        ResponsiveRowColumnItem(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BudgetWidget(
                                  budget: job!.budget, duration: job!.duration),
                              const SizedBox(width: 20),
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
                  Column(
                    crossAxisAlignment:
                        ResponsiveWrapper.of(context).isSmallerThan(TABLET)
                            ? CrossAxisAlignment.center
                            : CrossAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/agreement-bro.svg",
                        height: 100,
                      ),
                      Row(
                        mainAxisAlignment:
                            ResponsiveWrapper.of(context).isSmallerThan(TABLET)
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              "Proposals",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          Text(
                            job!.proposals.toString(),
                            style: Theme.of(context).textTheme.headline5?.merge(
                                  TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                          ),
                        ],
                      ),
                    ],
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

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key, required this.bid}) : super(key: key);

  final BidEntity bid;

  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.network(
            bid.freelancer.profilePicture,
            height: 88,
            width: 88,
            fit: BoxFit.cover,
          ),
        ),

        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              bid.freelancer.firstName + ' ' + bid.freelancer.lastName,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            ResponsiveRowColumn(
              rowSpacing: 5,
              columnSpacing: 5,
              rowMainAxisAlignment: MainAxisAlignment.center,
              columnCrossAxisAlignment: CrossAxisAlignment.start,
              rowMainAxisSize: MainAxisSize.max,
              layout: ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
                  ? ResponsiveRowColumnType.COLUMN
                  : ResponsiveRowColumnType.ROW,
              children: [
                ResponsiveRowColumnItem(
                  child: ResponsiveRowColumn(
                    // rowMainAxisAlignment: MainAxisAlignment.center,
                    // rowCrossAxisAlignment: CrossAxisAlignment.center,
                    columnCrossAxisAlignment: CrossAxisAlignment.start,
                    rowSpacing: 5,
                    columnSpacing: 5,
                    layout: ResponsiveWrapper.of(context).isSmallerThan(TABLET)
                        ? ResponsiveRowColumnType.COLUMN
                        : ResponsiveRowColumnType.ROW,
                    children: [
                      ResponsiveRowColumnItem(
                        child: Text(
                          bid.createdAt.year.toString() +
                              ' ' +
                              bid.createdAt.month.toString() +
                              ', ' +
                              bid.createdAt.day.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      ResponsiveRowColumnItem(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RatingBarIndicator(
                              rating: 1,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 1,
                              itemSize: 15.0,
                              direction: Axis.horizontal,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "${bid.freelancer.numberOfReviews} Reviews",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                ResponsiveRowColumnItem(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.secondary),
                      // maximumSize: MaterialStateProperty.all(const Size(120, 30)),
                    ),
                    onPressed: () {},
                    child: Text(
                      "View Details",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ],
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

class BudgetWidget extends StatelessWidget {
  const BudgetWidget({
    Key? key,
    required this.budget,
    required this.duration,
  }) : super(key: key);

  final double budget;
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

class BidBudgetWidget extends StatelessWidget {
  const BidBudgetWidget({Key? key, required this.budget, required this.hours})
      : super(key: key);

  final double budget;
  final int hours;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          budget.toString(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 10),
        Text(
          "in $hours Hours",
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

class ExpiryWidget extends StatelessWidget {
  const ExpiryWidget({Key? key, required this.expiry}) : super(key: key);

  final String? expiry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          expiry == null
              ? 'Not Specified'
              : "${expiry!.split('::')[0]} Days Left",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          "4 Days Left",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
