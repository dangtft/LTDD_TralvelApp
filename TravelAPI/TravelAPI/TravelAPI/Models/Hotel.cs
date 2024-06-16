using System.ComponentModel.DataAnnotations;

namespace TravelAPI.Models
{
	public class Hotel
	{
		[Key]
		public int HotelId { get; set; }
		public string? HotelName { get; set; }
		public string? ImageUrl { get; set; }
		public string? Location { get; set; }
		public decimal? Price { get; set; }
		public int? Rating { get; set; }
		public bool? IsLike { get; set; }
		public string? Information { get; set; }
		public List<Room>? Rooms { get; set; }
	}
}
