namespace TravelAPI.DTOs
{
    public class FlightBookedDTO
    {
        public int UserId { get; set; }
        public int? FlightId { get; set; }
        public DateTime? BookingDate { get; set; }
        public string? Status { get; set; }
        public string? FlightName { get; set; }
        public string? FlightImageUrl { get; set; }
    }
}
