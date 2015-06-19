package SVG::TT::Graph::HeatMap;

use Modern::Perl;
use Carp;
use Data::Dumper;
use SVG::TT::Graph;
use base qw(SVG::TT::Graph);
use vars qw($VERSION $TEMPLATE_FH);
$VERSION     = $SVG::TT::Graph::VERSION;
$TEMPLATE_FH = \*DATA;


=head1 NAME

SVG::TT::Graph::XY - Create presentation quality SVG line graphs of XY data points easily

=head1 SYNOPSIS

  use SVG::TT::Graph::XY;

  my @data_cpu  = (0.3, 23, 0.5, 54, 1.0, 67, 1.8, 12);
  my @data_disk = (0.45, 12, 0.51, 26, 0.53, 23);

  my $graph = SVG::TT::Graph::XY->new({
    'height' => '500',
    'width'  => '300',
  });

  $graph->add_data({
    'data'  => \@data_cpu,
    'title' => 'CPU',
  });

  $graph->add_data({
    'data'  => \@data_disk,
    'title' => 'Disk',
  });

  print "Content-type: image/svg+xml\n\n";
  print $graph->burn();

=head1 DESCRIPTION

This object aims to allow you to easily create high quality
SVG line graphs of XY data. You can either use the default style sheet
or supply your own. Either way there are many options which can
be configured to give you control over how the graph is
generated - with or without a key, data elements at each point,
title, subtitle etc.

=head1 METHODS

=head2 new()

  use SVG::TT::Graph::XY;

  my $graph = SVG::TT::Graph::XY->new({

    # Optional - defaults shown
    'height'              => 500,
    'width'               => 300,

    'show_y_labels'       => 1,
    'yscale_divisions'    => '',
    'min_yscale_value'    => 0,
    'max_yscale_value'    => '',

    'show_x_labels'       => 1,
    'xscale_divisions'    => '',
    'min_xscale_value'    => '',
    'max_xscale_value'    => '',
    'stagger_x_labels'    => 0,
    'rotate_x_labels'     => 0,
    'y_label_formatter'   => sub { return @_ },
    'x_label_formatter'   => sub { return @_ },

    'show_data_points'    => 1,
    'show_data_values'    => 1,
    'rollover_values'     => 0,

    'area_fill'           => 0,

    'show_x_title'        => 0,
    'x_title'             => 'X Field names',

    'show_y_title'        => 0,
    'y_title'             => 'Y Scale',

    'show_graph_title'    => 0,
    'graph_title'         => 'Graph Title',
    'show_graph_subtitle' => 0,
    'graph_subtitle'      => 'Graph Sub Title',
    'key'                 => 0,
    'key_position'        => 'right',

    # Stylesheet defaults
    'style_sheet'         => '/includes/graph.css', # internal stylesheet
    'random_colors'       => 0,
  });

The constructor takes a hash reference with values defaulted to those
shown above - with the exception of style_sheet which defaults
to using the internal style sheet.

=head2 add_data()

  my @data_cpu  = (0.3, 23, 0.5, 54, 1.0, 67, 1.8, 12);
  or
  my @data_cpu = ([0.3,23], [0.5,54], [1.0,67], [1.8,12]);
  or
  my @data_cpu = ([0.3,23,'23%'], [0.5,54,'54%'], [1.0,67,'67%'], [1.8,12,'12%']);

  $graph->add_data({
    'data' => \@data_cpu,
    'title' => 'CPU',
  });

This method allows you to add data to the graph object.  The
data are expected to be either a list of scalars (in which
case pairs of elements are taken to be X,Y pairs) or a list
of array references.  In the latter case, the first two
elements in each referenced array are taken to be X and Y,
and the optional third element (if present) is used as the
text to display for that point for show_data_values and
rollover_values; otherwise the Y value itself is displayed.
It can be called several times to add more data sets in.

=head2 clear_data()

  my $graph->clear_data();

This method removes all data from the object so that you can
reuse it to create a new graph but with the same config options.

=head2 burn()

  print $graph->burn();

