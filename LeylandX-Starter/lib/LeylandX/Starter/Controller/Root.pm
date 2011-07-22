package LeylandX::Starter::Controller::Root;
# ******************************************
our $VERSION = '0.02';
# ********************
use Moose;
use Leyland::Parser;
use namespace::autoclean;

with 'Leyland::Controller';

use Try::Tiny;
use Data::Dumper;
use LeylandX::Starter::Build;

prefix { '' }

get '^/$' {
    $c->template('index.html');
};

post '^/(save|start)$' accepts 'application/json' returns 'application/json' {
    my $start = shift eq 'start';

    my (%errormessages,%sendback);
    my $parameter = {};
   
    try {
        $parameter = $c->json->from_json($c->content);
        unless(ref($parameter) eq 'HASH') {
	    die 'Invalid data format.';
        }
    }
    catch {
        $errormessages{'_fatal'} = $_;
    };
    unless(%errormessages) {
    
        while(my ($key,$val) = each(%$parameter)) {
            next unless my $form = $c->form($key);
            $form->process(params => $val);
            if( $form->validated ) {
                 $c->freeze($key,$form->values);
            }
            else {
                foreach my $fld ($form->error_fields) {
                    $errormessages{$key}{$fld->name} = $fld->errors;
                }
            }
        }
    }
    unless(%errormessages) {
        if($start) {
            $self->start_project($c);
        }
    }
    $c->res->content_type('application/json');
    return $c->json->to_json( [\%sendback,\%errormessages] );
};

get '^/(\w+)$' { $c->forward('GET:/') };

post '^/form/(\w+)$' accepts 'multipart-formdata' {
    my ($formname) = @_;
    my $form = $c->form($formname);
    if( $form ) {
        $form->process(params => $c->body_parameters->as_hashref);
        if( $form->validated ) {
            $c->freeze($formname,$form->values);
        }
    }

    return $c->forward('GET:/');
};

sub auto {
    my ($self, $c) = @_;
    $c->set_lang('de');
    # this method is automatically called before the actual route method
    # is performed. every auto() method starting from the Root controller
    # and up to the matched route's controller are invoked in order,
    # so this auto() method (in the Root controller) will run for
    # every request, no matter what the request is for, so you can use
    # it to perform some necessary per-request operations like perhaps
    # validating a user's authorization to perform an operation
}

=head2 pre_route( $c )

=cut

sub pre_route {
    my ($self, $c) = @_;

    foreach my $formname (qw/author project/) {
        unless( %{$c->form($formname)->values} ) {
            if( my $freezed = $c->thaw($formname) ){
	        try {
                    # if an field has the same name as the form
                    # not using this form results in an error
                    $c->form($formname)->process(params => $freezed);
                }
                catch {
                    $c->log->error("invalid freezed data for form $formname: $_");
		    $c->log->debug(Data::Dumper::Dumper($freezed));
                }
            }
        }
    }
    # this method is automatically called before the actual route method
    # is performed, but only for route methods in this controller, as
    # opposed to the auto() method. the pre_route() method of a controller,
    # if exists, will always be performed after all auto() methods
    # have been invoked
}

=head2 pre_template( $c, $tmpl, [ \%context, $use_layout ] )

=cut

sub pre_template {
    my ($self, $c, $tmpl, $context, $use_layout) = @_;

    # this method is automatically called before a view/template is
    # rendered by routes in this controller. It receives all the
    # the Leyland context object ($c), the name of the view/template
    # to be rendered ($tmpl), and possibly the context hash-ref and
    # the use_layout boolean.
}

=head2 post_route( $c, $ret )

=cut

sub post_route {
    my ($self, $c, $ret) = @_;

    # this method is automatically called after the actual route method
    # is performed, but only for route methods in this controller.
    # it also receives a reference to the result returned by the route
    # method after serialization (even if it's a scalar, in which case $ret will be a reference
    # to a scalar).
}

sub start_project {
    my ($self,$c) = @_;
    my $args = {};

    $args->{package_name} = $c->form('project')->field('module')->value;
    $args->{root_dir} = $c->form('project')->field('directory')->value;
    $args->{abstract} = $c->form('project')->field('abstract')->value;

    $args->{author} = $c->form('author')->field('author')->value;
    $args->{email} = $c->form('author')->field('email')->value;

    my $project = LeylandX::Starter::Project->new($args);
    my $builder = LeylandX::Starter::Build->new(project => $project);

    $builder->build();
}


=head1 NAME

LeylandX::Starter::Controller::Root - Top level controller of LeylandX-Starter

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 PREFIX

I<none, this is the root controller>

=head1 ROUTES

=head2 GET /

Returns text/html

=head1 METHODS

=head2 auto( $c )



=head1 AUTHOR

Some Guy, C<< <some_guy@email.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-LeylandX-Starter at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=LeylandX-Starter>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc LeylandX::Starter::Controller::Root

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=LeylandX-Starter>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/LeylandX-Starter>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/LeylandX-Starter>

=item * Search CPAN

L<http://search.cpan.org/dist/LeylandX-Starter/>

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2011 Some Guy.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

__PACKAGE__->meta->make_immutable;
