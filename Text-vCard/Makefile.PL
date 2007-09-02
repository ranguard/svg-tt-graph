use ExtUtils::MakeMaker;

my $VERSION = '2.01';

my $ABSTRACT = "Module for parsing and creating vCards (RFC 2426) address";

WriteMakefile(
 	'NAME'		=> 'Text::vCard',
	'ABSTRACT'	=> $ABSTRACT,
	'AUTHOR'	=> 'Leo Lapworth',
	'VERSION'	=> $VERSION, # finds $VERSION
	'PREREQ_PM'		=> {
    	Text::vFile::asData => 0.05,
    	Test::More 			=> 0.1,
		File::Slurp 		=> 9999.04,
		MIME::QuotedPrint 	=> 3.07,
    }, 
);
