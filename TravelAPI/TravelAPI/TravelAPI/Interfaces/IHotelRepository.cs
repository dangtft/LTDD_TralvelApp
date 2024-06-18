using TravelAPI.DTOs;
using TravelAPI.Models;
using TravelAPI.ViewModel;

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
		Task<HotelBookingDTO> BookHotelAsync(HotelBookingDTO bookingDto);
		Task<FlightBookingDTO> BookFlightAsync(FlightBookingDTO bookingDtoS);
        Task<List<HotelBookedDTO>> GetHotelBookingsByUserIdAsync(int userId); 
        Task<List<FlightBookedDTO>> GetFlightBookingsByUserIdAsync(int userId);
		Task<User> GetUserById (int userId);
        Task<bool> ChangePasswordAsync(int userId, string newPassword);
    }
}
