using System.ComponentModel.DataAnnotations;

namespace TravelAPI.Models
{
	public class FlightPayment
	{
		[Key]
		public int PaymentId { get; set; }
		public int? FlightBookingId { get; set; }
		public int? UserId { get; set; }
		public decimal? TotalPrice { get; set; }
		public DateTime? PaymentDate { get; set; }
		public string? PaymentMethod { get; set; }

		public FlightBooking? FlightBooking { get; set; }
		public User? User { get; set; }
	}
}
