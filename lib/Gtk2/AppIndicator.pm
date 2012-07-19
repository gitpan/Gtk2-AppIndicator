package Gtk2::AppIndicator;

use 5.006;
use strict;
use warnings;
use Carp;
use Gtk2;

require Exporter;
use AutoLoader;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Gtk2::OSXApplication ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
);

our $VERSION = '0.09';

#sub AUTOLOAD {
    # This AUTOLOAD is used to 'autoload' constants from the constant()
    # XS function.

#    my $constname;
#    our $AUTOLOAD;
#    ($constname = $AUTOLOAD) =~ s/.*:://;
#    croak "&Gtk2::AppIndicator::constant not defined" if $constname eq 'constant';
#    my ($error, $val) = constant($constname);
#    if ($error) { croak $error; }
#    {
#	no strict 'refs';
	# Fixed between 5.005_53 and 5.005_61
#XXX	if ($] >= 5.00561) {
#XXX	    *$AUTOLOAD = sub () { $val };
#XXX	}
#XXX	else {
#	    *$AUTOLOAD = sub { $val };
#XXX	}
#    }
#    goto &$AUTOLOAD;
#}

require XSLoader;
XSLoader::load('Gtk2::AppIndicator', $VERSION);

# Preloaded methods go here.

# Autoload methods go after =cut, and are processed by the autosplit program.

sub new {
  my $class=shift;
  my $appname=shift or die "Gtk2::AppIndicator->new needs an application name";
  my $iconname=shift or die "Gtk2::AppIndicator->new needs an icon name";
  
  my $obj={};
  bless $obj,$class;
  $obj->{ind}=appindicator_new($appname,$iconname);
  return $obj;
}

sub set_icon_theme_path {
	my $self=shift;
	my $path=shift;
	appindicator_set_icon_theme_path($self->{ind},$path);
}

sub set_icon_name_active {
	my $self=shift;
	my $name=shift;
	my $text=shift;
	if (not(defined($text))) { $text="no text"; }
	appindicator_set_icon_name_active($self->{ind},$name,$text);
}

sub set_icon_name_attention {
	my $self=shift;
	my $name=shift;
	my $text=shift;
	if (not(defined($text))) { $text="no text"; }
	appindicator_set_icon_name_attention($self->{ind},$name,$text);
}

sub set_active {
	my $self=shift;
	appindicator_set_active($self->{ind});
}

sub set_attention {
	my $self=shift;
	appindicator_set_attention($self->{ind});
}


sub set_menu {
	my $self=shift;
	my $menu=shift;
	appindicator_set_menu($self->{ind},$menu);
}


1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Gtk2::AppIndicator - Perl extension for libappindicator

=head1 SYNOPSIS

  $status_icon=Gtk2::AppIndicator->new("CuePlay","cueplay_24");
  $status_icon->set_icon_theme_path("../pixmaps");
  my $menu=Gtk2::Menu->new();
  my $showcp=Gtk2::CheckMenuItem->new_with_mnemonic("_Show CuePlay");
  $showcp->set_active(1);
  $showcp->signal_connect("toggled",sub { hide_show($window,$showcp); });
  my $quit=Gtk2::MenuItem->new_with_mnemonic("_Quit");
  $quit->signal_connect("activate",sub { storesize($window,\%conf);quit($window); });
  
  $menu->append($showcp);
  $menu->append(Gtk2::SeparatorMenuItem->new());
  $menu->append($quit);
  $status_icon->set_menu($menu);
  $menu->show_all();
  $status_icon->set_active();


=head1 DESCRIPTION

This module gives an interface to the new ubuntu Unity libappindicator stuff.

=head1 FUNCTIONS

 $ind=Gtk2::AppIndicator->new($application_name,$active_icon_name)
 
Creates a new application indicator object with given name and icon name for the active icon.

 $ind->set_icon_theme_path($path)
 
Set the icon theme path to 'path'. This is where icons should be found with names like <active_icon_name>.png.

 $ind->set_icon_name_active($name)
 
Sets the icon name for the active icon.

 $ind->set_icon_name_attention($name)
 
Sets the icon name for the attention icon

  $ind->set_active()
  
Makes the application indicator active.

  $ind->set_attention()
  
Makes the application indicator show the attention icon.

  $ind->set_menu($menu)
  
Sets the popup menu for the indicator icon.



=head1 AUTHOR

Hans Oesterholt, E<lt>debian@oesterholt.netE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2012 by Hans Oesterholt

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.12.3 or,
at your option, any later version of Perl 5 you may have available.


=cut
