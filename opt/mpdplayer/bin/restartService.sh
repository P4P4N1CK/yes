#!/bin/bash
echo "Restarting Flussonic and MpdPlayer"
systemctl restart flussonic
systemctl restart mpdplayer.service