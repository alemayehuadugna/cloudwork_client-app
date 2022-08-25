import 'package:clean_flutter/modules/client-job/views/job_post/blocs/post_job_bloc.dart';
import 'package:clean_flutter/modules/client-job/views/job_post/widgets/post_job_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../_shared/interface/bloc/category/list_bloc/list_category_bloc.dart';
import '../../../../../_shared/interface/pages/widgets/show_top_flash.dart';

class JobPostPage extends StatelessWidget {
  const JobPostPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int count = 0;
    return BlocBuilder<JobPostBloc, JobPostState>(builder: ((context, state) {
      if (state is JobPostLoading) {
        context.loaderOverlay.show();
      }
      return Scaffold(
        appBar: AppBar(title: const Text('Job Post Page')),
        body: 
        BlocBuilder<ListCategoryBloc, ListCategoryState>(
          builder: ((context, state) {
            if (count == 0) {
              BlocProvider.of<ListCategoryBloc>(context)
                  .add(ListCategoryInSubmitted());
              count++;
            }
            return JobPostDisplay();
          }),
        ),
      );
    }));
  }
}
