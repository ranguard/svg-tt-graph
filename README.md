# NAME

SVG::TT::Graph - Base module for generating SVG graphics

# SYNOPSIS

    package SVG::TT::Graph::GRAPH_TYPE;
    use SVG::TT::Graph;
    use base qw(SVG::TT::Graph);
    our $VERSION = $SVG::TT::Graph::VERSION;
    our $TEMPLATE_FH = \*DATA;

    sub _set_defaults {
      my $self = shift;

      my %default = (
          'keys'  => 'value',
      );
      while( my ($key,$value) = each %default ) {
        $self->{config}->{$key} = $value;
      }
    }


    # optional - called when object is created
    sub _init {
      my $self = shift;
    # any testing you want to do.

    }

    ...

    1;
    __DATA__
    <!-- SVG Template goes here  -->


    In your script:

    use SVG::TT::Graph::GRAPH_TYPE;

    my $width = '500',
    my $heigh = '300',
    my @fields = qw(field_1 field_2 field_3);

    my $graph = SVG::TT::Graph::GRAPH_TYPE->new({
      # Required for some graph types
      'fields'           => \@fields,
      # .. other config options
      'height' => '500',
    });

    my @data = qw(23 56 32);
    $graph->add_data({
      'data' => \@data,
      'title' => 'Sales 2002',
    });

    # find a config options value
    my $config_value = $graph->config_option();
    # set a config option value
    $graph->config_option($config_value);

    # All graphs support SVGZ (compressed SVG) if
    # Compress::Zlib is available. Use either the
    # 'compress' => 1 config option, or:
    $graph->compress(1);

    # All graph SVGs can be tidied if XML::Tidy
    # is installed. Use either the 'tidy' => 1
    # config option, or:
    $graph->tidy(1);

    print "Content-type: image/svg+xml\n\n";
    print $graph->burn();

# DESCRIPTION

This package is a base module for creating graphs in Scalable Vector Format
(SVG). Do not use this module directly. Instead, use one of the following
modules to create the plot of your choice:

- [SVG::TT::Graph::Line](https://metacpan.org/pod/SVG::TT::Graph::Line)
- [SVG::TT::Graph::Bar](https://metacpan.org/pod/SVG::TT::Graph::Bar)
- [SVG::TT::Graph::BarHorizontal](https://metacpan.org/pod/SVG::TT::Graph::BarHorizontal)
- [SVG::TT::Graph::BarLine](https://metacpan.org/pod/SVG::TT::Graph::BarLine)
- [SVG::TT::Graph::Pie](https://metacpan.org/pod/SVG::TT::Graph::Pie)
- [SVG::TT::Graph::TimeSeries](https://metacpan.org/pod/SVG::TT::Graph::TimeSeries)
- [SVG::TT::Graph::XY](https://metacpan.org/pod/SVG::TT::Graph::XY)

If XML::Tidy is installed, the SVG files generated can be tidied. If
Compress::Zlib is available, the SVG files can also be compressed to SVGZ.

# METHODS

## add\_data()

    my @data_sales_02 = qw(12 45 21);

    $graph->add_data({
      'data' => \@data_sales_02,
      'title' => 'Sales 2002',
    });

This method allows you do add data to the graph object.
It can be called several times to add more data sets in.

## clear\_data()

    my $graph->clear_data();

This method removes all data from the object so that you can
reuse it to create a new graph but with the same config options.

## get\_template()

    print $graph->get_template();

This method returns the TT template used for making the graph.

## burn()

    print $graph->burn();

This method processes the template with the data and
config which has been set and returns the resulting SVG.

This method will croak unless at least one data set has
been added to the graph object.

## compress()

    $graph->compress(1);

If Compress::Zlib is installed, the content of the SVG file can be compressed.
This get/set method controls whether or not to compress. The default is 0 (off).

## tidy()

    $graph->tidy(1);

If XML::Tidy is installed, the content of the SVG file can be formatted in a
prettier way. This get/set method controls whether or not to tidy. The default
is 0 (off). The limitations of tidy are described at this URL:
[http://search.cpan.org/~pip/XML-Tidy-1.12.B55J2qn/Tidy.pm#tidy%28%29](http://search.cpan.org/~pip/XML-Tidy-1.12.B55J2qn/Tidy.pm#tidy%28%29)

## config methods

    my $value = $graph->method();
    $graph->method($value);

This object provides autoload methods for all config
options defined in the \_set\_default method within the
inheriting object.

See the SVG::TT::Graph::GRAPH\_TYPE documentation for a list.

# EXAMPLES

For examples look at the project home page http://leo.cuckoo.org/projects/SVG-TT-Graph/

# EXPORT

None by default.

# ACKNOWLEDGEMENTS

Thanks to Foxtons for letting us put this on CPAN, Todd Caine for heads up on
reparsing the template (but not using atm), David Meibusch for TimeSeries and a
load of other ideas, Stephen Morgan for creating the TT template and SVG, and
thanks for all the patches by Andrew Ruthven and others.

# AUTHOR

Leo Lapworth <LLAP@cuckoo.org>

# MAINTAINER

Florent Angly <florent.angly@gmail.com>

# COPYRIGHT AND LICENSE

Copyright (C) 2003, Leo Lapworth

This module is free software; you can redistribute it or
modify it under the same terms as Perl itself.

# SEE ALSO

[SVG::TT::Graph::Line](https://metacpan.org/pod/SVG::TT::Graph::Line),
[SVG::TT::Graph::Bar](https://metacpan.org/pod/SVG::TT::Graph::Bar),
[SVG::TT::Graph::BarHorizontal](https://metacpan.org/pod/SVG::TT::Graph::BarHorizontal),
[SVG::TT::Graph::BarLine](https://metacpan.org/pod/SVG::TT::Graph::BarLine),
[SVG::TT::Graph::Pie](https://metacpan.org/pod/SVG::TT::Graph::Pie),
[SVG::TT::Graph::TimeSeries](https://metacpan.org/pod/SVG::TT::Graph::TimeSeries),
[SVG::TT::Graph::XY](https://metacpan.org/pod/SVG::TT::Graph::XY),
[Compress::Zlib](https://metacpan.org/pod/Compress::Zlib),
[XML::Tidy](https://metacpan.org/pod/XML::Tidy)