This method processes the template with the data and
config which has been set and returns the resulting SVG.

This method will croak unless at least one data set has
been added to the graph object.

=head2 config methods

  my $value = $graph->method();
  my $confirmed_new_value = $graph->method($value);

The following is a list of the methods which are available
to change the config of the graph object after it has been
created.

=over 4

=item height()

Set the height of the graph box, this is the total height
of the SVG box created - not the graph it self which auto
scales to fix the space.

=item width()

Set the width of the graph box, this is the total width
of the SVG box created - not the graph it self which auto
scales to fix the space.

=item compress()

Whether or not to compress the content of the SVG file (Compress::Zlib required).

=item tidy()

Whether or not to tidy the content of the SVG file (XML::Tidy required).

=item style_sheet()

Set the path to an external stylesheet, set to '' if
you want to revert back to using the default internal version.

The default stylesheet handles up to 12 data sets. All data series over
the 12th will have no style and be in black. If you have over 12 data
sets you can assign them all random colors (see the random_color()
method) or create your own stylesheet and add the additional settings
for the extra data sets.

To create an external stylesheet create a graph using the
default internal version and copy the stylesheet section to
an external file and edit from there.

=item random_colors()

Use random colors in the internal stylesheet.

=item show_data_values()

Show the value of each element of data on the graph (or
optionally a user-defined label; see add_data).

=item show_data_points()

Show a small circle on the graph where the line
goes from one point to the next.

=item rollover_values()

Shows data values and data points when the mouse is over the point.
Used in combination with show_data_values and/or show_data_points.

=item data_value_format()

Format specifier to for data values (as per printf).

=item max_x_span()

Maximum span for a line between data points on the X-axis. If this span is
exceeded, the points are not connected. This is useful for skipping missing data
sections. If you set this value to something smaller than 0 (e.g. -1), you will
get an XY scatter plot with no line joining the data points.

=item stacked()

Accumulates each data set. (i.e. Each point increased by
sum of all previous series at same point). Default is 0,
set to '1' to show.

=item min_yscale_value()

The point at which the Y axis starts, defaults to '0',
if set to '' it will default to the minimum data value.

=item max_yscale_value()

The point at which the Y axis ends,
if set to '' it will default to the maximum data value.

=item yscale_divisions()

This defines the gap between markers on the Y axis,
default is a 10th of the range, e.g. you will have
10 markers on the Y axis. NOTE: do not set this too
low - you are limited to 999 markers, after that the
graph won't generate.

=item show_x_labels()

Whether to show labels on the X axis or not, defaults
to 1, set to '0' if you want to turn them off.

=item show_y_labels()

Whether to show labels on the Y axis or not, defaults
to 1, set to '0' if you want to turn them off.

=item y_label_format()

Format string for presenting the Y axis labels (as per printf).

=item xscale_divisions()

This defines the gap between markers on the X axis.
Default is the entire range (only start and end axis
labels).

=item stagger_x_labels()

This puts the labels at alternative levels so if they
are long field names they will not overlap so easily.
Default it '0', to turn on set to '1'.

=item rotate_x_labels()

This turns the X axis labels by 90 degrees.
Default it '0', to turn on set to '1'.

=item min_xscale_value()

This sets the minimum X value. Any data points before this value will not be
shown.

=item max_xscale_value()

This sets the maximum X value. Any data points after this value will not be
shown.

=item show_x_title()

Whether to show the title under the X axis labels,
default is 0, set to '1' to show.

=item x_title()

What the title under X axis should be, e.g. 'Parameter X'.

=item show_y_title()

Whether to show the title under the Y axis labels,
default is 0, set to '1' to show.

=item y_title()

What the title under Y axis should be, e.g. 'Sales in thousands'.

=item show_graph_title()

Whether to show a title on the graph,
default is 0, set to '1' to show.

=item graph_title()

What the title on the graph should be.

=item show_graph_subtitle()

Whether to show a subtitle on the graph,
default is 0, set to '1' to show.

=item graph_subtitle()

What the subtitle on the graph should be.

=item key()

