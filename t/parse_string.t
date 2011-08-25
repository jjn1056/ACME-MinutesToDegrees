use Test::Most;
use ACME::MinutesToDegrees;

ok my $mtd = ACME::MinutesToDegrees->new,
  'created object';

is $mtd->from_time_string("12:00"), 0,
  '12:00 is 0 degrees';

is $mtd->from_time_string("12:15"), 90,
  '12:15 is 90 degrees';

is $mtd->from_time_string("12:30"), 180,
  '12:30 is 180 degrees';

is $mtd->from_time_string("12:45"), 90,
  '12:45 is 90 degrees';


is $mtd->from_time_string("3:00"), 90,
  '3:00 is 90 degrees';

is $mtd->from_time_string("3:15"), 0,
  '3:15 is 0 degrees';

is $mtd->from_time_string("3:30"), 90,
  '3:30 is 90 degrees';

is $mtd->from_time_string("3:45"), 180,
  '3:45 is 180 degrees';


is $mtd->from_time_string("6:00"), 180,
  '6:00 is 180 degrees';

is $mtd->from_time_string("6:15"), 90,
  '6:15 is 90 degrees';

is $mtd->from_time_string("6:30"), 0,
  '6:30 is 0 degrees';

is $mtd->from_time_string("6:45"), 90,
  '6:45 is 90 degrees';


is $mtd->from_time_string("9:00"), 90,
  '9:00 is 90 degrees';

is $mtd->from_time_string("9:15"), 180,
  '9:15 is 180 degrees';

is $mtd->from_time_string("9:30"), 90,
  '9:30 is 90 degrees';

is $mtd->from_time_string("9:45"), 0,
  '9:45 is 0 degrees';

done_testing;
