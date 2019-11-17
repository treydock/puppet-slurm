# Private class
class slurm::params {

  $slurm_conf_multiple = [
    'SlurmctldHost'
  ]

  $slurm_conf_defaults = {
    'AccountingStorageBackupHost' => undef,
    'AccountingStorageEnforce' => undef,
    'AccountingStorageTRES' => undef,
    'AccountingStorageType' => 'accounting_storage/slurmdbd',
    'AccountingStoreJobComment' => 'YES',
    'AcctGatherNodeFreq' => '0',
    'AcctGatherEnergyType' => undef,
    'AcctGatherFilesystemType' => undef,
    'AcctGatherProfileType' => undef,
    'AllowSpecResourcesUsage' => '0',
    'AuthInfo' => undef,
    'AuthType' => 'auth/munge',
    'BatchStartTimeout' => '10',
    'BurstBufferType' => undef,
    'CheckpointType' => 'checkpoint/none',
    'CliFilterPlugins' => undef,
    'CommunicationParameters' => undef,
    'CompleteWait' => '0',
    'CoreSpecPlugin' => 'core_spec/none',
    'CpuFreqDef' => undef,
    'CpuFreqGovernors' => 'OnDemand,Performance,UserSpace',
    'CredType' => 'cred/munge',
    'DebugFlags' => undef,
    'DefCpuPerGPU' => undef,
    'DefMemPerCPU' => undef,
    'DefMemPerGPU' => undef,
    'DefMemPerNode' => undef,
    'DisableRootJobs' => 'NO',
    'EioTimeout' => '60',
    'EnforcePartLimits' => 'NO',
    'EpilogMsgTime' => '2000',
    'ExtSensorsFreq' => undef,
    'ExtSensorsType' => undef,
    'FairShareDampeningFactor' => '1',
    'FederationParameters' => undef,
    'FirstJobId' => '1',
    'GetEnvTimeout' => '2',
    'GresTypes' => undef,
    'GroupUpdateForce' => '1',
    'GroupUpdateTime' => '600',
    'GpuFreqDef' => 'high,memory=high',
    'HealthCheckInterval' => '0',
    'HealthCheckNodeState' => 'ANY',
    'InactiveLimit' => '0',
    'JobAcctGatherType' => 'jobacct_gather/cgroup',
    'JobAcctGatherFrequency' => 'task=30,energy=0,network=0,filesystem=0',
    'JobAcctGatherParams' => undef,
    'JobCompType' => 'jobcomp/none',
    'JobFileAppend' => undef,
    'JobRequeue' => '1',
    'JobSubmitPlugins' => undef,
    'KeepAliveTime' => undef,
    'KillOnBadExit' => '0',
    'KillWait' => '30',
    'LaunchParameters' => undef,
    'LaunchType' => 'launch/slurm',
    'Licenses' => undef,
    'LogTimeFormat' => 'iso8601_ms',
    'MailDomain' => undef,
    'MailProg' => '/bin/mail',
    'MaxArraySize' => '1001',
    'MaxJobCount' => '10000',
    'MaxJobId' => '67043328',
    'MaxMemPerCPU' => undef,
    'MaxMemPerNode' => undef,
    'MaxStepCount' => '40000',
    'MaxTasksPerNode' => '512',
    'MCSParameters' => undef,
    'MCSPlugin' => 'mcs/none',
    'MemLimitEnforce' => 'no',
    'MessageTimeout' => '10',
    'MinJobAge' => '300',
    'MpiDefault' => 'none',
    'MsgAggregationParams' => undef,
    'OverTimeLimit' => '0',
    'PluginDir' => '/usr/lib64/slurm',
    'PowerParameters' => undef,
    'PowerPlugin' => undef,
    'PreemptMode' => 'OFF',
    'PreemptType' => 'preempt/none',
    'PreemptExemptTime' => undef,
    'PriorityCalcPeriod' => '5',
    'PriorityDecayHalfLife' => '7-0',
    'PriorityFavorSmall' => 'NO',
    'PriorityFlags' => undef,
    'PriorityMaxAge' => '7-0',
    'PriorityParameters' => undef,
    'PrioritySiteFactorParameters' => undef,
    'PrioritySiteFactorPlugin' => 'site_factor/none',
    'PriorityType' => 'priority/basic',
    'PriorityUsageResetPeriod' => 'NONE',
    'PriorityWeightAge' => '0',
    'PriorityWeightAssoc' => '0',
    'PriorityWeightFairshare' => '0',
    'PriorityWeightJobSize' => '0',
    'PriorityWeightPartition' => '0',
    'PriorityWeightQOS' => '0',
    'PriorityWeightTRES' => '0',
    'PrivateData' => undef,
    'ProctrackType' => 'proctrack/cgroup',
    'PrologEpilogTimeout' => undef,
    'PrologFlags' => undef,
    'PropagatePrioProcess' => '0',
    'PropagateResourceLimits' => 'ALL',
    'PropagateResourceLimitsExcept' => undef,
    'RebootProgram' => undef,
    'ReconfigFlags' => undef,
    'RequeueExit' => undef,
    'RequeueExitHold' => undef,
    'ResumeFailProgram' => undef,
    'ResumeProgram' => undef,
    'ResumeRate' => '300',
    'ResumeTimeout' => '60',
    'ResvOverRun' => '0',
    'ReturnToService' => '0',
    'RoutePlugin' => 'route/default',
    'SallocDefaultCommand' => undef,
    'SbcastParameters' => undef,
    'SchedulerParameters' => undef,
    'SchedulerTimeSlice' => '30',
    'SchedulerType' => 'sched/backfill',
    'SelectType' => 'select/linear',
    'SelectTypeParameters' => undef,
    'SlurmctldAddr' => undef,
    'SlurmctldDebug' => 'info',
    'SlurmctldParameters' => undef,
    'SlurmctldPlugstack' => undef,
    'SlurmctldPidFile' => '/var/run/slurmctld.pid',
    'SlurmctldPrimaryOffProg' => undef,
    'SlurmctldPrimaryOnProg' => undef,
    'SlurmctldSyslogDebug' => undef,
    'SlurmctldTimeout' => '120',
    'SlurmdDebug' => 'info',
    'SlurmdParameters' => undef,
    'SlurmdPidFile' => '/var/run/slurmd.pid',
    'SlurmdSyslogDebug' => undef,
    'SlurmdTimeout' => '300',
    'SlurmSchedLogLevel' => '0',
    'SrunPortRange' => undef,
    'SuspendExcNodes' => undef,
    'SuspendExcParts' => undef,
    'SuspendProgram' => undef,
    'SuspendRate' => '60',
    'SuspendTime' => '-1',
    'SuspendTimeout' => '30',
    'SwitchType' => 'switch/none',
    'TaskPlugin' => 'task/affinity,task/cgroup',
    'TaskPluginParam' => undef,
    'TCPTimeout' => '2',
    'TmpFS' => '/tmp',
    'TopologyParam' => undef,
    'TopologyPlugin'  => 'topology/none',
    'TrackWCKey' => undef,
    'TreeWidth' => '50',
    'UnkillableStepProgram' => undef,
    'UnkillableStepTimeout' => '60',
    'VSizeFactor' => '0',
    'WaitTime' => '0',
    'X11Parameters' => undef,
  }

  $slurmdbd_conf_defaults = {
    'ArchiveDir' => '/tmp',
    'ArchiveEvents' => 'no',
    'ArchiveJobs' => 'no',
    'ArchiveResvs' => 'no',
    'ArchiveSteps' => 'no',
    'ArchiveSuspend' => 'no',
    'AuthType' => 'auth/munge',
    'DebugLevel' => 'info',
    'MessageTimeout' => '10',
    'PidFile' => '/var/run/slurmdbd.pid',
    'PluginDir' => '/usr/lib64/slurm',
    'TrackSlurmctldDown' => 'no',
  }
}
