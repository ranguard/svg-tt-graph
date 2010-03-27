use lib qw( ./blib/lib ../blib/lib );

# Check we can create objects and adding data works
# as well as clearing data.

use Test::More tests => 56;

BEGIN { use_ok( 'SVG::TT::Graph' ); }
BEGIN { use_ok( 'SVG::TT::Graph::Pie' ); }
BEGIN { use_ok( 'SVG::TT::Graph::Line' ); }
BEGIN { use_ok( 'SVG::TT::Graph::Bar' ); }
BEGIN { use_ok( 'SVG::TT::Graph::BarHorizontal' ); }
BEGIN { use_ok( 'SVG::TT::Graph::BarLine' ); }

my @fields = qw(Jan Feb Mar);
my @data_sales_02 = qw(12 45 21);
my @data_sales_03 = qw(24 55 61);

# Might as well test them all, even though they're
# the same under the hood! - just in case
my @types = qw(Line Bar BarHorizontal Pie BarLine);

foreach my $type (@types) {
	my $module = "SVG::TT::Graph::$type";
	eval {
		my $gr = $module->new({
		});
	};
	ok($@,'Croak ok as no fields supplied');

	my $graph = $module->new({
		'fields' => \@fields,
	});


	isa_ok($graph,$module);
	
	# Check we croak if no data
	eval {
		$graph->burn();
	};
	ok($@, 'Burn method croaked as expected - no data has been set');
	
	$graph->add_data({
		'data' => \@data_sales_02,
		'title' => 'Sales 2002',
	});
	
	is(scalar(@{$graph->{data}}),1,'Data set 1 added');
	is($graph->{data}->[0]->{title}, 'Sales 2002','Data set 1 - title set ok');
	is($graph->{data}->[0]->{data}->{Feb}, 45,'Data set 1 - data set ok');
	
	$graph->add_data({
		'data' => \@data_sales_03,
		'title' => 'Sales 2003',
	});
	
	is(scalar(@{$graph->{data}}),2,'Data set 2 added');
	is($graph->{data}->[1]->{title}, 'Sales 2003','Data set 2 - title set ok');
	is($graph->{data}->[1]->{data}->{Mar}, 61,'Data set 2 - data set ok');
	
	$graph->clear_data();
	
	is(scalar(@{$graph->{data}}),0,'Data cleared ok');

}
