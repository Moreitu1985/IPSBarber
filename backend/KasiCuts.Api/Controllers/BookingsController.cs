using KasiCuts.Api.Data;
using KasiCuts.Api.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authorization;

namespace KasiCuts.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    //[Authorize]
    public class BookingsController : ControllerBase
    {
        private readonly AppDbContext _context;

        public BookingsController(AppDbContext context)
        {
            _context = context;
        }

        // GET: api/Bookings
        [HttpGet]
        public async Task<ActionResult<List<Booking>>> GetBookings()
        {
            return await _context.Bookings.ToListAsync();
        }

        // POST: api/Bookings
        [HttpPost]
        public async Task<ActionResult<Booking>> AddBooking(Booking booking)
        {
            _context.Bookings.Add(booking);
            await _context.SaveChangesAsync();

            return Ok(booking);
        }

        // PUT: api/Bookings/5/accept =Successfully accepts a booking request
        [HttpPut("{id}/accept")]
        public async Task<IActionResult> AcceptBooking(int id)
        {
            var booking = await _context.Bookings.FindAsync(id);

            if (booking == null)
            {
                return NotFound();
            }

            booking.Status = "Accepted";

            await _context.SaveChangesAsync();

            return Ok(booking);
        }

        // PUT: api/Bookings/5/reject =REJECTS a booking request
        [HttpPut("{id}/reject")]
        public async Task<IActionResult> RejectBooking(int id)
        {
            var booking = await _context.Bookings.FindAsync(id);

            if (booking == null)
            {
                return NotFound();
            }

            booking.Status = "Rejected";

            await _context.SaveChangesAsync();

            return Ok(booking);
        }
    }
}