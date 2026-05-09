using KasiCuts.Api.Data;
using KasiCuts.Api.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace KasiCuts.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class BarbersController : ControllerBase
    {
        private readonly AppDbContext _context;

        public BarbersController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<List<Barber>>> GetBarbers()
        {
            return await _context.Barbers.ToListAsync();
        }

        [HttpPost]
        public async Task<ActionResult<Barber>> AddBarber(Barber barber)
        {
            _context.Barbers.Add(barber);
            await _context.SaveChangesAsync();

            return Ok(barber);
        }

        [HttpGet("{id}/bookings")]
        public async Task<ActionResult<List<Booking>>> GetBarberBookings(int id)
        {
            return await _context.Bookings
                .Where(b => b.BarberId == id)
                .ToListAsync();
        }
    }
}