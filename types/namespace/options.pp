# @summay Type to set either YES or NO or UNSET
type Slurm::Namespace::Options = Struct[
  {
    Optional['auto_base_path'] => Boolean,
    Optional['base_path'] => Variant[Stdlib::Absolutepath, Enum['none']],
    Optional['clone_ns_script'] => Stdlib::Absolutepath,
    Optional['clone_ns_script_wait'] => Integer,
    Optional['clone_ns_epilog'] => Stdlib::Absolutepath,
    Optional['clone_ns_epilog_wait'] => Integer,
    Optional['clone_ns_flags'] => Array[Enum['CLONE_NEWPID','CLONE_NEWUSER','CLONE_NEWNS']],
    Optional['dirs'] => String[1],
    Optional['init_script'] => Stdlib::Absolutepath,
    Optional['shared'] => Boolean,
    Optional['user_ns_script'] => Stdlib::Absolutepath,
  }
]
