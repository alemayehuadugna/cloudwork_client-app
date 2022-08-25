import '../models/hive/job_hive_model.dart';
import '../models/json/job_remote_model.dart';
import '../../domain/entities/job.dart';

class JobMapper {
  static JobRemoteModel toModel(JobEntity job) {
    // List<BidRemoteModel> bids = [];
    // bids.addAll(
    //   job.bid.map((e) => BidRemoteModel(e.freelancerId, e.budget, e.hours, e.coverLetter, e.isTermsAndConditionAgreed))
    // );

    List<FreelancerRemoteModel> freelancers = [];
    if (job.freelancerId != null) {
      freelancers.addAll(job.freelancerId!.map(
        (e) => FreelancerRemoteModel(
          e.freelancerId,
          e.firstName,
          e.lastName,
          e.profilePicture,
        ),
      ));
    }

    JobRemoteModel jobRemoteModel = JobRemoteModel(
      job.id,
      job.clientId,
      job.freelancerId == null ? null : freelancers,
      job.title,
      job.skills,
      job.budget,
      job.duration,
      job.proposals,
      job.expiry,
      // job.category,
      job.language,
      job.progress,
      // job.experience,
      job.startDate,
      // job.links,
      // job.description,
      // job.files,
      // bids,
    );

    return jobRemoteModel;
  }

  static List<JobEntity> toRemoteEntity(List<JobRemoteModel> jobModel) {
    // List<BidEntity> bids = [];
    // for (int i = 0; i < jobModel.length; i++) {
    //   bids.addAll(
    //     jobModel[i].bid.map((e) => BidEntity(e.freelancerId, e.budget, e.hours, e.coverLetter, e.isTermsAndConditionAgreed,),)
    //   );
    // }

    List<FreelancerEntity> freelancers = [];
    List<JobEntity> job = [];
    JobEntity single;
    for (int i = 0; i < jobModel.length; i++) {
      if (jobModel[i].freelancerId != null) {
        freelancers.addAll(jobModel[i].freelancerId!.map(
              (e) => FreelancerEntity(
                e.freelancerId,
                e.firstName,
                e.lastName,
                e.profilePicture,
              ),
            ));
      }
      single = JobEntity(
        id: jobModel[i].id,
        clientId: jobModel[i].clientId,
        freelancerId: jobModel[i].freelancerId == null ? null : freelancers,
        title: jobModel[i].title,
        skills: jobModel[i].skills,
        budget: jobModel[i].budget,
        duration: jobModel[i].duration,
        proposals: jobModel[i].proposals,
        expiry: jobModel[i].expiry,
        // category: jobModel[i].category,
        language: jobModel[i].language,
        progress: jobModel[i].progress,
        startDate: jobModel[i].startDate,
        // experience: jobModel[i].experience,
        // links: jobModel[i].links,
        // description: jobModel[i].description,
        // files: jobModel[i].files,
        // bid: bids
      );

      job.add(single);
      freelancers = [];
    }

    return job;
  }

  static JobDetailEntity jobDetailToRemoteEntity(
      JobDetailRemoteModel jobModel) {
    // List<BidEntity> bids = [];
    // bids.addAll(jobModel.bid.map(
    //   (e) => BidEntity(
    //     e.freelancerId,
    //     e.budget,
    //     e.hours,
    //     e.coverLetter,
    //     e.isTermsAndConditionAgreed,
    //   ),
    // ));

    List<FreelancerEntity> freelancers = [];
    if (jobModel.freelancerId != null) {
      freelancers.addAll(jobModel.freelancerId!.map(
        (e) => FreelancerEntity(
          e.freelancerId,
          e.firstName,
          e.lastName,
          e.profilePicture,
        ),
      ));
    }

    return JobDetailEntity(
      id: jobModel.id,
      clientId: jobModel.clientId,
      freelancerId: jobModel.freelancerId == null ? null : freelancers,
      title: jobModel.title,
      skills: jobModel.skills,
      budget: jobModel.budget,
      duration: jobModel.duration,
      proposals: jobModel.proposals,
      expiry: jobModel.expiry,
      category: jobModel.category,
      language: jobModel.language,
      progress: jobModel.progress,
      startDate: jobModel.startDate,
      links: jobModel.links,
      description: jobModel.description,
      files: jobModel.files,
      // bid: bids,
    );
  }

