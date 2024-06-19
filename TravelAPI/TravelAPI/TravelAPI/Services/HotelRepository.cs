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

                var flight = await _context.Flights.FindAsync(bookingDto.FlightId);

                if (flight == null)
                {
                    throw new Exception("Flight not found");
                }

                bookingDto.FlightName = flight.FlightName;
                bookingDto.FlightImageUrl = flight.ImageUrl;
                bookingDto.Location = flight.Location;
                bookingDto.Destination = flight.Destination;
                bookingDto.DepartureTime = flight.DepartureTime ?? default(DateTime);
                bookingDto.DayFlight = flight.DayFlight ?? 0;
                bookingDto.TotalPrice = (double)(flight.Price ?? 0);
                bookingDto.NumberOfTickets = flight.Ticket ?? 0;

                return bookingDto;
            }
            catch (Exception ex)
            {
                throw new Exception($"Failed to book flight: {ex.Message}");
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

        public async Task<List<HotelBookedDTO>> GetHotelBookingsByUserIdAsync(int userId)
        {
            return await _context.HotelBookings
        .Where(h => h.UserId == userId)
        .Select(h => new HotelBookedDTO
        {
            UserId = userId,
            RoomId = h.RoomId,
            CheckInDate = h.CheckInDate,
            CheckOutDate = h.CheckOutDate,
            Status = h.Status,
            HotelName = h.Room.Hotel.HotelName,
            RoomName = h.Room.RoomName,
            RoomImage = h.Room.ImageUrl,
            Price = h.Room.Price,
            HotelImageUrl = h.Room.Hotel.ImageUrl
        })
        .ToListAsync();
        }

        public async Task<List<FlightBookedDTO>> GetFlightBookingsByUserIdAsync(int userId)
        {
            return await _context.FlightsBookings
            .Where(f => f.UserId == userId)
         .Select(f => new FlightBookedDTO
         {
             UserId = userId,
             FlightId = f.FlightId,
             BookingDate = f.BookingDate,
             Status = f.Status,
             FlightName = f.Flight.FlightName,
             FlightImageUrl = f.Flight.ImageUrl
         })
         .ToListAsync();
        }

        public async Task<User> GetUserById(int userId)
        {
            return await _context.Users.FirstAsync(u => u.UserId == userId);
        }

        public async Task<bool> ChangePasswordAsync(int userId, string newPassword)
        {
            try
            {
                var user = await _context.Users.FindAsync(userId);

                if (user == null)
                {
                    throw new ArgumentException("User not found");
                }

                user.Password = newPassword;

                await _context.SaveChangesAsync();

                return true; 
            }
            catch (Exception ex)
            {
                throw new Exception($"Failed to change password: {ex.Message}");
            }
        }

        public async Task<List<Hotel>> GetHotelsByLocationAsync(string location)
        {
            return await _context.Hotels
                .Where(h => h.Location.Contains(location))
                .ToListAsync();
        }

        public async Task<List<Flight>> GetFlightsByLocationAsync(string location)
        {
            return await _context.Flights
                .Where(h => h.Destination.Contains(location))
                .ToListAsync();
        }

    }
}
