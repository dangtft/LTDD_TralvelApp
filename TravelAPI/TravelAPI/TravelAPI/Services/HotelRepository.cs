using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.EntityFrameworkCore;
using TravelAPI.Data;
using TravelAPI.DTOs;
using TravelAPI.Interfaces;
using TravelAPI.Models;
using TravelAPI.ViewModel;

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
		public async Task<HotelBookingDTO> BookHotelAsync(HotelBookingDTO bookingDto)
		{

            try
            {
                var booking = new HotelBooking
                {
                    UserId = bookingDto.UserId,
                    RoomId = bookingDto.RoomId,
                    CheckInDate = bookingDto.CheckInDate,
                    CheckOutDate = bookingDto.CheckOutDate,
                    Status = bookingDto.Status
                };

                _context.HotelBookings.Add(booking);
                await _context.SaveChangesAsync();

                return bookingDto;
            }
            catch (Exception ex)
            {
                throw new Exception($"Failed to book hotel: {ex.Message}");
            }
        }

		// Phương thức đặt vé máy bay
		public async Task<FlightBookingDTO> BookFlightAsync(FlightBookingDTO bookingDto)
		{

            try
            {
                var booking = new FlightBooking
                {
                    UserId = bookingDto.UserId,
                    FlightId = bookingDto.FlightId,
                    BookingDate = bookingDto.BookingDate,
                    Status = bookingDto.Status
                };

                _context.FlightsBookings.Add(booking);
                await _context.SaveChangesAsync();

                return bookingDto;
            }
            catch (Exception ex)
            {
                throw new Exception($"Failed to book hotel: {ex.Message}");
            }
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

        public async Task<List<HotelBookingDTO>> GetHotelBookingsByUserIdAsync(int userId)
        {
            return await _context.HotelBookings
                .Where(h => h.UserId == userId)
                .Select(h => new HotelBookingDTO
                {
                    UserId = h.UserId,
                    RoomId = h.RoomId,
                    CheckInDate = h.CheckInDate,
                    CheckOutDate = h.CheckOutDate,
                    Status = h.Status
                })
                .ToListAsync();
        }

        public async Task<List<FlightBookingDTO>> GetFlightBookingsByUserIdAsync(int userId)
        {
            return await _context.FlightsBookings
                .Where(f => f.UserId == userId)
                .Select(f => new FlightBookingDTO
                {
                    UserId = f.UserId,
                    FlightId = f.FlightId,
                    BookingDate = f.BookingDate,
                    Status = f.Status
                })
                .ToListAsync();
        }

        public async Task<User> GetUserById(int userId)
        {
            return await _context.Users.FirstAsync(u => u.UserId == userId);
        }
    }
}
