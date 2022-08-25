import 'package:clean_flutter/modules/client-job/views/job_detail/pages/job_detail_page.dart';
import 'package:clean_flutter/modules/client-job/views/job_edit/pages/job_edit_page.dart';
import 'package:clean_flutter/modules/client-job/views/job_list/pages/job_list_page.dart';
import 'package:clean_flutter/modules/client-job/views/job_post/pages/job_post_page.dart';
import 'package:clean_flutter/modules/client-job/views/job_proposal/pages/proposals_page.dart';
import 'package:clean_flutter/modules/client-job/views/job_wrapper_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../_core/router/transitions.dart';
import '../../_shared/interface/layout/layout_page.dart';
import '../../_shared/interface/layout/navigation/nav_items.dart';

const String jobRouteName = 'job';
const String jobDetailRouteName = 'job-details';
const String jobEditRouteName = 'job-edit';
const String jobProposalRouteName = 'job-proposal';
const String jobDetailTabRouteName = 'job-detail-tab';
const String jobPostRouteName = 'job-post';

const fadeTransitionKey = ValueKey<String>('Fade Transition Page Key');
const layoutPageKey = ValueKey<String>('Layout Page Key');

final List<GoRoute> jobRoutes = [
  GoRoute(
    path: '/jobs',
    redirect: (_) => '/jobs/all',
  ),
  GoRoute(
    name: jobRouteName,
    path: '/jobs/:kind(all|pending|ongoing|completed|canceled)',
    pageBuilder: (context, state) => FadeTransitionPage(
      key: fadeTransitionKey,
      child: LayoutPage(
        key: layoutPageKey,
        selectedTab: NavigationTab.jobs,
        child: JobWrapperPage(
          child: JobListPage(
            kind: state.params['kind']!,
          ),
        ),
      ),
    ),
    routes: [
      GoRoute(
        name: jobDetailRouteName,
        path: 'details/:id/:tabKind(overview|milestones|files|payments)',
        pageBuilder: (context, state) => FadeTransitionPage(
          key: state.pageKey,
          child: LayoutPage(
            key: layoutPageKey,
            selectedTab: NavigationTab.jobs,
            child: JobWrapperPage(
              child: JobDetailPage(
                id: state.params['id'],
                kind: state.params['kind'],
                tabKind: state.params['tabKind'],
              ),
            ),
            hideBottomAndTopBarOnMobile: true,
          ),
        ),
      ),
      GoRoute(
        name: jobEditRouteName,
        path: 'edit/:id',
        pageBuilder: (context, state) => FadeTransitionPage(
          key: state.pageKey,
          child: LayoutPage(
            key: layoutPageKey,
            selectedTab: NavigationTab.jobs,
            child: JobWrapperPage(
                child: JobEditPage(
              id: state.params['id'],
            )),
            hideBottomAndTopBarOnMobile: true,
          ),
        ),
      ),
      GoRoute(
        name: jobProposalRouteName,
        path: 'proposals/:id',
        pageBuilder: (context, state) => FadeTransitionPage(
          key: state.pageKey,
          child: LayoutPage(
            key: layoutPageKey,
            selectedTab: NavigationTab.jobs,
            child: JobWrapperPage(
                child: ProposalsPage(
              id: state.params['id'],
            )),
            hideBottomAndTopBarOnMobile: true,
          ),
        ),
      ),
      GoRoute(
        name: jobPostRouteName,
        path: 'post',
        pageBuilder: (context, state) => FadeTransitionPage(
          key: state.pageKey,
          child: const LayoutPage(
            key: layoutPageKey,
            selectedTab: NavigationTab.jobs,
            child: JobWrapperPage(
              child: JobPostPage(),
            ),
            hideBottomAndTopBarOnMobile: true,
          ),
        ),
      ),
    ],
  ),
];
