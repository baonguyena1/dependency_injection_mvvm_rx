import Foundation

class Geo: Codable {
	let lat: String?
	let lng: String?

	enum CodingKeys: String, CodingKey {

		case lat = "lat"
		case lng = "lng"
	}

    required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		lat = try values.decodeIfPresent(String.self, forKey: .lat)
		lng = try values.decodeIfPresent(String.self, forKey: .lng)
	}

}
