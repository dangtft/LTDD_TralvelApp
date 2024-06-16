namespace TravelAPI.DTOs
{
    public class HotelBookingDTO
    {
        public int? UserId { get; set; }
        public int? RoomId { get; set; }
        public DateTime? CheckInDate { get; set; }
        public DateTime? CheckOutDate { get; set; }
        public string? Status { get; set; }
    }
}
