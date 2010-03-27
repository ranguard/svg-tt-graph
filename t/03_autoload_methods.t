use lib qw( ./blib/lib ../blib/lib );

# Test using the methods to set the config

use Test::More tests => 6;

BEGIN { use_ok( 'SVG::TT::Graph' ); }
BEGIN { use_ok( 'SVG::TT::Graph::Line' ); }

my @fields = qw(Jan Feb Mar);

my $graph = SVG::TT::Graph::Line->new({
	'fields' => \@fields,
});

is($graph->show_y_labels(),1,'default show_y_lables match');
is($graph->show_y_labels('0'),0,'setting show_y_lables match');
is($graph->show_y_labels(),0,'new show_y_lables match');

eval {
	$graph->silly_method_that_dont_exist();
};
ok($@, 'Got error for method that is not in config');

