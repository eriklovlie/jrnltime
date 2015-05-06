# jrnltime - Simple time tracking using jrnl

The point of this script is that if you use jrnl already (for dev-diary or other notes)
you might as well also use it for time tracking. This is done by adding the tag "@time"
to log entries.

There are two types of @time entries used for separate things.

## Working hours

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

## Activities

The other type of @time entry is for tracking an activity. This is useful to see where
your time is being spent. Add an entry like this:

    jrnl "Spent some time on the foo @time{1h,overhead}"

The jrnl entry text is arbitrary, and so is the "category" (which in this case is
"overhead"). The "1h" field means "1 hour". Also accepted is e.g. "30m" for "30 minutes".

The activity entries are summed and the result is a distribution of your time over the
activities present in the jrnl. As mentioned this is completely separate from the tracking
of working days/hours.
