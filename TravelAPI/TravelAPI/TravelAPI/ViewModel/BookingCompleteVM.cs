using TravelAPI.DTOs;

namespace TravelAPI.ViewModel
{
    public class BookingCompleteVM
    {
        public List<FlightBookingDTO> FlightBookings { get; set; }
        public List<HotelBookingDTO> HotelBookings { get; set; }
    }
}
