use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'		=> 'iCal::2::RSS',
    'VERSION_FROM'	=> 'lib/iCal::2::RSS.pm',
    'PREREQ_PM'		=> {
		'Data::Page'	=> 2.00,
		'Test::More' 	=> 0.1,
    }, 
);
