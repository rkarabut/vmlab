#!/bin/bash
if [ -z "$1" ]
  then
    echo "Usage: $0 <path/to/app.desktop>"
fi

export XDG_RUNTIME_DIR="/run/user/$(id -u)/"

if [[ ! -z "$(dbus-launch dconf dump /org/mate/panel/objects/ | grep $1)" ]]; then
    echo "Launcher already exists" >&2
    exit
fi

section=$(dbus-launch dconf dump /org/mate/panel/objects/ | grep "\[object-" | sort -n | tail -n1 | sed 's/[][]//g')

object_no=$(echo $section | sed 's/^.*-//')
new_object_no=$((($object_no + 1)))

pos=$(dbus-launch dconf dump /org/mate/panel/objects/$section/ | grep position \
    | sed 's/position=//')
new_pos=$((($pos + 27)))

new_general=$(dbus-launch dconf dump /org/mate/panel/general/ | \
    sed "s/^\(object-id-list=\[\)\(.*\)\(\]\)/\1\2, 'object-$new_object_no'\3/" |
    sed "s/\[\/\]/\[org\/mate\/panel\/general\]/")

read -d '' new_object <<EOF
[org/mate/panel/objects/object-$new_object_no]
launcher-location='$1'
object-type='launcher'
panel-right-stick=false
position=$new_pos
toplevel-id='top'
EOF

echo "$new_object" | dconf load /
echo "$new_general" | dconf load /
