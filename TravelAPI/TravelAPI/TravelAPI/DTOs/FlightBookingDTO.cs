namespace TravelAPI.DTOs
{
    public class FlightBookingDTO
    {
        public int UserId { get; set; }
        public int FlightId { get; set; }
        public DateTime BookingDate { get; set; }
        public string Status { get; set; }
        public string FlightName { get; set; }
        public string FlightImageUrl { get; set; }
        public string Location { get; set; }
        public string Destination { get; set; }
        public double TotalPrice { get; set; }
        public DateTime DepartureTime { get; set; }
        public int DayFlight { get; set; }
        public int NumberOfTickets { get; set; }
    }
}
