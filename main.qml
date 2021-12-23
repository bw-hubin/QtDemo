import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtMultimedia 5.0
import QtQuick.Dialogs 1.2
import com.mycompany.mediainfo 1.0

Window {
    id: root
    visible: true
    width: 640; height: 360
    title: "VechileGuage"
    Mediainfo{
        id:media
    }
    Rectangle{
        id:rootRect
        color:"black"
        anchors.fill: parent
//        ListView {
//            anchors.fill: parent
//            anchors.margins: 20
//            clip: true
//            model: spaceMen
//            delegate: spaceManDelegate
//            section.property: "nation"
//            section.delegate: sectionDelegate
//        }
//        Component {
//            id: spaceManDelegate
//            Item {
//                width: 160
//                height: 20
//                Text {
//                    anchors.left: parent.left
//                    anchors.verticalCenter: parent.verticalCenter
//                    anchors.leftMargin: 10
//                    font.pixelSize: 12
//                    color: "white"
//                    text: name
//                }
//            }
//        }
//        Component {
//            id: sectionDelegate
//            Rectangle {
//                width: 160
//                height: 30
//                color: "lightGray"
//                Text {
//                    anchors.left: parent.left
//                    anchors.verticalCenter: parent.verticalCenter
//                    anchors.leftMargin: 10
//                    font.pixelSize: 12
//                    font.bold: true
//                    color: "white"
//                    text: section
//                }
//            }
//        }
//        ListModel {
//            id: spaceMen
//            ListElement { name: "Abdul Ahad Mohmand"; nation: "Afganistan"; }
//            ListElement { name: "Marcos Pontes"; nation: "Brazil"; }
//            ListElement { name: "Alexandar Panayotov Alexandrov"; nation: "Bulgaria" }
//            ListElement { name: "Georgi Ivanov"; nation: "Bulgaria"; }
//            ListElement { name: "Roberta Bondar"; nation: "Canada"; }
//            ListElement { name: "Marc Garneau"; nation: "Canada"; }
//            ListElement { name: "Chris Hadfield"; nation: "Canada"; }
//            ListElement { name: "Guy Laliberte"; nation: "Canada"; }
//            ListElement { name: "Steven MacLean"; nation: "Canada"; }
//            ListElement { name: "Julie Payette"; nation: "Canada"; }
//            ListElement { name: "Robert Thirsk"; nation: "Canada"; }
//            ListElement { name: "Bjarni Tryggvason"; nation: "Canada"; }
//            ListElement { name: "Dafydd Williams"; nation: "Canada"; }
//        }
        FuelGuage {
            id:fuelguage
            x: 0
            y: 268
            width: 170
            height: 130
            icon:"qrc:/img/fuel_icon_color.png"
            onAcceleratingChanged: {
                console.log("Fuel is accelerating!!!!")
                accfuel(accelerating)
            }
        }

        Connections{
            target: fuelguage
            onAccfuel:{
                console.log("state is: " + state)
            }
        }

        SpeedGuage {
            id:speedguage
            anchors.fill: parent
            anchors.verticalCenterOffset: 7
            anchors.horizontalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        SequentialAnimation{
            id:startAnimation
            NumberAnimation {
                targets: [textEdit]
                property: "opacity"
                duration: 1000
                from: 0.0
                to:1.0
                easing {type: Easing.InBack}
            }
            NumberAnimation {
                targets: [speedguage]
                property: "opacity"
                duration: 1000
                from: 0.0
                to:1.0
                easing {type: Easing.InBack}
            }
            NumberAnimation {
                targets: [fuelguage]
                property: "opacity"
                duration: 1000
                from: 0.0
                to:1.0
                easing {type: Easing.InBack}
            }
        }

        function request() {
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
                    print('HEADERS_RECEIVED');
                } else if(xhr.readyState === XMLHttpRequest.DONE) {
                    var object = JSON.parse(xhr.responseText.toString());
                    print(JSON.stringify(object, null, 2));
                    messageDialog.show(object.remark + "-" + object.message)
                }
            }
            xhr.open("GET", "http://localhost:3000/vehicle?license=iEV7S&vin=LJ1EEKRP3G4023922");
            xhr.send();
        }

        MyButton {
            id: button
            x: 500; y: 52
            text: qsTr("Start")
            onClicked: {
                startAnimation.start()
                rootRect.forceActiveFocus()

                rootRect.request()

                camera.start()
            }
        }

        MyButton {
            id: btnHide
            x: 560; y: 52
            text: qsTr("Hide")
            onClicked: {
                fuelguage.opacity = 0
                speedguage.opacity = 0
                textEdit.opacity = 0

                camera.stop()
            }
        }

        TextEdit {
            id: textEdit
            x: 290
            y: 115
            width: 100
            height: 25
            color: "white"
            opacity: 0.0
            text: qsTr("Brainware")
            font.pixelSize: 12
            onTextChanged: {
                media.medianame = text
            }
        }

//        Rectangle {
//            id: rect1
//            x: 12; y: 12
//            width: 76; height: 96
//            gradient: Gradient {
//                GradientStop { position: 0.0; color: "lightsteelblue" }
//                GradientStop { position: 1.0; color: "slategray" }
//            }
//            border.color: "slategray"
//            MouseArea {
//                id: area
//                width: parent.width
//                height: parent.height
////                onClicked: rect2.visible = !rect2.visible
//                onClicked: {
//                    // set the easing type on the animation
//                    anim.easing.type = "InBack"
//                    // restart the animation
//                    anim.restart()
//                }
//            }
//        }

//        Rectangle {
//            id: rect2
//            x: 112; y: 12
//            width: 76; height: 96
//            border.color: "lightsteelblue"
//            border.width: 4
//            radius: 8
//        }

//        NumberAnimation {
//            id: anim
//            targets: [rect2]
//            from: 140; to: 320
//            properties: "x"
//            duration: 1000
//        }

        Canvas {
            id: rootCanvas
            width: 240; height: 120
            x: 460; y: 100
            onPaint: {
                var ctx = getContext("2d")
                var gradient = ctx.createLinearGradient(100,0,100,200)
                gradient.addColorStop(0, "blue")
                gradient.addColorStop(0.5, "lightsteelblue")
                ctx.fillStyle = gradient
                ctx.fillRect(50,50,100,100)
            }
        }

        Image {
            id: sourceImage
            width: 80; height: width
            visible: false
            source: "1.jpeg"
        }

        ShaderEffect {
            id: effect
            width: 80; height: width
            x: 50; y: 50
            property variant source: sourceImage
        }

        Item {
            width: 100; height: width
            x: 510; y: 200
            VideoOutput {
                anchors.fill: parent
                source: camera
            }
            Camera {
                id: camera
            }
        }

        MessageDialog {
            id: messageDialog
            title: qsTr("May I have your attention, please?")
            icon: StandardIcon.Information
            standardButtons: StandardButton.Cancel

            function show(caption) {
                messageDialog.text = caption;
                messageDialog.open();
            }
        }

        Connections{
            target: media
            onMediastart:
            {
                console.log("media start!!!!")
            }
        }

        Component.onCompleted:
        {

        }

        Keys.onSpacePressed: {
            speedguage.accelerating = true
            fuelguage.accelerating = true
        }
        Keys.onReleased: {
            if (event.key === Qt.Key_Space) {
                speedguage.accelerating  = false;
                fuelguage.accelerating = false;
                event.accepted = true;
            }
        }
        Keys.onEnterPressed: {
            console.log("enter pressed")
            speedguage.cgSpeed.value = 100
        }
    }
}
