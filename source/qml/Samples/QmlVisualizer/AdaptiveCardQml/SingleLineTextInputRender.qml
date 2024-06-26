import "AdaptiveCardUtils.js" as AdaptiveCardUtils
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

Rectangle {
    id: singleLineTextElementRect

    property bool _showErrorMessage
    property string textValue: _inputtextTextField.text

    border.color: _inputtextTextField.outerShowErrorMessage ? CardConstants.inputFieldConstants.borderColorOnError : CardConstants.inputFieldConstants.borderColorNormal
    border.width: CardConstants.inputFieldConstants.borderWidth
    radius: CardConstants.inputFieldConstants.borderRadius
    color: CardConstants.inputFieldConstants.backgroundColorNormal
    height: CardConstants.inputFieldConstants.height

    TextField {
        id: _inputtextTextField

        property bool outerShowErrorMessage: _showErrorMessage

        function colorChange(colorItem, focusItem, isPressed) {
            if (isPressed && !focusItem.outerShowErrorMessage)
                colorItem.color = CardConstants.inputFieldConstants.backgroundColorOnPressed;
            else
                colorItem.color = focusItem.activeFocus ? CardConstants.inputFieldConstants.backgroundColorOnPressed : focusItem.hovered ? CardConstants.inputFieldConstants.backgroundColorOnHovered : CardConstants.inputFieldConstants.backgroundColorNormal;
        }

        function assignMaxLength() {
            if (_maxLength != 0)
                maximumLength = _maxLength;

        }

        selectByMouse: true
        selectedTextColor: 'white'
        color: CardConstants.inputFieldConstants.textColor
        placeholderTextColor: CardConstants.inputFieldConstants.placeHolderColor
        Accessible.role: Accessible.EditableText
        onPressed: {
            colorChange(_inputtextTextFieldWrapper, _inputtextTextField, true);
            event.accepted = true;
        }
        onReleased: {
            colorChange(_inputtextTextFieldWrapper, _inputtextTextField, false);
            forceActiveFocus();
            event.accepted = true;
        }
        onHoveredChanged: colorChange(_inputtextTextFieldWrapper, _inputtextTextField, false)
        onActiveFocusChanged: {
            colorChange(_inputtextTextFieldWrapper, _inputtextTextField, false);
            if (activeFocus)
                Accessible.name = getAccessibleName();

        }
        onOuterShowErrorMessageChanged: {
            if (_isRequired || _regex != "")
                colorChange(_inputtextTextFieldWrapper, _inputtextTextField, false);

        }
        Accessible.name: ""
        leftPadding: CardConstants.inputFieldConstants.textHorizontalPadding
        rightPadding: CardConstants.inputFieldConstants.textHorizontalPadding
        topPadding: CardConstants.inputFieldConstants.textVerticalPadding
        bottomPadding: CardConstants.inputFieldConstants.textVerticalPadding
        padding: 0
        font.pixelSize: CardConstants.inputFieldConstants.pixelSize
        text: _mEscapedValueString
        placeholderText: activeFocus ? '' : _mEscapedPlaceHolderString
        width: parent.width - _inputtextTextFieldClearIcon.width - CardConstants.inputFieldConstants.clearIconHorizontalPadding
        onTextChanged: {
            if (_maxLength != 0)
                remove(_maxLength, length);

        }
        Component.onCompleted: {
            assignMaxLength();
        }

        background: Rectangle {
            color: 'transparent'
        }

    }

    InputFieldClearIcon {
        id: _inputtextTextFieldClearIcon

        Keys.onReturnPressed: onClicked()
        visible: _inputtextTextField.text.length != 0
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: CardConstants.inputFieldConstants.clearIconHorizontalPadding
        onClicked: {
            nextItemInFocusChain().forceActiveFocus();
            _inputtextTextField.clear();
        }
    }

   WCustomFocusItem {
        isRectangle: true
        visible: _inputtextTextField.activeFocus
        designatedParent: parent
    }

}
