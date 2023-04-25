'''
 Copyright (C) 2023  Jakob Stechow

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; version 3.

 metaedit is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
'''
from mutagen.flac import FLAC
import mutagen

def speak(text):
    something = FLAC(text)
    title = something.get("title")
    print(title)
    return title