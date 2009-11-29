use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'         => 'Task::SDK::V1',
    'VERSION_FROM' => 'lib/Task/SDK/V1.pm',
    'PREREQ_PM'    => {
        'Test::More' => 0.1,

        # 'Basic Toolchain',
        'Bundle::CPAN' => 0,
        'local::lib'   => 0,
        'version'      => 0,

        # 'Testing',
        'Test::Simple'                   => 0,
        'Test::Most'                     => 0,
        'Test::Exception'                => 0,
        'Test::Pod'                      => 0,
        'Test::Pod::Coverage'            => 0,
        'Test::Memory::Cycle'            => 0,
        'Test::WWW::Mechanize'           => 0,
        'Test::WWW::Mechanize::Catalyst' => 0,

        # 'Exception Handling',
        'Try::Tiny' => 0,

        # 'Object Oriented Programming',
        'Moose'                     => 0,
        'MooseX::Declare'           => 0,
        'MooseX::Types'             => 0,
        'Moose::Autobox'            => 0,
        'MooseX::AttributeHelpers'  => 0,
        'MooseX::Storage'           => 0,
        'MooseX::Getopt'            => 0,
        'MooseX::SimpleConfig'      => 0,
        'MooseX::StrictConstructor' => 0,
        'namespace::autoclean'      => 0,

        # 'XML Development',
        'XML::LibXML'                 => 0,
        'XML::Easy::ProceduralWriter' => 0,

        # 'Web Development',
        'Catalyst'                                 => 0,
        'Catalyst::View::TT'                       => 0,
        'Catalyst::View::JSON'                     => 0,
        'Catalyst::Model::DBIC::Schema'            => 0,
        'Catalyst::Devel'                          => 0,
        'Catalyst::Plugin::Session'                => 0,
        'Catalyst::Plugin::Session::State::Cookie' => 0,
        'Catalyst::Plugin::Session::Store::DBIC'   => 0,
        'Catalyst::Plugin::Authentication'         => 0,
        'Catalyst::Plugin::StackTrace'             => 0,

        'Catalyst::Plugin::Static::Simple' => 0,

        'Catalyst::Plugin::FillInForm'      => 0,
        'Catalyst::Plugin::FormValidator'   => 0,
        'Catalyst::Plugin::RunAfterRequest' => 0.02,

        #? Catalyst::Plugin::AutoCRUD

        # 'Data manipulation'
        'Encode'                          => 0,
        'JSON::XS'                        => 0,
        'Text::CSV_XS'                    => 0,
        'XML::RSS'                        => 0,
        'Spreadsheet::WriteExcel::Simple' => 0,
        'Spreadsheet::ParseExcel::Simple' => 0,

        # Email
        'Email::Sender' => 0,
        'Email::Valid'  => 0,

        # File / Directory / IO
        'Archive::Tar'         => 0,
        'Archive::Zip'         => 0,
        'File::Copy::Reliable' => 0,
        'File::Find::Rule'     => 0,
        'File::Slurp'          => 0,
        'IO::All'              => 0,
        'MIME::Types'          => 0,
        'Path::Class'          => 0,
        'PathTools'            => 0,

        # Templates
        'Template::Plugin::Comma'    => 0,
        'Template::Plugin::DateTime' => 0,

        #? http-async-
        #? lockfile?
        #? perl::critic

        # 'Database Development',
        'DBI'                         => 0,
        'DBD::SQLite'                 => 0,
        'DBD::mysql'                  => 0,
        'DBD::Pg'                     => 0,
        'DBIx::Class'                 => 0,
        'DBIx::Class::Schema::Loader' => 0,

        # 'Web Crawling',
        'Bundle::LWP'    => 0,
        'LWP::Simple'    => 0,
        'WWW::Mechanize' => 0,

        # 'Module Development',
        'Devel::Cover'      => 0,
        'Devel::NYTProf'    => 0,
        'Perl::Tidy'        => 0,
        'Carp::Always'      => 0,
        'Modern::Perl'      => 0,
        'Perl::Version'     => 0,
        'Software::License' => 0,
        'Pod::Readme'       => 0,

        # Debugging / timing
        'Log::Log4perl'             => 0,
        'Benchmark::Stopwatch'      => 0,
        'Term::Progressbar::Simple' => 0,

        # 'Date Modules',
        'DateTime'        => 0,
        'Time::ParseDate' => 0,

        # 'Config Modules',
        'Config::Any'     => 0,
        'Config::General' => 0,

        # 'Useful Command-line Tools'
        'App::Ack' => 0,

        # Utils and 'stuff'
        'Array::Compare'                => 0,
        'Clone'                         => 0,
        'Crypt::SSLeay'                 => 0,
        'Data::Pageset'                 => 0,
        'Data::UUID'                    => 0,
        'IPC::Run3'                     => 0,
        'List::AllUtils'                => 0,
        'Lingua::EN::Numbers::Ordinate' => 0,

    },
);
