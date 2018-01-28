Add this to $XYMONCLIENTHOME/clientlaunch.cfg

```
[ups]
        ENVFILE $XYMONCLIENTHOME/etc/xymonclient.cfg
        CMD $XYMONCLIENTHOME/ext/nut.sh
        LOGFILE $XYMONCLIENTLOGS/nut.log
        INTERVAL 5m
```

Add this to the graphs.cfg file:

```
[ups]
        FNPATTERN ^ups.(.*).rrd
        TITLE UPS
        YAXIS % Full
        DEF:p@RRDIDX@=@RRDFN@:lambda:AVERAGE
        LINE1:p@RRDIDX@#@COLOR@:@RRDPARAM@
        GPRINT:p@RRDIDX@:LAST: \: %5.1lf (cur)
        GPRINT:p@RRDIDX@:MAX: \: %5.1lf (max)
        GPRINT:p@RRDIDX@:MIN: \: %5.1lf (min)
        GPRINT:p@RRDIDX@:AVERAGE: \: %5.1lf (avg)\n
```
