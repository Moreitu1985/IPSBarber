using KasiCuts.Api.Models;
using Microsoft.EntityFrameworkCore;

namespace KasiCuts.Api.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options)
            : base(options)
        {
        }
        public DbSet<BarberWork> BarberWorks { get; set; }
        public DbSet<Product> Products { get; set; }
        public DbSet<Service> Services { get; set; }
        public DbSet<Booking> Bookings { get; set; }
        public DbSet<Barber> Barbers { get; set; }
        public DbSet<AppUser> AppUsers { get; set; }
    }
}