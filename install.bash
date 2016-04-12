#!/usr/bin/env bash
echo "Copying etc to /etc" && cd etc && cp -R ./* /etc && cd -
printf "Copying home to %s" $HOME && cd home && cp -R ./{*,.*} $HOME && cd -
echo "Copying usr to /usr" && cd usr && cp -R ./* /usr && cd -
echo "Done!"
