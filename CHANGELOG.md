# Change log

All notable changes to this project will be documented in this file. The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org).

## [v4.0.0](https://github.com/treydock/puppet-slurm/tree/v4.0.0) (2024-03-25)

[Full Changelog](https://github.com/treydock/puppet-slurm/compare/v3.2.0...v4.0.0)

### Changed

- Support Slurm 23.11 [\#54](https://github.com/treydock/puppet-slurm/pull/54) ([treydock](https://github.com/treydock))

## [v3.2.0](https://github.com/treydock/puppet-slurm/tree/v3.2.0) (2024-02-18)

[Full Changelog](https://github.com/treydock/puppet-slurm/compare/v3.1.0...v3.2.0)

### Added

- Support deploying scrun.lua [\#56](https://github.com/treydock/puppet-slurm/pull/56) ([treydock](https://github.com/treydock))

## [v3.1.0](https://github.com/treydock/puppet-slurm/tree/v3.1.0) (2024-02-15)

[Full Changelog](https://github.com/treydock/puppet-slurm/compare/v3.0.0...v3.1.0)

### Added

- Support managing oci.conf [\#55](https://github.com/treydock/puppet-slurm/pull/55) ([treydock](https://github.com/treydock))

### Fixed

- Deploy topology.conf unconditionally [\#53](https://github.com/treydock/puppet-slurm/pull/53) ([optiz0r](https://github.com/optiz0r))

## [v3.0.0](https://github.com/treydock/puppet-slurm/tree/v3.0.0) (2023-12-28)

[Full Changelog](https://github.com/treydock/puppet-slurm/compare/v2.4.0...v3.0.0)

### Changed

- Drop Debian 10, Add EL9, Debian 11, Ubuntu 22.04 [\#50](https://github.com/treydock/puppet-slurm/pull/50) ([treydock](https://github.com/treydock))
- Support Slurm 23.02.x [\#48](https://github.com/treydock/puppet-slurm/pull/48) ([treydock](https://github.com/treydock))
- BREAKING: Many updates - read description [\#46](https://github.com/treydock/puppet-slurm/pull/46) ([treydock](https://github.com/treydock))

### Added

- Support install\_method being 'none' [\#49](https://github.com/treydock/puppet-slurm/pull/49) ([treydock](https://github.com/treydock))
- Test against Slurm 22.05.4 [\#44](https://github.com/treydock/puppet-slurm/pull/44) ([treydock](https://github.com/treydock))

## [v2.4.0](https://github.com/treydock/puppet-slurm/tree/v2.4.0) (2022-08-11)

[Full Changelog](https://github.com/treydock/puppet-slurm/compare/v2.3.0...v2.4.0)

### Added

- Add slurm\_nodes fact [\#43](https://github.com/treydock/puppet-slurm/pull/43) ([treydock](https://github.com/treydock))

## [v2.3.0](https://github.com/treydock/puppet-slurm/tree/v2.3.0) (2022-08-09)

[Full Changelog](https://github.com/treydock/puppet-slurm/compare/v2.2.0...v2.3.0)

### Added

- Allow newer munge module [\#42](https://github.com/treydock/puppet-slurm/pull/42) ([treydock](https://github.com/treydock))
- Set allowed puppet-epel version to \< 5.0.0 [\#41](https://github.com/treydock/puppet-slurm/pull/41) ([yorickps](https://github.com/yorickps))

## [v2.2.0](https://github.com/treydock/puppet-slurm/tree/v2.2.0) (2022-07-25)

[Full Changelog](https://github.com/treydock/puppet-slurm/compare/v2.1.0...v2.2.0)

### Added

- Move main slurm.conf to defined type to allow multiple config files [\#40](https://github.com/treydock/puppet-slurm/pull/40) ([treydock](https://github.com/treydock))

## [v2.1.0](https://github.com/treydock/puppet-slurm/tree/v2.1.0) (2022-06-30)

[Full Changelog](https://github.com/treydock/puppet-slurm/compare/v2.0.2...v2.1.0)

### Added

- Bump default version to 21.08.8 [\#39](https://github.com/treydock/puppet-slurm/pull/39) ([treydock](https://github.com/treydock))
- add the ability to enable AMD GPUs [\#38](https://github.com/treydock/puppet-slurm/pull/38) ([v1peractual](https://github.com/v1peractual))

## [v2.0.2](https://github.com/treydock/puppet-slurm/tree/v2.0.2) (2022-01-20)

[Full Changelog](https://github.com/treydock/puppet-slurm/compare/v2.0.1...v2.0.2)

### Fixed

- Fix how logrotate when scheduler logs are enabled when using syslog [\#35](https://github.com/treydock/puppet-slurm/pull/35) ([treydock](https://github.com/treydock))

## [v2.0.1](https://github.com/treydock/puppet-slurm/tree/v2.0.1) (2021-12-06)

[Full Changelog](https://github.com/treydock/puppet-slurm/compare/v2.0.0...v2.0.1)

### Fixed

- Update supported version in README [\#34](https://github.com/treydock/puppet-slurm/pull/34) ([treydock](https://github.com/treydock))

## [v2.0.0](https://github.com/treydock/puppet-slurm/tree/v2.0.0) (2021-12-06)

[Full Changelog](https://github.com/treydock/puppet-slurm/compare/v1.0.0...v2.0.0)

### Changed

- Replace CentOS 8 support with Rocky 8 [\#33](https://github.com/treydock/puppet-slurm/pull/33) ([treydock](https://github.com/treydock))
- BREAKING: Support SLURM 21.08 and breaking changes \(see description\) [\#32](https://github.com/treydock/puppet-slurm/pull/32) ([treydock](https://github.com/treydock))

## [v1.0.0](https://github.com/treydock/puppet-slurm/tree/v1.0.0) (2021-10-06)

[Full Changelog](https://github.com/treydock/puppet-slurm/compare/v0.7.0...v1.0.0)

### Changed

- Refactor how slurmrestd is configured to work with SLURM 20.11 [\#30](https://github.com/treydock/puppet-slurm/pull/30) ([treydock](https://github.com/treydock))
- Package version set using package\_ensure, source uses version parameter [\#21](https://github.com/treydock/puppet-slurm/pull/21) ([treydock](https://github.com/treydock))
- Drop Puppet 5 support, add Puppet 7 [\#18](https://github.com/treydock/puppet-slurm/pull/18) ([treydock](https://github.com/treydock))

### Added

- Support newer stdlib, logrotate and archive modules [\#31](https://github.com/treydock/puppet-slurm/pull/31) ([treydock](https://github.com/treydock))
- Updates to module dependencies [\#29](https://github.com/treydock/puppet-slurm/pull/29) ([treydock](https://github.com/treydock))
- Improve how source install is handled [\#28](https://github.com/treydock/puppet-slurm/pull/28) ([treydock](https://github.com/treydock))
- Support Ubuntu 18.04 and 20.04 [\#27](https://github.com/treydock/puppet-slurm/pull/27) ([treydock](https://github.com/treydock))
- Improved Debian 10 support - improve EL8 dependencies for source install [\#26](https://github.com/treydock/puppet-slurm/pull/26) ([treydock](https://github.com/treydock))
- Bump default version to 20.11.8 [\#25](https://github.com/treydock/puppet-slurm/pull/25) ([treydock](https://github.com/treydock))
- Add Debian 10 support [\#24](https://github.com/treydock/puppet-slurm/pull/24) ([martijndegouw](https://github.com/martijndegouw))
- Allow configuring munge via this module [\#23](https://github.com/treydock/puppet-slurm/pull/23) ([martijndegouw](https://github.com/martijndegouw))
- Allow spank plugin to be set to ensure =\> absent [\#20](https://github.com/treydock/puppet-slurm/pull/20) ([treydock](https://github.com/treydock))
- Add ability to manage job\_container.conf [\#19](https://github.com/treydock/puppet-slurm/pull/19) ([treydock](https://github.com/treydock))
- Ensure all logging defaults to info [\#16](https://github.com/treydock/puppet-slurm/pull/16) ([treydock](https://github.com/treydock))
- Support SLURM 20.11 [\#15](https://github.com/treydock/puppet-slurm/pull/15) ([treydock](https://github.com/treydock))

### Fixed

- Do not sort spank plugin arguments [\#17](https://github.com/treydock/puppet-slurm/pull/17) ([treydock](https://github.com/treydock))

## [v0.7.0](https://github.com/treydock/puppet-slurm/tree/v0.7.0) (2020-12-02)

[Full Changelog](https://github.com/treydock/puppet-slurm/compare/v0.6.3...v0.7.0)

### Added

- PDK update - Use Github Actions [\#14](https://github.com/treydock/puppet-slurm/pull/14) ([treydock](https://github.com/treydock))
- Improved support for slurmrestd as a daemon [\#12](https://github.com/treydock/puppet-slurm/pull/12) ([treydock](https://github.com/treydock))

## [v0.6.3](https://github.com/treydock/puppet-slurm/tree/v0.6.3) (2020-11-23)

[Full Changelog](https://github.com/treydock/puppet-slurm/compare/v0.6.2...v0.6.3)

### Fixed

- Fix template error for Hash values in slurm.conf [\#13](https://github.com/treydock/puppet-slurm/pull/13) ([treydock](https://github.com/treydock))

## [v0.6.2](https://github.com/treydock/puppet-slurm/tree/v0.6.2) (2020-08-21)

[Full Changelog](https://github.com/treydock/puppet-slurm/compare/v0.6.1...v0.6.2)

### Fixed

- Fix usage of slurmdbd\_conn\_validator [\#11](https://github.com/treydock/puppet-slurm/pull/11) ([treydock](https://github.com/treydock))

## [v0.6.1](https://github.com/treydock/puppet-slurm/tree/v0.6.1) (2020-08-17)

[Full Changelog](https://github.com/treydock/puppet-slurm/compare/v0.6.0...v0.6.1)

### Fixed

- Actually define slurm::nodeset from parameter [\#10](https://github.com/treydock/puppet-slurm/pull/10) ([treydock](https://github.com/treydock))

## [v0.6.0](https://github.com/treydock/puppet-slurm/tree/v0.6.0) (2020-08-11)

[Full Changelog](https://github.com/treydock/puppet-slurm/compare/v0.5.1...v0.6.0)

### Added

- Add package\_ensure parameter to slurm::spank [\#9](https://github.com/treydock/puppet-slurm/pull/9) ([treydock](https://github.com/treydock))

## [v0.5.1](https://github.com/treydock/puppet-slurm/tree/v0.5.1) (2020-08-10)

[Full Changelog](https://github.com/treydock/puppet-slurm/compare/v0.5.0...v0.5.1)

### Fixed

- Fix slurm::spank when managing package and using configless [\#8](https://github.com/treydock/puppet-slurm/pull/8) ([treydock](https://github.com/treydock))

## [v0.5.0](https://github.com/treydock/puppet-slurm/tree/v0.5.0) (2020-08-10)

[Full Changelog](https://github.com/treydock/puppet-slurm/compare/v0.4.0...v0.5.0)

### Added

- Support Hash, Array and String arguments for slurm::spank [\#7](https://github.com/treydock/puppet-slurm/pull/7) ([treydock](https://github.com/treydock))

## [v0.4.0](https://github.com/treydock/puppet-slurm/tree/v0.4.0) (2020-07-23)

[Full Changelog](https://github.com/treydock/puppet-slurm/compare/v0.3.0...v0.4.0)

### Added

- Make including slurm::resources class opt-in [\#6](https://github.com/treydock/puppet-slurm/pull/6) ([treydock](https://github.com/treydock))

## [v0.3.0](https://github.com/treydock/puppet-slurm/tree/v0.3.0) (2020-07-16)

[Full Changelog](https://github.com/treydock/puppet-slurm/compare/v0.2.1...v0.3.0)

### Added

- Add cli\_filter\_lua\_source and cli\_filter\_lua\_content parameters [\#5](https://github.com/treydock/puppet-slurm/pull/5) ([treydock](https://github.com/treydock))

## [v0.2.1](https://github.com/treydock/puppet-slurm/tree/v0.2.1) (2020-07-13)

[Full Changelog](https://github.com/treydock/puppet-slurm/compare/v0.2.0...v0.2.1)

### Fixed

- DIsable diff of slurmdbd.conf [\#4](https://github.com/treydock/puppet-slurm/pull/4) ([treydock](https://github.com/treydock))

## [v0.2.0](https://github.com/treydock/puppet-slurm/tree/v0.2.0) (2020-07-13)

[Full Changelog](https://github.com/treydock/puppet-slurm/compare/v0.1.0...v0.2.0)

### Added

- Add licenses and slurmdbd\_conn\_validator\_timeout parameters [\#3](https://github.com/treydock/puppet-slurm/pull/3) ([treydock](https://github.com/treydock))

## [v0.1.0](https://github.com/treydock/puppet-slurm/tree/v0.1.0) (2020-06-26)

[Full Changelog](https://github.com/treydock/puppet-slurm/compare/0.0.2...v0.1.0)

### Changed

- Add SLURM 20.02 support [\#2](https://github.com/treydock/puppet-slurm/pull/2) ([treydock](https://github.com/treydock))
- Modernize module - complete rewrite [\#1](https://github.com/treydock/puppet-slurm/pull/1) ([treydock](https://github.com/treydock))

## [0.0.2](https://github.com/treydock/puppet-slurm/tree/0.0.2) (2014-10-14)

[Full Changelog](https://github.com/treydock/puppet-slurm/compare/0.0.1...0.0.2)

## [0.0.1](https://github.com/treydock/puppet-slurm/tree/0.0.1) (2014-10-13)

[Full Changelog](https://github.com/treydock/puppet-slurm/compare/131755fbf1fae5393792afe181ee909205307bcf...0.0.1)



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
