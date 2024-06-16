using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using TravelAPI.Interfaces;
using TravelAPI.Models;
using TravelAPI.DTOs;
namespace TravelAPI.Controllers
{
	[Route("api/[controller]")]
	[ApiController]
	[Produces("application/json")]
	public class HotelController : ControllerBase
	{
		private readonly IHotelRepository _hotelRepository;
		public HotelController(IHotelRepository hotelRepository)
		{
			this._hotelRepository = hotelRepository;
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
		public async Task<ActionResult<HotelBooking>> BookHotel([FromBody] HotelBooking booking)
		{
			try
			{
				var bookedHotel = await _hotelRepository.BookHotelAsync(booking);
				return CreatedAtAction(nameof(BookHotel), bookedHotel);
			}
			catch (Exception ex)
			{
				return StatusCode(500, $"Internal server error: {ex.Message}");
			}
		}

		// POST: api/Travel/bookflight
		[HttpPost("bookflight")]
		public async Task<ActionResult<FlightBooking>> BookFlight([FromBody] FlightBooking booking)
		{
			try
			{
				var bookedFlight = await _hotelRepository.BookFlightAsync(booking);
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
	}


}
