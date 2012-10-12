# WebMonitor

Website monitoring tool by response time and status

## Installation

Install

    gem install web-monitor

Create config.yml file with following options

    $ cat config.yml
    response_time_limit: 3.0          # in seconds
    alert_mail: login@somedomain.com  # errors will be sent there
    urls_file: urls.csv               # file with site list to monitor
    log_file: web-monitor.log         # file with logs
    delay: 1.0                        # delay between requests (in seconds)

Create urls.csv file to monitor

    $ cat urls.csv
    google,https://www.google.pl
    bbc,http://www.bbc.co.uk
    err1,http://aaa.bbb.ccc.ddd.com
    err2,https://wp.pl

Execute

    $ web-monitor config.yml

Read logfile

    $ cat web-monitor.log

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
