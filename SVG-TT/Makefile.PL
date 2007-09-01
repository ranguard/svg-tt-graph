use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'SVG::TT::Graph',
    'VERSION_FROM'	=> 'lib/SVG/TT/Graph.pm', # finds $VERSION
    'PREREQ_PM'		=> {
	'Template'	=> 2.08,
	'DateTime'	=> 0.1,
	'HTTP::Date'	=> 0.1,
    }, # e.g., Module::Name => 1.1
);
