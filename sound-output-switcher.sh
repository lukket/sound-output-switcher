#!/bin/bash

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

getOutputProfiles() {
	result=`pacmd list-cards | egrep -e "[^<]output:" | egrep -e "input" -v | cut -d ':' -f2 | sed -e 's/^ *//g' -e 's/ *$//g'`
	echo "${result}"
}

getOutputDescription() {
	result=`pacmd list-cards | egrep -e "[^<]output:" | egrep -e "input" -v | cut -d ':' -f3 | sed -e 's/^ *//g' -e 's/ *$//g' | sed -e 's/\(Output.*\)//g'`
	echo "${result}"
}


OPTIND=1

while getopts "h?pd" opt; do
    case "$opt" in
    h|\?)
        echo "USAGE: $0 [-pd]"
        exit 0
        ;;
    p)  getOutputProfiles
        ;;
    d)  getOutputDescription
        ;;
    esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift