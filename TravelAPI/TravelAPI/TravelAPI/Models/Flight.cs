using System.ComponentModel.DataAnnotations;

namespace TravelAPI.Models
{
	public class Flight
	{
		[Key]
		public int FlightId { get; set; }
		public string? FlightName { get; set; }
		public string? ImageUrl { get; set; }
		public string? Location { get; set; }
		public string? Destination { get; set; }
		public int? DayFlight { get; set; }
		public DateTime? DepartureTime { get; set; }
		public decimal? Price { get; set; }
		public int? Ticket { get; set; }

		public ICollection<FlightBooking>? FlightBookings { get; set; }
	}
}
