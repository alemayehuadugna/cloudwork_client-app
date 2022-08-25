import 'package:clean_flutter/_shared/interface/bloc/category/list_bloc/list_category_bloc.dart';
import 'package:clean_flutter/modules/client-job/views/job_edit/bloc/edit_job_bloc.dart';
import 'package:clean_flutter/modules/client-job/views/job_edit/widgets/edit_job_display.dart';
import 'package:clean_flutter/modules/client-job/views/job_edit/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../_shared/interface/pages/widgets/show_top_flash.dart';
import '../../../common/params.dart';

class JobEditPage extends StatelessWidget {
  final String? id;
  const JobEditPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    buildCount = 0;
    return BlocConsumer<JobEditBloc, JobEditState>(
      listener: ((context, state) {
      if (state is JobEditLoading) {
        context.loaderOverlay.show();
      } else if (state is JobDetailForEditLoading) {
        context.loaderOverlay.show();
      } else if (state is ErrorLoadingJobDetailForEdit) {
        showTopSnackBar(
            title: const Text('Error'),
            content: Text(state.message),
            icon: const Icon(Icons.error),
            context: context);
        context.loaderOverlay.hide();
      } else if (state is JobDetailForEditLoaded) {
        detailJob = state.job;
        context.loaderOverlay.hide();
      } else if (state is JobEditLoaded) {
        detailJob = state.job;
        showTopSnackBar(
            title: const Text('Success'),
            content: Text("Editted Successfully"),
            icon: const Icon(Icons.error),
            context: context);
        context.loaderOverlay.hide();
        Navigator.pop(context);
      } else if (state is ErrorLoadingJobEdit) {
        showTopSnackBar(
            title: const Text('Error'),
            content: Text(state.message),
            icon: const Icon(Icons.error),
            context: context);
        context.loaderOverlay.hide();
        Navigator.pop(context);
      }
    }), builder: ((context, state) {
      if (state is JobDetailForEditInitial) {
        BlocProvider.of<ListCategoryBloc>(context)
            .add(ListCategoryInSubmitted());

        var _jobDetailBloc = BlocProvider.of<JobEditBloc>(context);
        _jobDetailBloc.add(GetJobForEditEvent(id: id!));
      }
      if (state is JobDetailForEditLoaded || state is JobEditLoaded) {
        buildCount = 0;
        return Scaffold(
          appBar: AppBar(title: const Text('Job Edit Page')),
          body: JobEditDisplay(job: detailJob!),
        );
      } else {
        return Scaffold(
          appBar: AppBar(title: const Text('Job Edit Page')),
          body: const Center(child: CircularProgressIndicator()),
        );
      }
    }));
  }
}
