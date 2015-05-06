#!/usr/bin/env python

"""
==============================================================================

Simple tool that extracts time/activity info from a jrnl[0] log.

[0]: http://maebert.github.io/jrnl


USAGE

  pip install jrnl
  jrnl "workstart @time"
  jrnl "Spent some time on the foo @time{1h,overhead}"
  jrnl "Spent some time reviewing the bar @time{30m,review}"
  jrnl "workend @time"
  jrnltime.py

This will print a report on how much time has been logged and how your time
is distributed over the "things" (tasks, activities) you've done.

Also the time-in-lieu is printed.

Everything is printed as YAML (to stdout).

==============================================================================

DESCRIPTION

The point of this script is that if you use jrnl already (for dev-diary or other notes)
you might as well also use it for time tracking. This is done by adding the tag "@time"
to log entries.

There are two types of @time entries used for separate things.


The first is for tracking working hours and hours-in-lieu. This is based on adding pairs
of log entries with "workstart" and "workend" somewhere in the log text. Other @time
entries (without workstart/workend) are not used for tracking working hours.

You can "start" a workday by typing this:

  jrnl "workstart @time"

And end it:

  jrnl "workend @time"

You can have any number of workstart/workend pairs in a day (i.e. you can have pauses).
The intended usage is a single pair which spans 8 hours, and more if you work extra in
the evening.

The hours-in-lieu is computed assuming that missing days contribute 0 to the balance.


The other type of @time entry is for tracking an activity. This is useful to see where
your time is being spent. Add an entry like this:

  jrnl "Spent some time on the foo @time{1h,overhead}"

The jrnl entry text is arbitrary, and so is the "category" (which in this case is
"overhead"). The "1h" field means "1 hour". Also accepted is e.g. "30m" for "30 minutes".

The activity entries are summed and the result is a distribution of your time over the
activities present in the jrnl. As mentioned this is completely separate from the tracking
of working days/hours.


All information is printed as YAML. This should make it readable to a human and also easy
to parse from another script (e.g. for plotting).

==============================================================================
"""

import yaml
import subprocess
from collections import defaultdict
import datetime
import re
import argparse

class JrnlTime(object):

    def get_jrnldata(self):
        """Get the jrnl entries that contain the tag "@time".
        """
        jrnloutput = subprocess.check_output(['jrnl', '--export', 'json', '@time'])
        jrnloutput = jrnloutput[8:] # skip leading garbage
        jrnldata = yaml.load(jrnloutput)
        return jrnldata

    def get_categories(self, jrnldata):
        """Get the categories as a dictionary mapping category to a list of time entries.
        """
        categories = defaultdict(list)
        for entry in jrnldata['entries']:
            txt = entry['title'] + entry['body']
            m = re.search(r'@time\s*{(?P<elapsed>\d+[hm]),(?P<category>[^}]+)}', txt)
            if not m:
                # must be "@time" without a category, so skip it.
                continue
            elapsed = m.groupdict()['elapsed']
            category = m.groupdict()['category']
            categories[category].append(elapsed)
        return categories

    def get_workdays(self, jrnldata):
        """Get the workdays, total hours and hours-in-lieu.
        Note that only days with at least one workstart/workend pair is counted.
        Missing days are assumed to contribute 0 to hours-in-lieu (i.e. you worked 8 hours).
        """
        days = set()
        n_days = 0
        n_hours = 0
        for entry in jrnldata['entries']:
            txt = entry['title'] + entry['body']
            # TODO assume the order of workstart/workend entries is correct for now
            if "workstart" in txt:
                t0 = datetime.datetime.strptime("{} {}".format(entry['date'], entry['time']), '%Y-%m-%d %H:%M')
                d0 = entry['date']
            elif 'workend' in txt:
                # We now have a complete workday entry, so add the workstart date to days
                days.add(d0)
                # Compute elapsed hours
                t1 = datetime.datetime.strptime("{} {}".format(entry['date'], entry['time']), '%Y-%m-%d %H:%M')
                n_hours += ( (t1 - t0).total_seconds() / 3600.0 )
        n_days = len(days)
        hours_in_lieu = n_hours - (n_days * 8)
        return n_days, n_hours, hours_in_lieu

    def jrnl_summary(self):
        """Get a summary of activities and workdays as a dictionary.
        """
        jrnldata = self.get_jrnldata()
        categories = self.get_categories(jrnldata)
        n_days, n_hours, hours_in_lieu = self.get_workdays(jrnldata)

        summary = {
            "summary": {
                "n_days": n_days,
                "n_hours": n_hours,
                "hours_in_lieu": hours_in_lieu,
            },
        }

        catsum = {}
        totmin = 0
        catmin = {}
        for category, entries in categories.items():
            t = 0
            if category == "overhead":
                # add 15 minutes for standups
                t = 15
            for elapsed in entries:
                if elapsed[-1] == 'h':
                    minutes = int(elapsed[:-1]) * 60
                else:
                    minutes = int(elapsed[:-1])
                t += minutes
            catmin[category] = t
            totmin += t

        for category, entries in categories.items():
            catsum[category] = {
                "n_entries": len(entries),
                "percentage_of_time": catmin[category] * (100.0 / totmin),
            }

        summary["categories"] = catsum
        return summary

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description="Tool for tracking where your freaking time goes....",
        epilog=__doc__,
        formatter_class=argparse.RawTextHelpFormatter)
    parser.parse_args()

    jrnl = JrnlTime()
    summary = jrnl.jrnl_summary()
    print yaml.dump(summary, default_flow_style=False)
