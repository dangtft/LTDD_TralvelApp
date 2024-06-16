using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace TravelAPI.Models
{
	public class HotelBooking
	{
		[Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int BookingId { get; set; }
		public int? UserId { get; set; }
		public int? RoomId { get; set; }
		public DateTime? CheckInDate { get; set; }
		public DateTime? CheckOutDate { get; set; }
		public string? Status { get; set; }
		
		public User? User { get; set; }
		public Room? Room { get; set; }

		public ICollection<RoomPayment>? Payments { get; set; }
	}
}
