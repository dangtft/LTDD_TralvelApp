using System.ComponentModel.DataAnnotations;

namespace TravelAPI.Models
{
	public class FlightBooking
	{
		[Key]
		public int FlightBookingId { get; set; }
		public int? UserId { get; set; }
		public int? FlightId { get; set; }
		public DateTime? BookingDate { get; set; }
		public string? Status { get; set; }

		public User? User { get; set; }
		public Flight? Flight { get; set; }

		public ICollection<FlightPayment>? Payments { get; set; }
	}
}
