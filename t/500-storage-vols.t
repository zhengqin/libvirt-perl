# -*- perl -*-

use strict;
use warnings;

use Test::More tests => 8;

BEGIN {
        use_ok('Sys::Virt');
}


my $conn = Sys::Virt->new(uri => "test:///default");
isa_ok($conn, "Sys::Virt");

my $pool = $conn->get_storage_pool_by_name("default-pool");
isa_ok($pool, "Sys::Virt::StoragePool");


my $volxml = <<EOF;
<volume>
  <name>demo-vol</name>
  <capacity unit="G">5</capacity>
</volume>
EOF

my $newvol = $pool->create_volume($volxml);
isa_ok($newvol, "Sys::Virt::StorageVol");


my $key = $newvol->get_key();


my $vol1 = $conn->get_storage_volume_by_path("/default-pool/demo-vol");
isa_ok($vol1, "Sys::Virt::StorageVol");
is($vol1->get_key(), $newvol->get_key(), "key matches");


my $vol2 = $conn->get_storage_volume_by_key($key);
isa_ok($vol2, "Sys::Virt::StorageVol");

is($vol2->get_path(), $newvol->get_path(), "path matches");