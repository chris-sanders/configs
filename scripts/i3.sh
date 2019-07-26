#!/bin/bash

function DPConnected (){
    xrandr | grep "^DP-1-1" | grep connected >/dev/null 2>&1
}

if ! DPConnected
then
    echo "No Display Port, not applying settings"
    return 0
fi 

# Setup external monitor
xrandr --output DP-1-1 --right-of eDP-1-1

# Setup audio defaults
# pacmd "set-default-sink alsa_output.usb-CalDigit__Inc._CalDigit_Thunderbolt_3_Audio-00.iec958-stereo"

# Setup work browser
i3-msg "workspace 2;
        move workspace to output DP-1-1;
        append_layout /home/chris/.config/i3/browser.json;" &&\ 
	google-chrome --profile-directory="Profile 1" \
	              "https://glowing-bear.org/#" \
		      "https://calendar.google.com/calendar" \
		      "https://portal.admin.canonical.com/bootstack/triage/?team=CRE" \
		      "https://nagios.bootstack.canonical.com/thruk/#cgi-bin/extinfo.cgi?type=6" \
		      "https://canonical.greenhouse.io/people?sort_by=last_activity&sort_order=desc&stage_status_id%5B%5D=2&job_status=open&in_stages%5B%5D=Application+Review&user_id_on_jobs=&user_role_on_jobs=&department_id%5B%5D=&hiring_plan_id%5B%5D=605378&hiring_plan_id%5B%5D=685701&hiring_plan_id%5B%5D=712896&office_id%5B%5D=&job_custom_field_id=&job_custom_field_answer_id=" \
		      &

# Setup thunderbird
i3-msg "workspace 4;
        move workspace to output DP-1-1;
        append_layout /home/chris/.config/i3/thunderbird.json;" &&\ 
	thunderbird & 

# Setup personal browser
i3-msg "workspace 3;
        move workspace to output DP-1-1;
        append_layout /home/chris/.config/i3/browser.json;" &&\ 
	google-chrome --profile-directory="Default" \
		      "https://mail.google.com/" \
		      "https://play.google.com/music/listen#/now" \
		      &

# Setup keepass
i3-msg "workspace 10;
        move workspace to output DP-1-1;" &&\
	keepass2 & 

