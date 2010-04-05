use lib qw( ./blib/lib ../blib/lib );

# Test using the methods to set the config

use Test::More tests => 12;

BEGIN { use_ok( 'SVG::TT::Graph' ); }
BEGIN { use_ok( 'SVG::TT::Graph::Line' ); }

my @fields = qw(Jan Feb Mar);

my $graph = SVG::TT::Graph::Line->new({
  'fields' => \@fields,
});

is($graph->show_y_labels(),1,'default show_y_labels match');
is($graph->show_y_labels('0'),0,'setting show_y_labels match');
is($graph->show_y_labels(),0,'new show_y_labels match');

eval {
  $graph->silly_method_that_dont_exist();
};
ok($@, 'Got error for method that is not in config');

ok(defined $graph->compress(),'default compress');
is($graph->compress(0),0,'setting compress');
is($graph->compress(1),1);

ok(defined $graph->tidy(),'default tidy');
is($graph->tidy(0),0,'setting tidy');
is($graph->tidy(1),1);