  static List<JobEntity> toLocalEntity(List<JobHiveModel> jobModel) {
    // List<BidEntity> bids = [];
    // for (int i = 0; i < jobModel.length; i++) {
    //   bids.addAll(
    //     jobModel[i].bid.map((e) => BidEntity(e.freelancerId, e.budget, e.hours, e.coverLetter, e.isTermsAndConditionAgreed,),)
    //   );
    // }

    List<FreelancerEntity> freelancers = [];
    List<JobEntity> job = [];
    JobEntity single;
    for (int i = 0; i < jobModel.length; i++) {
      if (jobModel[i].freelancerId != null) {
        freelancers.addAll(jobModel[i].freelancerId!.map(
              (e) => FreelancerEntity(
                e.freelancerId,
                e.firstName,
                e.lastName,
                e.profilePicture,
              ),
            ));
      }
      single = JobEntity(
        id: jobModel[i].id,
        clientId: jobModel[i].clientId,
        freelancerId: jobModel[i].freelancerId == null ? null : freelancers,
        title: jobModel[i].title,
        skills: jobModel[i].skills,
        budget: jobModel[i].budget,
        duration: jobModel[i].duration,
        proposals: jobModel[i].proposals,
        expiry: jobModel[i].expiry,
        // category: jobModel[i].category,
        language: jobModel[i].language,
        progress: jobModel[i].progress,
        startDate: jobModel[i].startDate,
        // experience: jobModel[i].experience,
        // links: jobModel[i].links,
        // description: jobModel[i].description,
        // files: jobModel[i].files,
        // bid: bids,
      );

      job.add(single);
      freelancers = [];
    }

    return job;
  }

  static JobDetailEntity jobDetailToLocalEntity(JobDetailHiveModel jobModel) {
    // List<BidEntity> bids = [];
    // bids.addAll(jobModel.bid.map(
    //   (e) => BidEntity(
    //     e.freelancerId,
    //     e.budget,
    //     e.hours,
    //     e.coverLetter,
    //     e.isTermsAndConditionAgreed,
    //   ),
    // ));

    List<FreelancerEntity> freelancers = [];
    if (jobModel.freelancerId != null) {
      freelancers.addAll(jobModel.freelancerId!.map(
        (e) => FreelancerEntity(
          e.freelancerId,
          e.firstName,
          e.lastName,
          e.profilePicture,
        ),
      ));
    }

    return JobDetailEntity(
      id: jobModel.id,
      clientId: jobModel.clientId,
      freelancerId: jobModel.freelancerId == null ? null : freelancers,
      title: jobModel.title,
      skills: jobModel.skills,
      budget: jobModel.budget,
      duration: jobModel.duration,
      proposals: jobModel.proposals,
      expiry: jobModel.expiry,
      category: jobModel.category,
      language: jobModel.language,
      progress: jobModel.progress,
      startDate: jobModel.startDate,
      links: jobModel.links,
      description: jobModel.description,
      files: jobModel.files,
      // bid: bids,
    );
  }

