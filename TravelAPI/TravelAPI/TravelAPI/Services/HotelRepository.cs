using Microsoft.EntityFrameworkCore;
using TravelAPI.Data;
using TravelAPI.Interfaces;
using TravelAPI.Models;

namespace TravelAPI.Services
{
	public class HotelRepository : IHotelRepository
	{
		private readonly TravelDbContext _context;
		public HotelRepository(TravelDbContext context)
		{
			_context = context;
		}
		public async Task<List<Hotel>> GetAllHotel()
		{
			return await _context.Hotels.ToListAsync();
		}

		public async Task<List<Room>> GetAllRooms()
		{
			return await _context.Rooms.ToListAsync();
		}

		public async Task<Hotel> GetHotelById(int id)
		{
			return await _context.Hotels.FindAsync(id);
		}

		public async Task<Room> GetRoomById(int id)
		{
			return await _context.Rooms.FindAsync(id);
		}

		// Phương thức đăng nhập
		public async Task<User> LoginAsync(string email, string password)
		{
			return await _context.Users.FirstOrDefaultAsync(u => u.Email == email && u.Password == password);
		}

		// Phương thức đăng ký
		public async Task<User> RegisterAsync(string name, string email, string phone, string address, string password)
		{
			var newUser = new User
			{
				Name = name,
				Email = email,
				Phone = phone,
				Address = address,
				Password = password,
				CreatedAt = DateTime.Now
			};

			_context.Users.Add(newUser);
			await _context.SaveChangesAsync();
			return newUser;
		}

		// Phương thức đặt phòng khách sạn
		public async Task<HotelBooking> BookHotelAsync(HotelBooking booking)
		{
			_context.HotelBookings.Add(booking);
			await _context.SaveChangesAsync();
			return booking;
		}

		// Phương thức đặt vé máy bay
		public async Task<FlightBooking> BookFlightAsync(FlightBooking booking)
		{
			_context.FlightsBookings.Add(booking);
			await _context.SaveChangesAsync();
			return booking;
		}

		// Phương thức lấy danh sách các chuyến bay
		public async Task<List<Flight>> GetFlightsAsync()
		{
			return await _context.Flights.ToListAsync();
		}

		public async Task<Flight> GetFlightById(int id)
		{
			return await _context.Flights.FindAsync(id);
		}
	}
}
