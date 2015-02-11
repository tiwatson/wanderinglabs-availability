Wanderinglabs Availability
================

Application that scrapes Reserve America according to queries provided by the end users. Looks for open campsites then notifies them via email.

Useful for when wanting to camp at a fully booked campground. If someone else cancels their reservation, this app will let you know so you may then book it.

See it in action (http://reserve.wanderinglabs.com)

-----------

Scraping goes down like so:

- Get request made to campground page to set session (LocationConnection)
- Post request made to campground page to set filters (LocationFilter)
- Multiple get requests made for next availability (LocationScraper)


Credits
-----------

Created by [Tim Watson](http://tiwatson.com)

As part of the [Wandering Labs Project](http://wanderinglabs.com)
