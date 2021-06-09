#!/bin/sh

iwconfig wlp2s0 2>&1 | grep -q no\ wireless\ extensions\. && {
  echo wired
  exit 0
}

essid=`iwconfig wlp2s0 | awk -F '"' '/ESSID/ {print $2}'`
stngth=`iwconfig wlp2s0 | awk -F '=' '/Quality/ {print $2}' | cut -d '/' -f 1`
bars=`expr $stngth / 10`

case $bars in
  0)  bar='<fc=white>▱▱▱▱▱▱▱▱▱▱</fc>' ;;
  1)  bar='<fc=#FF0068>▰</fc><fc=white>▱▱▱▱▱▱▱▱▱</fc>' ;;
  2)  bar='<fc=#FF0068>▰▰</fc><fc=white>▱▱▱▱▱▱▱▱</fc>' ;;
  3)  bar='<fc=#FF0068>▰▰▰</fc><fc=white>▱▱▱▱▱▱▱</fc>' ;;
  4)  bar='<fc=#FF0068>▰▰▰▰</fc><fc=white>▱▱▱▱▱▱</fc>' ;;
  5)  bar='<fc=#FF0068>▰▰▰▰▰</fc><fc=white>▱▱▱▱▱</fc>' ;;
  6)  bar='<fc=#FF0068>▰▰▰▰▰▰</fc><fc=white>▱▱▱▱</fc>' ;;
  7)  bar='<fc=#FF0068>▰▰▰▰▰▰▰</fc><fc=white>▱▱▱</fc>' ;;
  8)  bar='<fc=#FF0068>▰▰▰▰▰▰▰▰</fc><fc=white>▱▱</fc>' ;;
  9)  bar='<fc=#FF0068>▰▰▰▰▰▰▰▰▰</fc><fc=white>▱</fc>' ;;
  10) bar='<fc=#FF0068>▰▰▰▰▰▰▰▰▰▰</fc>' ;;
  *)  bar='<fc=white>▱▱▱▱</fc><fc=#FF0000>!!</fc><fc=white>▱▱▱▱</fc>' ;;
esac

echo "<fc=white>"$essid"</fc>" "<fc=#A60036>|</fc>" $bar

exit 0
