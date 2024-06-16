using Microsoft.EntityFrameworkCore;
using Microsoft.Identity.Client;
using TravelAPI.Models;

namespace TravelAPI.Data
{
	public class TravelDbContext : DbContext
	{
		public TravelDbContext(DbContextOptions<TravelDbContext> options) : base(options)
		{
			
		}
		public DbSet<User> Users { get; set; }
		public DbSet<Flight> Flights { get; set; }
		public DbSet<FlightBooking> FlightsBookings { get; set; }
		public DbSet<FlightPayment> FlightsPayments { get; set; }
		public DbSet<Hotel> Hotels { get; set; }

		public DbSet<HotelBooking> HotelBookings { get; set; }
		public DbSet<Room> Rooms { get; set; }
		public DbSet<RoomPayment> RoomPayments { get; set; }
		

		protected override void OnModelCreating(ModelBuilder modelBuilder)
		{
			base.OnModelCreating(modelBuilder);
			// User - FlightBooking relationship
			modelBuilder.Entity<FlightBooking>()
				.HasOne(fb => fb.User)
				.WithMany()
				.HasForeignKey(fb => fb.UserId)
				.OnDelete(DeleteBehavior.Restrict);

			// User - FlightPayment relationship
			modelBuilder.Entity<FlightPayment>()
				.HasOne(fp => fp.User)
				.WithMany()
				.HasForeignKey(fp => fp.UserId)
				.OnDelete(DeleteBehavior.Restrict);

			// Flight - FlightBooking relationship
			modelBuilder.Entity<FlightBooking>()
				.HasOne(fb => fb.Flight)
				.WithMany()
				.HasForeignKey(fb => fb.FlightId)
				.OnDelete(DeleteBehavior.Cascade);

			// FlightBooking - FlightPayment relationship
			modelBuilder.Entity<FlightPayment>()
				.HasOne(fp => fp.FlightBooking)
				.WithMany(fb => fb.Payments)
				.HasForeignKey(fp => fp.FlightBookingId)
				.OnDelete(DeleteBehavior.Cascade);

			// User - HotelBooking relationship
			modelBuilder.Entity<HotelBooking>()
				.HasOne(hb => hb.User)
				.WithMany()
				.HasForeignKey(hb => hb.UserId)
				.OnDelete(DeleteBehavior.Restrict);

			// User - RoomPayment relationship
			modelBuilder.Entity<RoomPayment>()
				.HasOne(rp => rp.User)
				.WithMany()
				.HasForeignKey(rp => rp.UserId)
				.OnDelete(DeleteBehavior.Restrict);

			// Room - HotelBooking relationship
			modelBuilder.Entity<HotelBooking>()
				.HasOne(hb => hb.Room)
				.WithMany(r => r.HotelBookings)
				.HasForeignKey(hb => hb.RoomId)
				.OnDelete(DeleteBehavior.Cascade);

			// HotelBooking - RoomPayment relationship
			modelBuilder.Entity<RoomPayment>()
				.HasOne(rp => rp.HotelBooking)
				.WithMany(hb => hb.Payments)
				.HasForeignKey(rp => rp.BookingId)
				.OnDelete(DeleteBehavior.Cascade);

			// Hotel - Room relationship
			modelBuilder.Entity<Room>()
				.HasOne(r => r.Hotel)
				.WithMany(h => h.Rooms)
				.HasForeignKey(r => r.HotelId)
				.OnDelete(DeleteBehavior.Cascade);
			modelBuilder.Entity<Flight>()
	   .Property(f => f.Price)
	   .HasColumnType("decimal(18,2)");

			modelBuilder.Entity<FlightPayment>()
				.Property(fp => fp.TotalPrice)
				.HasColumnType("decimal(18,2)");

			modelBuilder.Entity<Hotel>()
				.Property(h => h.Price)
				.HasColumnType("decimal(18,2)");

			modelBuilder.Entity<Room>()
				.Property(r => r.Price)
				.HasColumnType("decimal(18,2)");

			modelBuilder.Entity<RoomPayment>()
				.Property(rp => rp.TotalPrice)
				.HasColumnType("decimal(18,2)");
		}
	}
}
