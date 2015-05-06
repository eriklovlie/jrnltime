#!/usr/bin/env python

import unittest
import jrnltime

class JrnlTime(unittest.TestCase):

    def setUp(self):
        self.jrnl = jrnltime.JrnlTime()

    def tearDown(self):
        pass

    def test_workdays_one_day(self):
        jrnldata = {
            'entries': [
                {
                    'title': 'entry 0',
                    'body': 'workstart @time',
                    'date': '2015-04-28',
                    'time': '08:00',
                },
                {
                    'title': 'entry 1 workend @time',
                    'body': 'yo',
                    'date': '2015-04-28',
                    'time': '16:00',
                },
            ]
        }
        n_days, n_hours, hours_in_lieu = self.jrnl.get_workdays(jrnldata)
        self.assertEquals(n_days, 1)
        self.assertEquals(n_hours, 8)
        self.assertEquals(hours_in_lieu, 0)

    def test_workdays_two_days(self):
        jrnldata = {
            'entries': [
                {
                    'title': 'entry 0',
                    'body': 'workstart @time',
                    'date': '2015-04-28',
                    'time': '08:00',
                },
                {
                    'title': 'entry 1 workend @time',
                    'body': 'yo',
                    'date': '2015-04-28',
                    'time': '16:00',
                },
                {
                    'title': 'entry 2 workstart @time',
                    'body': 'foo',
                    'date': '2015-04-29',
                    'time': '09:00',
                },
                {
                    'title': 'entry 3 workend @time',
                    'body': 'bar',
                    'date': '2015-04-29',
                    'time': '15:00',
                },
            ]
        }
        n_days, n_hours, hours_in_lieu = self.jrnl.get_workdays(jrnldata)
        self.assertEquals(n_days, 2)
        self.assertEquals(n_hours, 8+6)
        self.assertEquals(hours_in_lieu, -2)

    def test_workdays_one_day_two_entries(self):
        jrnldata = {
            'entries': [
                {
                    'title': 'entry 0',
                    'body': 'workstart @time',
                    'date': '2015-04-28',
                    'time': '08:00',
                },
                {
                    'title': 'entry 1 workend @time',
                    'body': 'yo',
                    'date': '2015-04-28',
                    'time': '16:00',
                },
                {
                    'title': 'entry 2 workstart @time',
                    'body': 'foo',
                    'date': '2015-04-28',
                    'time': '20:00',
                },
                {
                    'title': 'entry 3 workend @time',
                    'body': 'bar',
                    'date': '2015-04-28',
                    'time': '21:00',
                },
            ]
        }
        n_days, n_hours, hours_in_lieu = self.jrnl.get_workdays(jrnldata)
        self.assertEquals(n_days, 1)
        self.assertEquals(n_hours, 8+1)
        self.assertEquals(hours_in_lieu, 1)

    def test_workdays_one_day_two_entries_working_late(self):
        jrnldata = {
            'entries': [
                {
                    'title': 'entry 0',
                    'body': 'workstart @time',
                    'date': '2015-04-28',
                    'time': '08:00',
                },
                {
                    'title': 'entry 1 workend @time',
                    'body': 'yo',
                    'date': '2015-04-28',
                    'time': '16:00',
                },
                {
                    'title': 'entry 2 workstart @time',
                    'body': 'foo',
                    'date': '2015-04-28',
                    'time': '23:00',
                },
                {
                    'title': 'entry 3 workend @time',
                    'body': 'bar',
                    'date': '2015-04-29',
                    'time': '01:00',
                },
            ]
        }
        n_days, n_hours, hours_in_lieu = self.jrnl.get_workdays(jrnldata)
        # Starting a workday on day A and ending on day A+1 should count as
        # "1 workday with extra hours".
        self.assertEquals(n_days, 1)
        self.assertEquals(n_hours, 8+2)
        self.assertEquals(hours_in_lieu, 2)

    def test_workdays_workday_in_progress(self):
        jrnldata = {
            'entries': [
                {
                    'title': 'entry 0',
                    'body': 'workstart @time',
                    'date': '2015-04-28',
                    'time': '08:00',
                },
                {
                    'title': 'entry 1 workend @time',
                    'body': 'yo',
                    'date': '2015-04-28',
                    'time': '16:00',
                },
                {
                    'title': 'entry 2 workstart @time',
                    'body': 'foo',
                    'date': '2015-04-29',
                    'time': '08:00',
                },
            ]
        }
        n_days, n_hours, hours_in_lieu = self.jrnl.get_workdays(jrnldata)
        self.assertEquals(n_days, 1)
        self.assertEquals(n_hours, 8)
        self.assertEquals(hours_in_lieu, 0)

if __name__ == '__main__':
    unittest.main()
