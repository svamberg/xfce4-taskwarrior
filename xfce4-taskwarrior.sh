#!/bin/bash
# XFCE TaskWarrior: Widget to add and show entries of task tracker
#
# https://gitlab.com/svamberg/xfce4-taskwarrior (main repository)

if [ ! -d "${TASKWARRIORDB:-$HOME/.task}" ]; then
  echo "EXECUTE 'task' FROM COMMANDLINE FIRST!"
  exit 1
fi

recent_id=`task rc.verbose: +ACTIVE limit:1 rc.report.next.columns=id rc.report.next.labels=id`
if [ "x$recent_id" == "x"  ]; then
  recent_id=`task rc.verbose: limit:1 rc.report.next.columns=id rc.report.next.labels=id`
  is_active=0
  is_disabled=1
else
  is_active=1
  is_disabled=0
fi
recent_desc=`task _get ${recent_id}.description`

icon="/usr/share/icons/elementary-xfce/actions/16/media-playback-start.png"
if [ $is_disabled == 1 ]; then
  click="task start $recent_id"
fi
if [ $is_active -gt 0 ]; then
  icon="/usr/share/icons/elementary-xfce/actions/16/media-playback-stop.png"
  click="task stop $recent_id"
fi

list_tasks='task rc.verbose: rc.report.ls.columns=id,start.active,depends.indicator,project,tags,recur.indicator,wait.remaining,scheduled.countdown,due.countdown,until.countdown,description.truncated ls'

case "$1" in
  "fzf")
    select_task_command=" \
      $list_tasks \
      | fzf --print-query -i \
      | tail -1 \
      | awk \'{print \\\$1}\' \
      | tr -d '\n' \
      | xargs --null --no-run-if-empty -I '{}' task {} start"
    txtclick="x-terminal-emulator -e /bin/bash --login -i -c '$select_task_command'"
    ;;
  "rofi")
    txtclick="/bin/bash -c \" \
      $list_tasks \
      | rofi -dmenu -i \
      | tail -1 \
      | awk '{print \\\$1}' \
      | tr -d '\n' \
      | xargs --null --no-run-if-empty -I '{}' task {} start\""
    ;;
  *)
    echo "Unknown fuzzy filter: $1" >& 2
    exit 1
    ;;
esac

cat << __HEREDOC__
<img>$icon</img>
<txt>$recent_desc</txt>
<tool><span font-family="monospace" allow-breaks="false">`task summary`</span></tool>
<click>$click</click>
<txtclick>$txtclick</txtclick>
__HEREDOC__
