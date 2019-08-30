import Foundation

class Address: Codable {
	let street: String?
	let suite: String?
	let city: String?
	let zipcode: String?
	let geo: Geometry?
}