  static JobRemoteModel fromJson(Map<String, dynamic> json) {
    // ignore: prefer_typing_uninitialized_variables
    var job;
    // List<BidRemoteModel> bids = [];
    List<FreelancerRemoteModel> freelancers = [];

    try {
      job = JobRemoteModel.fromJson(json);
      // job.bid.forEach((e) {
      //   bids.add(BidRemoteModel(e.freelancerId, e.budget, e.hours, e.coverLetter, e.isTermsAndConditionAgreed));
      // });
      if (job.freelancerId != null) {
        job.freelancerId.forEach((e) {
          freelancers.add(
            FreelancerRemoteModel(
              e.freelancerId,
              e.firstName,
              e.lastName,
              e.profilePicture,
            ),
          );
        });
      }
    } catch (e) {
      print("in job mapper -->");
      print(e);
    }

    final JobRemoteModel jobRemoteModel = JobRemoteModel(
      job.id,
      job.clientId,
      job.freelancerId == null ? null : freelancers,
      job.title,
      job.skills,
      job.budget,
      job.duration,
      job.proposals,
      job.expiry,
      // job.category,
      job.language,
      job.progress,
      // job.experience,
      job.startDate,
      // job.links,
      // job.description,
      // job.files,
      // bids,
    );
    return jobRemoteModel;
  }

  static JobDetailRemoteModel detailFromJson(Map<String, dynamic> json) {
    // ignore: prefer_typing_uninitialized_variables
    var job;
    // List<BidRemoteModel> bids = [];
    List<FreelancerRemoteModel> freelancers = [];

    try {
      job = JobDetailRemoteModel.fromJson(json);

      // job.bid.forEach((e) {
      //   bids.add(BidRemoteModel(e.freelancerId, e.budget, e.hours,
      //       e.coverLetter, e.isTermsAndConditionAgreed));
      // });
      if (job.freelancerId != null) {
        job.freelancerId.forEach((e) {
          freelancers.add(
            FreelancerRemoteModel(
              e.freelancerId,
              e.firstName,
              e.lastName,
              e.profilePicture,
            ),
          );
        });
      }
    } catch (e) {
      print("in job mapper -->");
      print(e);
    }

    final JobDetailRemoteModel jobDetailRemoteModel = JobDetailRemoteModel(
      job.id,
      job.clientId,
      job.freelancerId == null ? null : freelancers,
      job.title,
      job.skills,
      job.budget,
      job.duration,
      job.proposals,
      job.expiry,
      job.category,
      job.language,
      job.progress,
      job.startDate,
      job.links,
      job.description,
      job.files,
      // job.bids,
    );
    return jobDetailRemoteModel;
  }

  static JobProposalEntity jobProposalToRemoteEntity(
      JobProposalRemoteModel jobModel) {
    List<BidEntity> bids = [];
    bids.addAll(jobModel.bid.map(
      (e) => BidEntity(
        e.freelancerId,
        e.budget,
        e.hours,
        e.coverLetter,
        e.isTermsAndConditionAgreed,
        e.createdAt,
        ProposalFreelancerEntity(e.freelancer.firstName, e.freelancer.lastName,
            e.freelancer.profilePicture, e.freelancer.numberOfReviews),
      ),
    ));

    return JobProposalEntity(
      id: jobModel.id,
      clientId: jobModel.clientId,
      freelancerId: jobModel.freelancerId,
      title: jobModel.title,
      skills: jobModel.skills,
      budget: jobModel.budget,
      duration: jobModel.duration,
      proposals: jobModel.proposals,
      expiry: jobModel.expiry,
      category: jobModel.category,
      language: jobModel.language,
      progress: jobModel.progress,
      startDate: jobModel.startDate,
      links: jobModel.links,
      description: jobModel.description,
      files: jobModel.files,
      bid: bids,
    );
  }

