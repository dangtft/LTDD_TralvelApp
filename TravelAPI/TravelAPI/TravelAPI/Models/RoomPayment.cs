using System.ComponentModel.DataAnnotations;

namespace TravelAPI.Models
{
	public class RoomPayment
	{
		[Key]
		public int PaymentId { get; set; }
		public int? BookingId { get; set; }
		public int? UserId { get; set; }
		public decimal? TotalPrice { get; set; }
		public DateTime? PaymentDate { get; set; } = DateTime.Now;
		public string? PaymentMethod { get; set; }

		public HotelBooking? HotelBooking { get; set; }
		public User? User { get; set; }
	}
}
