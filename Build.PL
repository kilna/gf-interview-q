use 5.006;
use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'GFQuestion',
    license             => 'perl',
    dist_author         => q{Anthony Kilna <kilna@kilna.com>},
    dist_version_from   => 'lib/GFQuestion1.pm',
    dist_abstract       => 'Answers to coding challenges for GF',
    configure_requires => {
        'Module::Build' => 0,
    },
    build_requires => {
        'Test::More'    => 0,
        'FindBin'       => 0,
    },
    requires => {
        'perl'                  => 5.008,
        'Carp'                  => 0,
        'Exporter'              => 0,
    },
    add_to_cleanup      => [ 'GFQuestion-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();

