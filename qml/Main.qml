/*
 * Copyright (C) 2023  Jakob Stechow
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * metaedit is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import Ubuntu.Components 1.3
import Ubuntu.Content 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.4

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'metaedit.invertedecho'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    PageStack {
        id: pageStack
        Component.onCompleted: push(mainPage)
        anchors.fill: parent
    }

    Page {
        id: mainPage
        ColumnLayout {
            anchors.fill: parent
            Label {
                id: titleLabel
                text: "Title of selected song"
            }
            Button {
                text: "Click to select a file"
                onClicked: pageStack.push(picker)
            }
        }
    }

    Page {
        visible: false
        id: picker
        property alias activeTransfer: signalConnections.target
        ColumnLayout {
            anchors.fill: parent
            ContentPeerPicker {
                headerText: "Pick your audio file:"
                id: contentPicker
                contentType: ContentType.Documents
                anchors.fill: parent
                visible: true
                handler: ContentHandler.Source
                onPeerSelected: {
                    peer.selectionType = ContentTransfer.Single
                    picker.activeTransfer = peer.request()
                }

                onCancelPressed: {
                    pageStack.pop()
                }
            }
        }
        Connections {
            id: signalConnections
            onStateChanged: {
                if (picker.activeTransfer.state === ContentTransfer.Charged) {
                    if (picker.activeTransfer.items.length > 0) {
                        titleLabel.text = String(picker.activeTransfer.items[0].url).replace("file://", "")
                        pageStack.pop()
                    }
                }
            }
        }
        Python {
            id: python
            Component.onCompleted: {
                addImportPath(Qt.resolvedUrl('../src/'));
                importModule_sync('example');
            }

            onError: {
                console.log('python error: ' + traceback);
            }
        }
    }

    
}
