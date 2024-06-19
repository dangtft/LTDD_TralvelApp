using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using TravelAPI.Interfaces;
using TravelAPI.Models;
using TravelAPI.DTOs;
using Microsoft.EntityFrameworkCore;
using TravelAPI.ViewModel;
using TravelAPI.Data;
namespace TravelAPI.Controllers
{
	[Route("api/[controller]")]
	[ApiController]
	[Produces("application/json")]
	public class HotelController : ControllerBase
	{
		private readonly IHotelRepository _hotelRepository;
		private readonly TravelDbContext _context;
		public HotelController(IHotelRepository hotelRepository,TravelDbContext context)
		{
			this._hotelRepository = hotelRepository;
			this._context = context;
		}

		// GET: api/Travel/hotels
		[HttpGet("hotels")]
		public async Task<ActionResult<List<Hotel>>> GetHotels()
		{
			try
			{
				var hotels = await _hotelRepository.GetAllHotel();
				return Ok(hotels);
			}
			catch (Exception ex)
			{
				return StatusCode(500, $"Internal server error: {ex.Message}");
			}
		}

		// GET: api/Travel/rooms
		[HttpGet("rooms")]
		public async Task<ActionResult<List<Room>>> GetRooms()
		{
			try
			{
				var rooms = await _hotelRepository.GetAllRooms();
				return Ok(rooms);
			}
			catch (Exception ex)
			{
				return StatusCode(500, $"Internal server error: {ex.Message}");
			}
		}

		// GET: api/Travel/hotels/{id}
		[HttpGet("hotels/{id}")]
		public async Task<ActionResult<Hotel>> GetHotelById(int id)
		{
			try
			{
				var hotel = await _hotelRepository.GetHotelById(id);
				if (hotel == null)
				{
					return NotFound($"Hotel with ID {id} not found");
				}
				return Ok(hotel);
			}
			catch (Exception ex)
			{
				return StatusCode(500, $"Internal server error: {ex.Message}");
			}
		}

		// GET: api/Travel/rooms/{id}
		[HttpGet("rooms/{id}")]
		public async Task<ActionResult<Room>> GetRoomById(int id)
		{
			try
			{
				var room = await _hotelRepository.GetRoomById(id);
				if (room == null)
				{
					return NotFound($"Room with ID {id} not found");
				}
				return Ok(room);
			}
			catch (Exception ex)
			{
				return StatusCode(500, $"Internal server error: {ex.Message}");
			}
		}

		// POST: api/Travel/login
		[HttpPost("login")]
		public async Task<ActionResult<User>> Login([FromBody] LoginRequest request)
		{
			try
			{
				var user = await _hotelRepository.LoginAsync(request.Email, request.Password);
				if (user == null)
				{
					return NotFound("Invalid email or password");
				}
				return Ok(user);
			}
			catch (Exception ex)
			{
				return StatusCode(500, $"Internal server error: {ex.Message}");
			}
		}

		// POST: api/Travel/register
		[HttpPost("register")]
		public async Task<ActionResult<User>> Register([FromBody] RegisterRequest request)
		{
			try
			{
				var newUser = await _hotelRepository.RegisterAsync(request.Name, request.Email, request.Phone, request.Address, request.Password);
				return CreatedAtAction(nameof(Register), newUser);
			}
			catch (Exception ex)
			{
				return StatusCode(500, $"Internal server error: {ex.Message}");
			}
		}

		// POST: api/Travel/bookhotel
		[HttpPost("bookhotel")]
		public async Task<ActionResult<HotelBookingDTO>> BookHotel([FromBody] HotelBookingDTO bookingDto)
		{
			try
			{
				var bookedHotel = await _hotelRepository.BookHotelAsync(bookingDto);
				return CreatedAtAction(nameof(BookHotel), bookedHotel);
			}
			catch (Exception ex)
			{
				return StatusCode(500, $"Internal server error: {ex.Message}");
			}
		}

		// POST: api/Travel/bookflight
		[HttpPost("bookflight")]
		public async Task<ActionResult<FlightBookingDTO>> BookFlight([FromBody] FlightBookingDTO bookingDto)
		{
			try
			{
				var bookedFlight = await _hotelRepository.BookFlightAsync(bookingDto);
				return CreatedAtAction(nameof(BookFlight), bookedFlight);
			}
			catch (Exception ex)
			{
				return StatusCode(500, $"Internal server error: {ex.Message}");
			}
		}

		// GET: api/Travel/flights
		[HttpGet("flights")]
		public async Task<ActionResult<List<Flight>>> GetFlights()
		{
			try
			{
				var flights = await _hotelRepository.GetFlightsAsync();
				return Ok(flights);
			}
			catch (Exception ex)
			{
				return StatusCode(500, $"Internal server error: {ex.Message}");
			}
		}

		// GET: api/Travel/flights/{id}
		[HttpGet("flights/{id}")]
		public async Task<ActionResult<Flight>> GetFlightById(int id)
		{
			try
			{
				var flight = await _hotelRepository.GetFlightById(id);
				if (flight == null)
				{
					return NotFound($"Flight with ID {id} not found");
				}
				return Ok(flight);
			}
			catch (Exception ex)
			{
				return StatusCode(500, $"Internal server error: {ex.Message}");
			}
		}

        [HttpGet("hotelbookings/{userId}")]
        public async Task<IActionResult> GetHotelBookingsByUserId(int userId)
        {
            try
            {
                var hotelBookings = await _hotelRepository.GetHotelBookingsByUserIdAsync(userId);
               
                return Ok(hotelBookings);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }
        [HttpGet("flightbookings/{userId}")]
        public async Task<IActionResult> GetFlightBookingsByUserId(int userId)
        {
            try
            {
                
                var flightBookings = await _hotelRepository.GetFlightBookingsByUserIdAsync(userId);
                return Ok(flightBookings);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [HttpGet("GetUser/{userId}")]
		public async Task<IActionResult> GetUserById(int userId)
		{
			try
			{
				var user = await _hotelRepository.GetUserById(userId);
				return Ok(user);
			}
			catch (Exception ex)
			{
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
		}

        [HttpPost("changePassword")]
        public async Task<IActionResult> ChangePassword([FromBody] ChangePasswordModel model)
        {
            try
            {
                var result = await _hotelRepository.ChangePasswordAsync(model.UserId, model.NewPassword);
                return Ok(new { success = result });
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, new { error = ex.Message });
            }
        }

        [HttpGet("{location}")]
        public async Task<ActionResult<IEnumerable<Hotel>>> GetHotelsByLocation(string location)
        {
            var hotels = await _hotelRepository.GetHotelsByLocationAsync(location);

            if (hotels == null || hotels.Count == 0)
            {
                return NotFound(new { Message = "No hotels found in the specified location." });
            }

            return Ok(hotels);
        }

        [HttpGet("flight/{location}")]
        public async Task<ActionResult<IEnumerable<Flight>>> GetFlightsByLocation(string location)
        {
            var flights = await _hotelRepository.GetFlightsByLocationAsync(location);

            if (flights == null || flights.Count == 0)
            {
                return NotFound(new { Message = "No flightls found in the specified location." });
            }

            return Ok(flights);
        }
    }


}