  static JobProposalEntity jobProposalToLocalEntity(
      JobProposalHiveModel jobModel) {
    List<BidEntity> bids = [];
    bids.addAll(jobModel.bid.map(
      (e) => BidEntity(
        e.freelancerId,
        e.budget,
        e.hours,
        e.coverLetter,
        e.isTermsAndConditionAgreed,
        e.createdAt,
        ProposalFreelancerEntity(e.freelancer.firstName, e.freelancer.lastName,
            e.freelancer.profilePicture, e.freelancer.numberOfReviews),
      ),
    ));

    return JobProposalEntity(
      id: jobModel.id,
      clientId: jobModel.clientId,
      freelancerId: jobModel.freelancerId,
      title: jobModel.title,
      skills: jobModel.skills,
      budget: jobModel.budget,
      duration: jobModel.duration,
      proposals: jobModel.proposals,
      expiry: jobModel.expiry,
      category: jobModel.category,
      language: jobModel.language,
      progress: jobModel.progress,
      startDate: jobModel.startDate,
      links: jobModel.links,
      description: jobModel.description,
      files: jobModel.files,
      bid: bids,
    );
  }

  static JobProposalRemoteModel proposalFromJson(Map<String, dynamic> json) {
    // ignore: prefer_typing_uninitialized_variables
    var job;
    List<BidRemoteModel> bids = [];

    try {
      job = JobProposalRemoteModel.fromJson(json);
      job.bid.forEach((e) {
        bids.add(
          BidRemoteModel(
            e.freelancerId,
            e.budget,
            e.hours,
            e.coverLetter,
            e.isTermsAndConditionAgreed,
            e.createdAt,
            ProposalFreelancerRemoteModel(
                e.freelancer.firstName,
                e.freelancer.lastName,
                e.freelancer.profilePicture,
                e.freelancer.numberOfReviews),
          ),
        );
      });
    } catch (e) {
      print("in job mapper -->");
      print(e);
    }

    final JobProposalRemoteModel jobProposalRemoteModel =
        JobProposalRemoteModel(
      job.id,
      job.clientId,
      job.freelancerId,
      job.title,
      job.skills,
      job.budget,
      job.duration,
      job.proposals,
      job.expiry,
      job.category,
      job.language,
      job.progress,
      job.startDate,
      job.links,
      job.description,
      job.files,
      bids,
    );

    return jobProposalRemoteModel;
  }

  static JobIdEntity jobIdToRemoteEntity(JobIdRemoteModel idModel) {
    return JobIdEntity(id: idModel.id);
  }

  static JobIdRemoteModel jobIdFromJson(Map<String, dynamic> json) {
    // ignore: prefer_typing_uninitialized_variables
    var id;

    try {
      id = JobIdRemoteModel.fromJson(json);
    } catch (e) {
      print("in job id mapper -->");
      print(e);
    }

    final JobIdRemoteModel jobIdRemoteModel = JobIdRemoteModel(id.id);

    return jobIdRemoteModel;
  }

  static List<MilestoneEntity> milestoneToRemoteEntity(
      List<MilestoneRemoteModel> milestoneModel) {
    List<MilestoneEntity> milestone = [];
    MilestoneEntity single;

    for (int i = 0; i < milestoneModel.length; i++) {
      single = MilestoneEntity(
        milestoneModel[i].milestoneId,
        milestoneModel[i].name,
        milestoneModel[i].budget,
        milestoneModel[i].startDate,
        milestoneModel[i].endDate,
        milestoneModel[i].description,
        milestoneModel[i].state,
        milestoneModel[i].datePaid
      );

      milestone.add(single);
    }

    return milestone;
  }

  static MilestoneRemoteModel milestoneFromJson(Map<String, dynamic> json) {
    // ignore: prefer_typing_uninitialized_variables
    var milestone;
    List<MilestoneRemoteModel> milestones = [];

    try {
      milestone = MilestoneRemoteModel.fromJson(json);
    } catch (e) {
      print("in job id mapper -->");
      print(e);
    }

    final MilestoneRemoteModel milestoneRemoteModel = MilestoneRemoteModel(
        milestone.milestoneId,
        milestone.name,
        milestone.budget,
        milestone.startDate,
        milestone.endDate,
        milestone.description,
        milestone.state, 
        milestone.datePaid
      );

    return milestoneRemoteModel;
  }
}
