using TravelAPI.Models;

namespace TravelAPI.Interfaces
{
	public interface IHotelRepository
	{
		Task<List<Hotel>> GetAllHotel();
		Task<Hotel> GetHotelById(int id);

		Task<List<Room>> GetAllRooms();
		Task<Room> GetRoomById(int id);

		Task<List<Flight>> GetFlightsAsync();
		Task<Flight> GetFlightById(int id);
		Task<User> LoginAsync(string email, string password);
		Task<User> RegisterAsync(string name, string email, string phone, string address, string password);
		Task<HotelBooking> BookHotelAsync(HotelBooking booking);
		Task<FlightBooking> BookFlightAsync(FlightBooking booking);
	}
}