Whether to show a key, defaults to 0, set to
'1' if you want to show it.

=item key_position()

Where the key should be positioned, defaults to
'right', set to 'bottom' if you want to move it.

=item x_label_formatter ()

A callback subroutine which will format a label on the x axis.  For example:

    $graph->x_label_formatter( sub { return '$' . $_[0] } );

=item y_label_formatter()

A callback subroutine which will format a label on the y axis.  For example:

    $graph->y_label_formatter( sub { return '$' . $_[0] } );

=back

=head1 EXAMPLES

For examples look at the project home page
http://leo.cuckoo.org/projects/SVG-TT-Graph/

=head1 EXPORT

None by default.

=head1 SEE ALSO

L<SVG::TT::Graph>,
L<SVG::TT::Graph::Line>,
L<SVG::TT::Graph::Bar>,
L<SVG::TT::Graph::BarHorizontal>,
L<SVG::TT::Graph::BarLine>,
L<SVG::TT::Graph::Pie>,
L<Compress::Zlib>,
L<XML::Tidy>

=cut

sub _init
{
    my $self = shift;
}

sub _set_defaults
{
    my $self = shift;

    my @fields = ();

    my %default = (
        'fields' => \@fields,

        'width'  => '500',
        'height' => '300',

        'style_sheet'   => '',
        'random_colors' => 0,

        'show_data_points' => 1,
        'show_data_values' => 1,
        'rollover_values'  => 0,

        'max_x_span' => '',

        'area_fill' => 0,

        'show_y_labels'    => 1,
        'yscale_divisions' => '',
        'min_yscale_value' => '0',

        'stacked' => 0,

        'show_x_labels'     => 1,
        'stagger_x_labels'  => 0,
        'rotate_x_labels'   => 0,
        'xscale_divisions'  => '',
        'x_label_formatter' => sub {return @_},
        'y_label_formatter' => sub {return @_},

        'show_x_title' => 0,
        'x_title'      => 'X Field names',

        'show_y_title' => 0,
        'y_title'      => 'Y Scale',

        'show_graph_title'    => 0,
        'graph_title'         => 'Graph Title',
        'show_graph_subtitle' => 0,
        'graph_subtitle'      => 'Graph Sub Title',

        'key'          => 0,
        'key_position' => 'right',    # bottom or right
        y_axis_order   => [] );

    while ( my ( $key, $value ) = each %default )
    {
        $self->{ config }->{ $key } = $value;
    }
}

