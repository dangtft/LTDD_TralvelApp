using System.ComponentModel.DataAnnotations;

namespace TravelAPI.Models
{
	public class Room
	{
		[Key]
		public int RoomId { get; set; }
		public string? RoomName { get; set; }
		public string? RoomSize { get; set; }
		public string? ImageUrl { get; set; }
		public decimal? Price { get; set; }
		public int? HotelId { get; set; }
		public string? Contact { get; set; }
		public string? PromoCode { get; set; }
		public string? Status { get; set; }
		public int? Rating { get; set; }
        public int? NumberOfPeople { get; set; }
        public Hotel? Hotel { get; set; }

		public ICollection<HotelBooking>? HotelBookings { get; set; }
	}
}
