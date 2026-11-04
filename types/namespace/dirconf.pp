# @summay Type to set either YES or NO or UNSET
type Slurm::Namespace::DirConf = Struct[
  {
    NotUndef['path'] => String[1],
    Optional['base_path'] => Variant[Stdlib::Absolutepath, Enum['none']],
    Optional['options'] => String[1],
    Optional['tmpfs'] => Boolean,
  }
]
