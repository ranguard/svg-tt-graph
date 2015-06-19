use lib qw(../lib);
use SVG::TT::Graph::HeatMap;
use Data::Dumper;

my @data_cpu1;
my $x_size = 10;


for ( 1 .. 20 )
{
    push @data,
      { x   => "ABC$_",
        c   => $_ * 3,
        b   => $_ * 2,
        d   => int( rand(10) ),
        abc => $_,
        f   => int( rand(10) ),
        e   => int( rand(10) ),
      };
}




my %ylabs = %{ $data[0] };
delete $ylabs{ x };


my $graph = SVG::TT::Graph::HeatMap->new(
                                  { block_height => 24,
                                    block_width  => 24,
                                    gutter_width => 1,
                                    y_axis_order => [reverse sort keys %ylabs],
                                    rotate_x_labels => 0,
                                    debug           => 0,
                                  } );

$graph->add_data(
                  { 'data'  => \@data,
                    'title' => 'CPU',
                  } );

$graph->tidy(1);

print $graph->burn();


1;



