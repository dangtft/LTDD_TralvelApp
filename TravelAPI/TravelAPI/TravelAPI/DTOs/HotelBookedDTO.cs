namespace TravelAPI.DTOs
{
    public class HotelBookedDTO
    {
        public int? UserId { get; set; }
        public int? RoomId { get; set; }
        public DateTime? CheckInDate { get; set; }
        public DateTime? CheckOutDate { get; set; }
        public string? Status { get; set; }
        public string? RoomName { get; set; }
        public string? RoomImage { get; set; }
        public decimal? Price { get; set; }
        public string? HotelName { get; set; }
        public string? HotelImageUrl { get; set; }
    }
}
