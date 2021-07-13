import Foundation

protocol DatePickerViewDelegate: AnyObject {
    func datePicker(_ picker: DatePickerView, didSelectDate: Date)
    func datePickerDidCancel(_ picker: DatePickerView)
}
