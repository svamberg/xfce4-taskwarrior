# XFCE TaskWarrior widget
Taskwarrior widget for xfce4 panel inspired by https://github.com/bimlas/xfce4-timewarrior

XFCE Generic Monitor widget that allows you to easily *show the actual (or the most recent) task in TaskWarrior*.

https://gitlab.com/svamberg/xfce4-taskwarrior 

# Create the widget
* Install the packages first if they are not already on your system
** https://docs.xfce.org/panel-plugins/xfce4-genmon-plugin[XFCE Generic Monitor plugin] (`xfce4-genmon-plugin`)
** https://taskwarrior.net/[TaskWarrior] (`taskwarrior`)
** https://github.com/junegunn/fzf[FZF] (`fzf`) or https://github.com/davatorium/rofi[Rofi] (`rofi`)
* Add the monitor to the panel
** Right click on the panel
** Select _Panel -> Add new items_
** Add _Generic Monitor_ plugin
* Set up the generic monitor to use with this script
** Right click on the newly added generic monitor -> _Properties_
** Command: `/path/to/xfce4-taskwarrior.sh rofi` or `/path/to/xfce4-timewarrior.sh fzf`
** Uncheck the checkbox of _Label_
** Set _Period_ to `5` seconds

# Usage
* Click on the image to start/stop the most recent task
* Click on the task name to select new task
