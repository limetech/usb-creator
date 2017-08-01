#!/bin/sh
################################################################################
#      This file is part of unRAID USB Creator - https://github.com/limetech/usb-creator
#      Copyright (C) 2016 Team LibreELEC
#      Copyright (C) 2017 Lime Technology, Inc
#
#  unRAID USB Creator is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  unRAID USB Creator is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with unRAID USB Creator.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

set -e

echo ""
echo "Start building..."

USER=$(whoami)

chmod -R 755 dmg_osx

#echo ""
#echo "Creating .qm files"
#/Users/$USER/Qt/5.9.1-static/bin/lrelease creator.pro

echo ""
echo "Running qmake..."
/Users/$USER/Qt/5.9.1-static/bin/qmake

echo ""
echo "Building..."
make -j4

# to decompile
#    osadecompile main.scpt >main.scpt.txt
echo ""
echo "Running osacompile..."
mkdir -p dmg_osx/template.app/Contents/Resources/Scripts
osacompile -t osas -o dmg_osx/template.app/Contents/Resources/Scripts/main.scpt dmg_osx/main.scpt.txt

#echo ""
#echo "Running macdeployqt..."
#/Users/$USER/Qt/5.9.1-static/bin/macdeployqt "unRAID USB Creator.app" -no-plugins

echo ""
echo "Copying template files over..."
cp -r dmg_osx/template.app/* "unRAID USB Creator.app"

echo ""
echo "  To run application directly type"
echo "    sudo \"unRAID USB Creator.app/Contents/MacOS/unRAID USB Creator\""
echo ""
echo "  Or run osx_make_dmg.sh script to create final .dmg file..."
echo ""
echo "Finished..."
echo ""

exit 0