using System.ComponentModel.DataAnnotations;

namespace TravelAPI.Models
{
	public class User
	{
		[Key] 
		public int UserId { get; set; }
		public string? Name { get; set; }
		public string? Email { get; set; }
		public string? Phone { get; set; }
		public string? Address { get; set; }
		public string? Password { get; set; }
		public DateTime CreatedAt { get; set; } = DateTime.Now;

		public ICollection<FlightBooking>? FlightBookings { get; set; }
		public ICollection<FlightPayment>? FlightPayments { get; set; }
		public ICollection<HotelBooking>? HotelBookings { get; set; }
		public ICollection<RoomPayment>? RoomPayments { get; set; }
	}
}