# override this so we can pre-manipulate the data
sub add_data
{
    my ( $self, $conf ) = @_;

    croak 'no data provided'
      unless ( defined $conf->{ 'data' } &&
               ref( $conf->{ 'data' } ) eq 'ARRAY' );

    # create an array
    unless ( defined $self->{ 'data' } )
    {
        my @data;
        $self->{ 'data' } = \@data;
    }
    else
    {
        croak 'There can only be a single piece of data';
    }

    # If there is an order this takes presidence and all data points should have this
    # however if there are

    my %check;
    if ( 0 == scalar @{ $self->{ config }->{ y_axis_order } } )
    {
        if ( ref( $conf->{ 'data' }->[0] ) eq 'ARRAY' )
        {
            my @header = @{ $conf->{ 'data' }->[0] };
            $self->{ config }->{ y_axis_order } = \@header[1 .. $#header];
        }
    }
    %check = map {$_, 1} @{ $self->{ config }->{ y_axis_order } };
    croak
      'The Data needs to have either a y_axis_order or a header array in the data'
      if 0 == scalar keys %check;

    # convert to sorted (by ascending numeric value) array of [ x, y ]
    my @new_data = ();
    my ( $i, $x );

    $i = ref( $conf->{ 'data' }->[0] ) eq 'ARRAY' ? 1 : 0;
    my $max = scalar @{ $conf->{ 'data' } };
    while ( $i < $max )
    {
        my %row ;
        if ( ref( $conf->{ 'data' }->[$i] ) eq 'ARRAY' )
        {
            $row{ x } = $conf->{ 'data' }->[$i]->[0];
            for my $col ( 1 .. $#{ $conf->{ 'data' }->[$i] } )
            {
                $row{ $conf->{ 'data' }->[0]->[$col] } =
                  colourDecide( $conf->{ 'data' }->[$i]->[$col] )
                  #$conf->{ 'data' }->[$i]->[$col];
            }
        }
        elsif ( ref( $conf->{ 'data' }->[$i] ) eq 'HASH' )
        {
            # check the hash to make sure make sure the data is in it
            croak "row '$i' has no x value"
              unless defined $conf->{ 'data' }->[$i]->{ x };
            $row{ x } = $conf->{ 'data' }->[$i]->{ x };
            while ( my ( $k, $v ) = each %check )
            {
                croak "'$row{ x }' does not have a '$k' vaule"
                  unless defined $conf->{ 'data' }->[$i]->{ $k };
                $row{ $k } = colourDecide();
            }
        }
        else
        {
            croak
              'Data needs to be in an Array of Arrays or an Array of Hashes ';
        }
        push @new_data, \%row;
        $i++;
    }

    my %store = ( 'pairs' => \@new_data, );

    $store{ 'title' } = $conf->{ 'title' } if defined $conf->{ 'title' };
    push( @{ $self->{ 'data' } }, \%store );

    return 1;
}

# override calculations to set a few calculated values, mainly for scaling
sub calculations
{
    my $self = shift;

    # run through the data and calculate maximum and minimum values
    my ( $max_key_size, $max_x, $min_x, $max_y, $min_y, $max_x_label_length,
         $x_label, $max_y_label_length );

    my @y_axis_order = @{ $self->{ config }->{ y_axis_order } };
    for my $y_axis_label (@y_axis_order)
    {
        $max_y_label_length = length $y_axis_label
          if ( ( !defined $max_y_label_length ) ||
               ( $max_y_label_length < length $y_axis_label ) );
    }
    foreach my $dataset ( @{ $self->{ data } } )
    {
        $max_key_size = length( $dataset->{ title } )
          if ( ( !defined $max_key_size ) ||
               ( $max_key_size < length( $dataset->{ title } ) ) );
        $max_x = scalar @{ $dataset->{ pairs } }
          if ( ( !defined $max_x ) ||
               ( $max_x < scalar @{ $dataset->{ pairs } } ) );
        foreach my $pair ( @{ $dataset->{ pairs } } )
        {
            $min_x = 0;

            $max_y = scalar @y_axis_order;

            for my $y_vaules (@y_axis_order)
            {
                $min_y = 0;
            }
            $x_label            = $pair->{ x };
            $max_x_label_length = length($x_label)
              if ( ( !defined $max_x_label_length ) ||
                   ( $max_x_label_length < length($x_label) ) );
        }
    }
    
    $self->{ calc }->{ max_key_size }       = $max_key_size;
    $self->{ calc }->{ max_x }              = $max_x;
    $self->{ calc }->{ min_x }              = $min_x;
    $self->{ calc }->{ max_y }              = $max_y;
    $self->{ calc }->{ min_y }              = $min_y;
    $self->{ calc }->{ max_x_label_length } = $max_x_label_length;
    $self->{ calc }->{ max_y_label_length } = $max_y_label_length;
    $self->{ config }->{ width } =
      ( 10 * 2 ) + ( $max_y_label_length * 8 ) + 1 + (
                                       $max_x * (
                                           $self->{ config }->{ block_width } +
                                             $self->{ config }->{ gutter_width }
                                       ) );
    $self->{ config }->{ height } =
      ( 10 * 2 ) + ( $max_x_label_length * 8 ) + 1 + (
                                       $max_y * (
                                           $self->{ config }->{ block_width } +
                                             $self->{ config }->{ gutter_width }
                                       ) );

}

sub colourDecide
{
    my $r = int( rand(255) );
    my $g = int( rand(255) );
    my $b = int( rand(255) );
    return "rgb($r,$g,$b)";
}

1;
__DATA__
<?xml version="1.0"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN"
  "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">

[% stylesheet = 'included' %]

[% IF config.style_sheet && config.style_sheet != '' %]
  <?xml-stylesheet href="[% config.style_sheet %]" type="text/css"?>
[% ELSE %]
  [% stylesheet = 'excluded' %]
[% END %]

<svg width="[% config.width %]" height="[% config.height %]" viewBox="0 0 [% config.width %] [% config.height %]" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">

<!-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\  -->
<!-- Created with SVG::TT::Graph   -->
<!-- Dave Meibusch                 -->
<!-- ////////////////////////////  -->

[% IF stylesheet == 'excluded' %]
[%# include default stylesheet if none specified %]
<defs>
<style type="text/css">
<![CDATA[
/* Copy from here for external style sheet */
.svgBackground{
  fill:#f0f0f0;
}
.graphBackground{
  fill:#fafafa;
}

/* graphs titles */
.mainTitle{
  text-anchor: middle;
  fill: #000000;
  font-size: 14px;
  font-family: "Arial", sans-serif;
  font-weight: normal;
}
.subTitle{
  text-anchor: middle;
  fill: #999999;
  font-size: 12px;
  font-family: "Arial", sans-serif;
  font-weight: normal;
}

.axis{
  stroke: #000000;
  stroke-width: 1px;
}

.guideLines{
  stroke: #666666;
  stroke-width: 1px;
  stroke-dasharray: 5 5;
}

.xAxisLabels{
  text-anchor: middle;
  fill: #000000;
  font-size: 12px;
  font-family: "Arial", sans-serif;
  font-weight: normal;
}

.yAxisLabels{
  text-anchor: end;
  fill: #000000;
  font-size: 12px;
  font-family: "Lucida Console", Monaco, monospace;
  font-weight: normal;
}

.xAxisTitle{
  text-anchor: middle;
  fill: #ff0000;
  font-size: 14px;
  font-family: "Lucida Console", Monaco, monospace;
  font-weight: normal;
}

.yAxisTitle{
  fill: #ff0000;
  text-anchor: middle;
  font-size: 14px;
  font-family: "Arial", sans-serif;
  font-weight: normal;
}

.dataPointLabel{
  fill: #000000;
  text-anchor:middle;
  font-size: 10px;
  font-family: "Arial", sans-serif;
  font-weight: normal;
}
.staggerGuideLine{
  fill: none;
  stroke: #000000;
  stroke-width: 0.5px;
}

[% FOREACH dataset = data %]
  [% color = '' %]
  [% IF config.random_colors %]
    [% color = random_color() %]
  [% ELSE %]
    [% color = predefined_color(loop.count) %]
  [% END %]

  .fill[% loop.count %]{
    fill: [% color %];
    fill-opacity: 0.2;
    stroke: none;
  }

  .line[% loop.count %]{
    fill: none;
    stroke: [% color %];
    stroke-width: 1px;
  }

  .key[% loop.count %],.fill[% loop.count %]{
    fill: [% color %];
    stroke: none;
    stroke-width: 1px;
  }

  [% LAST IF (config.random_colors == 0 && loop.count == 12) %]
[% END %]

.keyText{
  fill: #000000;
  text-anchor:start;
  font-size: 10px;
  font-family: "Arial", sans-serif;
  font-weight: normal;
}
/* End copy for external style sheet */
]]>
</style>
</defs>
[% END %]

[% IF config.key %]
  <!-- Script to toggle paths when their key is clicked on -->
  <script language="JavaScript"><![CDATA[
  function togglePath( series ) {
    var path    = document.getElementById('groupDataSeries' + series);
    var points  = document.getElementById('groupDataLabels' + series);
    var current = path.getAttribute('opacity');
    if ( path.getAttribute('opacity') == 0 ) {
      path.setAttribute('opacity',1);
      points.setAttribute('opacity',1);
    } else {
      path.setAttribute('opacity',0);
      points.setAttribute('opacity',0);
    }
  }
  ]]></script>
[% END %]

<!-- svg bg -->
<rect x="0" y="0" width="[% config.width %]" height="[% config.height %]" class="svgBackground"/>

<!-- ///////////////// CALCULATE GRAPH AREA AND BOUNDARIES //////////////// -->
[%# get dimensions of actual graph area (NOT SVG area) %]
[% w = config.width %]
[% h = config.height %]

[%# set start/default coords of graph %]
[% x = 0 %]
[% y = 0 %]

[% char_width = 8 %]
[% half_char_height = 2.5 %]

<!-- min_y [% calc.min_y %] max_y [% calc.max_y %] min_x [% calc.min_x %] max_x [% calc.max_x %] -->

[%# reduce height and width of graph area for padding %]
[% h = h - 20 %]
[% w = w - 20 %]
[% x = x + 10 %]
[% y = y + 10 %]

[% max_x_label_char =  calc.max_x_label_length * char_width  %]
[% max_y_label_char =  calc.max_y_label_length * char_width  %]

[% w = w - max_y_label_char %]
[% x = x + max_y_label_char %]

[% h = h - max_x_label_char %]
[%# y = y + max_x_label_char %]
<!-- max_x_label_char [% calc.max_x_label_length %] max_y_label_char  [% calc.max_y_label_length %] -->



<!-- //////////////////////////////  BUILD GRAPH AREA ////////////////////////////// -->
[%# graph bg and clipping regions for lines/fill and clip extended to included data labels %]
<rect x="[% x %]" y="[% y %]" width="[% w %]" height="[% h %]" class="graphBackground"/>

[% base_line = h + y %]

<!-- axis -->
<path d="M[% x %] [% y %] v[% h %]" class="axis" id="xAxis"/>
<path d="M[% x %] [% base_line %] h[% w %]" class="axis" id="yAxis"/>

<!-- x axis labels -->

[%# TODO  %]

<!-- y axis labels -->


[%# TODO  %]


<g id="groupData" class="data">
[% FOREACH dataset = data.reverse %]
  <g id="groupDataSeries[% line %]" class="dataSeries[% line %]" clip-path="url(#clipGraphArea)">
    [% xx = 0 %]
    [% yy = 0 %]
    [% FOREACH y_data = config.y_axis_order %]
    <text
    x="[% x - (max_y_label_char / 2)    %]"
    y="[% (base_line - 1 ) - (yy * (config.block_height + config.gutter_width)) - config.block_height / 3     %]"
    class="yAxisLabels">[% y_data %]</text>      
        [% yy = yy + 1 %]
    [% END %]
    [% FOREACH pair = dataset.pairs %]
    [% yy = 0 %]
    [% block_start_x = x + 1 + (xx * (config.block_width + config.gutter_width))  %]
        [% IF config.debug %]
        <circle
        cx="[% block_start_x + (config.block_width / 2 )   %]"
        cy="[% (base_line + 5)   %]"
        r="2" fill="red" />
        [% END %]
        [% textx =  block_start_x   %]
        [% texty =  (base_line + 1)     %]
        <text
        x="[% textx   %]"
        y="[% texty   %]"
        transform="rotate(90 [% textx %],[% texty  %]) translate([% (pair.x.length + 1) * 4    %], [% (config.block_height - config.gutter_width) / -3  %])"
        class="xAxisLabels">[% pair.x %]</text>
        
        [% FOREACH y_data = config.y_axis_order %]
        
        <rect
        x="[% block_start_x   %]"
        y="[% (base_line - 1 - config.block_height) - (yy * (config.block_height + config.gutter_width))   %]"
        width="[% config.block_width  %]"
        height="[% config.block_height  %]" style="fill:[% pair.$y_data  %]" />
        <!-- [% y_data %] [% pair.$y_data %] -->
        [% yy = yy + 1 %]
        [% END %]
    [% xx = xx + 1 %]
    [% END %]
  [% END %]
  </g>
</g>

[% IF config.debug %]
<circle cx="[% x %]" cy="[% base_line %]" r="1" stroke="black" stroke-width="1" fill="red" />
[% END %]



</svg>
