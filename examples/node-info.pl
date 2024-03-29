#!/usr/bin/perl

use strict;
use warnings;

use Sys::Virt;

my $addr = @ARGV ? shift @ARGV : "";

my $hv = Sys::Virt->new(address => $addr, readonly => 1);

my $info = $hv->get_node_info();

my @models = $hv->get_cpu_model_names($info->{model});

print join ("\n", sort{ lc $a cmp lc $b } @models), "\n";
