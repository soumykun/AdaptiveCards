@testable import AdaptiveCards
import AdaptiveCards_bridge
import XCTest

class InputTimeRendererTest: XCTestCase {
    private var hostConfig: FakeHostConfig!
    private var inputTime: FakeInputTime!
    private var inputTimeRenderer: InputTimeRenderer!

    override func setUpWithError() throws {
        try super.setUpWithError()
        hostConfig = .make()
        inputTime = .make()
        inputTimeRenderer = InputTimeRenderer()
    }
    
    func testHeightProperty() {
        let val: String = "15:30:32"
        
        inputTime = .make(value: val, heightType: .auto)
        var inputTimeField = renderTimeInput()
        XCTAssertEqual(inputTimeField.contentStackView.arrangedSubviews.count, 1)
        XCTAssertNil(inputTimeField.contentStackView.arrangedSubviews.last as? StretchableView)
        
        inputTime = .make(value: val, heightType: .stretch)
        inputTimeField = renderTimeInput()
        
        XCTAssertEqual(inputTimeField.contentStackView.arrangedSubviews.count, 2)
        XCTAssertNotNil(inputTimeField.contentStackView.arrangedSubviews.last as? StretchableView)
        guard let stretchView = inputTimeField.contentStackView.arrangedSubviews.last as? StretchableView else { return XCTFail() }
        XCTAssertEqual(stretchView.contentHuggingPriority(for: .vertical), kFillerViewLayoutConstraintPriority)
    }
    
    func testRendererSetsValue() {
        let val: String = "15:30:32"
        inputTime = .make(value: val)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"

        let inputTimeField = renderTimeInput()
        XCTAssertEqual(inputTimeField.datePickerCalendar.dateValue, dateFormatter.date(from: "15:30"))
        XCTAssertEqual(inputTimeField.datePickerTextfield.dateValue, dateFormatter.date(from: "15:30"))
        XCTAssertEqual(inputTimeField.dateValue, "15:30")
    }

    func testRendererSetsPlaceholder() {
        let placeholderString: String = "Sample Placeholder"
        inputTime = .make(placeholder: placeholderString)

        let inputTimeField = renderTimeInput()
        XCTAssertEqual(inputTimeField.placeholder, placeholderString)
    }
    
    func testRendererForMinValue() {
        let minVal: String = "09:30:23"
        inputTime = .make(min: minVal)

        let inputTimeField = renderTimeInput()
        XCTAssertEqual(inputTimeField.minDateValue, "09:30")
    }

    func testRendererForMaxValue() {
        let maxValue: String = "16:00:23"
        inputTime = .make(max: maxValue)

        let inputTimeField = renderTimeInput()
        XCTAssertEqual(inputTimeField.maxDateValue, "16:00")
    }
    
    func testRendererForIsRequired() {
        inputTime = .make(isRequired: true)
        
        let inputTimeField = renderTimeInput()
        XCTAssertTrue(inputTimeField.isRequired)
    }
    
    func testClearsText() {
        let val: String = "16:23:30"
        let fakeErrorDelegate = FakeErrorMessageHandlerDelegate()
        inputTime = .make(value: val)

        let inputTimeField = renderTimeInput()
        inputTimeField.errorDelegate = fakeErrorDelegate
        fakeErrorDelegate.isErrorVisible = true
        inputTimeField.textField.clearButton.performClick()
        
        XCTAssertNil(inputTimeField.dateValue)
        XCTAssertEqual(inputTimeField.textField.stringValue, "")
        XCTAssertTrue(inputTimeField.textField.clearButton.isHidden)
        XCTAssertFalse(fakeErrorDelegate.isErrorVisible)
    }
    
    func testClearButtonHiddenWithPlaceholder() {
        let placeholderString: String = "Sample Placeholder"
        inputTime = .make(placeholder: placeholderString)

        let inputTimeField = renderTimeInput()
        XCTAssertTrue(inputTimeField.textField.clearButton.isHidden)
    }

    func testClearButtonHiddenWithNoText() {
        inputTime = .make()

        let inputTimeField = renderTimeInput()
        XCTAssertTrue(inputTimeField.textField.clearButton.isHidden)
    }

    func testClearButtonVisibleWithText() {
        let val: String = "4:30"
        inputTime = .make(value: val)

        let inputTimeField = renderTimeInput()
        XCTAssertFalse(inputTimeField.textField.clearButton.isHidden)
    }
    
    func testValueShownOnlyForRightInputFormat() {
        let val: String = "5:30am"
        inputTime = .make(value: val)

        let inputTimeField = renderTimeInput()
        XCTAssertNil(inputTimeField.dateValue)
        XCTAssertEqual(inputTimeField.textField.stringValue, "")
    }
    
    func testCurrentTimeInPopOverDefault() {
        inputTime = .make()
        
        let inputTimeField = renderTimeInput()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        XCTAssertEqual(dateFormatter.string(from: inputTimeField.datePickerCalendar.dateValue), dateFormatter.string(from: Date()))
        XCTAssertEqual(dateFormatter.string(from: inputTimeField.datePickerTextfield.dateValue), dateFormatter.string(from: Date()))
    }
    
    func testAccessbilityValueIsSet() {
        let val: String = "12:24"
        inputTime = .make(value: val)
        
        let inputTimeField = renderTimeInput()
        XCTAssertEqual(inputTimeField.accessibilityRoleDescription(), "Time Picker")
        XCTAssertEqual(inputTimeField.textField.accessibilityValue(), "12:24 PM")
    }
    
    func testInvalidTimeRejected() {
        let minVal = "10:15"
        let maxVal = "16:45"
        
        //date less than min date
        var val = "8:25"
        inputTime = .make(value: val, max: maxVal, min: minVal)
        var inputTimeField = renderTimeInput()
        
        XCTAssertFalse(inputTimeField.isValid)
        
        //date in right range
        val = "12:00"
        inputTime = .make(value: val, max: maxVal, min: minVal)
        inputTimeField = renderTimeInput()
        
        XCTAssertTrue(inputTimeField.isValid)
        
        //date greater than max range
        val = "20:45"
        inputTime = .make(value: val, max: maxVal, min: minVal)
        inputTimeField = renderTimeInput()
        
        XCTAssertFalse(inputTimeField.isValid)
    }
    
    func testInvalidTimeOnClearRemovesError() {
        let fakeErrorDelegate = FakeErrorMessageHandlerDelegate()
        
        inputTime = .make(value: "8:25", min: "10:15")
        let inputTimeField = renderTimeInput()
        inputTimeField.errorDelegate = fakeErrorDelegate
        fakeErrorDelegate.isErrorVisible = true
        
        XCTAssertFalse(inputTimeField.isValid)
        
        inputTimeField.textField.clearButton.performClick()
        
        XCTAssertTrue(inputTimeField.isValid)
        XCTAssertFalse(fakeErrorDelegate.isErrorVisible)
    }

    private func renderTimeInput() -> ACRDateField {
        let view = inputTimeRenderer.render(element: inputTime, with: hostConfig, style: .default, rootView: FakeRootView(), parentView: NSView(), inputs: [], config: .default)

        XCTAssertTrue(view is ACRDateField)
        guard let inputTime = view as? ACRDateField else { fatalError() }
        return inputTime
    }
}
