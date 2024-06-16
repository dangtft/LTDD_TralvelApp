﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using TravelAPI.Data;

#nullable disable

namespace TravelAPI.Migrations
{
    [DbContext(typeof(TravelDbContext))]
    partial class TravelDbContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "8.0.6")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder);

            modelBuilder.Entity("TravelAPI.Models.Flight", b =>
                {
                    b.Property<int>("FlightId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("FlightId"));

                    b.Property<int?>("DayFlight")
                        .HasColumnType("int");

                    b.Property<DateTime?>("DepartureTime")
                        .HasColumnType("datetime2");

                    b.Property<string>("Destination")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("FlightName")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("ImageUrl")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Location")
                        .HasColumnType("nvarchar(max)");

                    b.Property<decimal?>("Price")
                        .HasColumnType("decimal(18,2)");

                    b.Property<int?>("Ticket")
                        .HasColumnType("int");

                    b.HasKey("FlightId");

                    b.ToTable("Flights");
                });

            modelBuilder.Entity("TravelAPI.Models.FlightBooking", b =>
                {
                    b.Property<int>("FlightBookingId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("FlightBookingId"));

                    b.Property<DateTime?>("BookingDate")
                        .HasColumnType("datetime2");

                    b.Property<int?>("FlightId")
                        .HasColumnType("int");

                    b.Property<int?>("FlightId1")
                        .HasColumnType("int");

                    b.Property<string>("Status")
                        .HasColumnType("nvarchar(max)");

                    b.Property<int?>("UserId")
                        .HasColumnType("int");

                    b.Property<int?>("UserId1")
                        .HasColumnType("int");

                    b.HasKey("FlightBookingId");

                    b.HasIndex("FlightId");

                    b.HasIndex("FlightId1");

                    b.HasIndex("UserId");

                    b.HasIndex("UserId1");

                    b.ToTable("FlightsBookings");
                });

            modelBuilder.Entity("TravelAPI.Models.FlightPayment", b =>
                {
                    b.Property<int>("PaymentId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("PaymentId"));

                    b.Property<int?>("FlightBookingId")
                        .HasColumnType("int");

                    b.Property<DateTime?>("PaymentDate")
                        .HasColumnType("datetime2");

                    b.Property<string>("PaymentMethod")
                        .HasColumnType("nvarchar(max)");

                    b.Property<decimal?>("TotalPrice")
                        .HasColumnType("decimal(18,2)");

                    b.Property<int?>("UserId")
                        .HasColumnType("int");

                    b.Property<int?>("UserId1")
                        .HasColumnType("int");

                    b.HasKey("PaymentId");

                    b.HasIndex("FlightBookingId");

                    b.HasIndex("UserId");

                    b.HasIndex("UserId1");

                    b.ToTable("FlightsPayments");
                });

            modelBuilder.Entity("TravelAPI.Models.Hotel", b =>
                {
                    b.Property<int>("HotelId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("HotelId"));

                    b.Property<string>("HotelName")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("ImageUrl")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Information")
                        .HasColumnType("nvarchar(max)");

                    b.Property<bool?>("IsLike")
                        .HasColumnType("bit");

                    b.Property<string>("Location")
                        .HasColumnType("nvarchar(max)");

                    b.Property<decimal?>("Price")
                        .HasColumnType("decimal(18,2)");

                    b.Property<int?>("Rating")
                        .HasColumnType("int");

                    b.HasKey("HotelId");

                    b.ToTable("Hotels");
                });

            modelBuilder.Entity("TravelAPI.Models.HotelBooking", b =>
                {
                    b.Property<int>("BookingId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("BookingId"));

                    b.Property<DateTime?>("CheckInDate")
                        .HasColumnType("datetime2");

                    b.Property<DateTime?>("CheckOutDate")
                        .HasColumnType("datetime2");

                    b.Property<int?>("RoomId")
                        .HasColumnType("int");

                    b.Property<string>("Status")
                        .HasColumnType("nvarchar(max)");

                    b.Property<int?>("UserId")
                        .HasColumnType("int");

                    b.Property<int?>("UserId1")
                        .HasColumnType("int");

                    b.HasKey("BookingId");

                    b.HasIndex("RoomId");

                    b.HasIndex("UserId");

                    b.HasIndex("UserId1");

                    b.ToTable("HotelBookings");
                });

            modelBuilder.Entity("TravelAPI.Models.Room", b =>
                {
                    b.Property<int>("RoomId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("RoomId"));

                    b.Property<string>("Contact")
                        .HasColumnType("nvarchar(max)");

                    b.Property<int?>("HotelId")
                        .HasColumnType("int");

                    b.Property<string>("ImageUrl")
                        .HasColumnType("nvarchar(max)");

                    b.Property<int?>("NumberOfPeople")
                        .HasColumnType("int");

                    b.Property<decimal?>("Price")
                        .HasColumnType("decimal(18,2)");

                    b.Property<string>("PromoCode")
                        .HasColumnType("nvarchar(max)");

                    b.Property<int?>("Rating")
                        .HasColumnType("int");

                    b.Property<string>("RoomName")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("RoomSize")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Status")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("RoomId");

                    b.HasIndex("HotelId");

                    b.ToTable("Rooms");
                });

            modelBuilder.Entity("TravelAPI.Models.RoomPayment", b =>
                {
                    b.Property<int>("PaymentId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("PaymentId"));

                    b.Property<int?>("BookingId")
                        .HasColumnType("int");

                    b.Property<DateTime?>("PaymentDate")
                        .HasColumnType("datetime2");

                    b.Property<string>("PaymentMethod")
                        .HasColumnType("nvarchar(max)");

                    b.Property<decimal?>("TotalPrice")
                        .HasColumnType("decimal(18,2)");

                    b.Property<int?>("UserId")
                        .HasColumnType("int");

                    b.Property<int?>("UserId1")
                        .HasColumnType("int");

                    b.HasKey("PaymentId");

                    b.HasIndex("BookingId");

                    b.HasIndex("UserId");

                    b.HasIndex("UserId1");

                    b.ToTable("RoomPayments");
                });

            modelBuilder.Entity("TravelAPI.Models.User", b =>
                {
                    b.Property<int>("UserId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("UserId"));

                    b.Property<string>("Address")
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<string>("Email")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Name")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Password")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Phone")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("UserId");

                    b.ToTable("Users");
                });

            modelBuilder.Entity("TravelAPI.Models.FlightBooking", b =>
                {
                    b.HasOne("TravelAPI.Models.Flight", "Flight")
                        .WithMany()
                        .HasForeignKey("FlightId")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("TravelAPI.Models.Flight", null)
                        .WithMany("FlightBookings")
                        .HasForeignKey("FlightId1");

                    b.HasOne("TravelAPI.Models.User", "User")
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Restrict);

                    b.HasOne("TravelAPI.Models.User", null)
                        .WithMany("FlightBookings")
                        .HasForeignKey("UserId1");

                    b.Navigation("Flight");

                    b.Navigation("User");
                });

            modelBuilder.Entity("TravelAPI.Models.FlightPayment", b =>
                {
                    b.HasOne("TravelAPI.Models.FlightBooking", "FlightBooking")
                        .WithMany("Payments")
                        .HasForeignKey("FlightBookingId")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("TravelAPI.Models.User", "User")
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Restrict);

                    b.HasOne("TravelAPI.Models.User", null)
                        .WithMany("FlightPayments")
                        .HasForeignKey("UserId1");

                    b.Navigation("FlightBooking");

                    b.Navigation("User");
                });

            modelBuilder.Entity("TravelAPI.Models.HotelBooking", b =>
                {
                    b.HasOne("TravelAPI.Models.Room", "Room")
                        .WithMany("HotelBookings")
                        .HasForeignKey("RoomId")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("TravelAPI.Models.User", "User")
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Restrict);

                    b.HasOne("TravelAPI.Models.User", null)
                        .WithMany("HotelBookings")
                        .HasForeignKey("UserId1");

                    b.Navigation("Room");

                    b.Navigation("User");
                });

            modelBuilder.Entity("TravelAPI.Models.Room", b =>
                {
                    b.HasOne("TravelAPI.Models.Hotel", "Hotel")
                        .WithMany("Rooms")
                        .HasForeignKey("HotelId")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.Navigation("Hotel");
                });

            modelBuilder.Entity("TravelAPI.Models.RoomPayment", b =>
                {
                    b.HasOne("TravelAPI.Models.HotelBooking", "HotelBooking")
                        .WithMany("Payments")
                        .HasForeignKey("BookingId")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("TravelAPI.Models.User", "User")
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Restrict);

                    b.HasOne("TravelAPI.Models.User", null)
                        .WithMany("RoomPayments")
                        .HasForeignKey("UserId1");

                    b.Navigation("HotelBooking");

                    b.Navigation("User");
                });

            modelBuilder.Entity("TravelAPI.Models.Flight", b =>
                {
                    b.Navigation("FlightBookings");
                });

            modelBuilder.Entity("TravelAPI.Models.FlightBooking", b =>
                {
                    b.Navigation("Payments");
                });

            modelBuilder.Entity("TravelAPI.Models.Hotel", b =>
                {
                    b.Navigation("Rooms");
                });

            modelBuilder.Entity("TravelAPI.Models.HotelBooking", b =>
                {
                    b.Navigation("Payments");
                });

            modelBuilder.Entity("TravelAPI.Models.Room", b =>
                {
                    b.Navigation("HotelBookings");
                });

            modelBuilder.Entity("TravelAPI.Models.User", b =>
                {
                    b.Navigation("FlightBookings");

                    b.Navigation("FlightPayments");

                    b.Navigation("HotelBookings");

                    b.Navigation("RoomPayments");
                });
#pragma warning restore 612, 618
        }
    }
}
