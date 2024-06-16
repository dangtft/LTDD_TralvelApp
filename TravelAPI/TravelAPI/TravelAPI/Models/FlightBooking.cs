using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace TravelAPI.Models
{
	public class FlightBooking
	{
		[Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
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
